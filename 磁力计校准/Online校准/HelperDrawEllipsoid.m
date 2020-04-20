classdef HelperDrawEllipsoid < handle
%HELPERDRAWELLIPSOID Aids in Magnetic Calibration Example
%   This class is for internal use only. It may be removed in the future. 

%   Copyright 2018 The MathWorks, Inc.    

    methods (Static)
        function [ax1, ax2] = plotCalibrated(A,b,Bmag, data, dataCorrected, txt)
            % Plot calibrated and uncalibrated data on best fit ellipsoid and sphere.
    
            %Open a new figure window and create two subplots
            f = figure('NumberTitle', 'off', 'Name', txt);
            ax1 = subplot(1,2,1);
            set(ax1, 'Parent', f);

            %Use a helper function to plot the ellipsoid based on the correction
            %parameters. Create the ellipsoid matrix R from A that defines the
            %uncalibrated data:
            %   (m - b).' * R * (m - b) = Bmag*Bmag

            R = A.'*A; 
            HelperDrawEllipsoid.plotEllipsoid(R, b, Bmag);
            [rdi, rdo] = HelperDrawEllipsoid.drawPartitionedPoints(ax1, R,b,Bmag, data);
            title("Original Data and Best Fit Ellipsoid" + char(10) + "Using " + txt + " Fitter");
            
            % Plot the corrected data
            ax2 = subplot(1,2,2);
            set(ax2, 'Parent', f);
            %partition inside and outside sphere
            [fdi, fdo] = HelperDrawEllipsoid.drawPartitionedPoints(ax2, eye(3), zeros(3,1).', Bmag, dataCorrected);
            [xe,ye,ze] = ellipsoid(0,0,0,Bmag,Bmag,Bmag,80);
            fe = surf2patch(xe,ye,ze);
            HelperDrawEllipsoid.drawEllipsoid(fe);
    
            title('Corrected Data Fit to Ideal Sphere');
            if isempty(rdi) || isempty(rdo) || isempty(fdi) || isempty(fdo)
                leg =legend('Collected data (uT)', 'Location', 'South');
            else
                leg =legend('Data inside fit (uT)', 'Data outside fit (uT)', 'Location', 'South');
            end
            leg.Position(1) = 0.4; %move to the middle
            leg.Position(2) = 0.05;
            f.Position(3) = 700;

        end
        
        function compareBest(Agood, bgood,expMFSgood, Abad, bbad, expMFSbad, data)
            % Plot 'auto' fit (best) data vs data fit via 'diag'
            %   good - auto fit
            %   bad - diag fit
            xgoodFixed = (data - bgood)*Agood;
            
            f = figure('NumberTitle', 'off', 'Name', 'Correction with Auto vs Incorrect Fitter');
            ax1 = subplot(1,2,1);
            set(ax1, 'Parent', f);
            [rdi, rdo] = HelperDrawEllipsoid.drawPartitionedPoints(ax1,eye(3),zeros(1,3),expMFSgood, xgoodFixed);
            HelperDrawEllipsoid.plotEllipsoid(eye(3), zeros(1,3), expMFSgood);
            title("Corrected Magnetometer Data" + char(10) + 'Using Auto Fitter');
            
            xbadFixed = real((data - bbad)*Abad);
            ax2 = subplot(1,2,2);
            set(ax2, 'Parent', f);
            [fdi, fdo] = HelperDrawEllipsoid.drawPartitionedPoints(ax2, eye(3),zeros(1,3),expMFSbad, xbadFixed);
            HelperDrawEllipsoid.plotEllipsoid(eye(3), zeros(1,3), expMFSbad);
            title("Corrected Magnetometer Data" + char(10) + 'Using Incorrect Fitter');
            
            if isempty(rdi) || isempty(rdo) || isempty(fdi) || isempty(fdo)
                leg =legend('Collected data (uT)', 'Location', 'South');
            else
                leg =legend('Data inside fit (uT)', 'Data outside fit (uT)', 'Location', 'South');
            end
            leg.Position(1) = 0.4; %move to the middle
            leg.Position(2) = 0.05;
        end
        

        function [din, dout] = drawPartitionedPoints(ax, R,b, Bmag, data)
            % Color data in the plot based on whether or not it is inside or outside the fitted ellipsoid/sphere
            [din, dout] = HelperDrawEllipsoid.partitionEllipse(R, b, Bmag, data);
            hold(ax, 'on');
            plot3(ax, din(:,1),din(:,2),din(:,3),'LineStyle', 'none', 'MarkerSize', 6, 'MarkerFaceColor', 'b', 'Marker', 'o');
            plot3(ax, dout(:,1),dout(:,2),dout(:,3),'LineStyle', 'none', 'MarkerSize', 6, 'MarkerFaceColor', 'r', 'Marker', 'o');
            hold(ax, 'off');
            axis equal
            drawnow
        end

        function drawEllipsoid(fe)
            % Draws a green ellipsoid or sphere and lights it nicely
            p = patch(fe);
            p.FaceColor = 'green';
            p.EdgeColor = 'none';
            camlight
            view(3)
            p.FaceAlpha = .5;
            axis equal

        end

        function [dinside,doutside] = partitionEllipse(R, V, B, data)
            %figure out which of the  data is inside  and which is outside of the
            %computed ellipse.
            
            res = ellipsoidResidual(data, V,R,B);
            idx = res < 0;
            dinside = data(idx,:);
            doutside = data(~idx,:);
        end

        function p = plotEllipsoid(R, V, B)
            % Plots an ellipsoid based on (x-V).'*R*(x-V) = B^2 
            N = 20;
            %Singular values of R define the axes of the ellipsoid.
            %Strech the values out by 50% to make a nice plot.
            s = svd(R);
            s = 1.5*max(s);
            ax = linspace(-s*B, s*B, N)+V(1);
            ay = linspace(-s*B, s*B, N)+V(2);
            az = linspace(-s*B, s*B, N)+V(3);
            [xi,yi,zi] = meshgrid(ax,ay,az);
            d = [xi(:) yi(:) zi(:)];
            res = ellipsoidResidual(d, V, R, B);
            
            % Reshape to match xi - as if we did this element-by-element.
            Uout = reshape(res, size(xi));
            
            fv = isosurface(xi,yi,zi,Uout,0);
            HelperDrawEllipsoid.drawEllipsoid(fv);
        end

    end
end

function res = ellipsoidResidual(data, V, R, B)
% Compute the ellipsoid equation for each data row
% res = (data - V).' * R * (data - V) - B*B
%
dOffset = data - V;
t = R*(dOffset.');
res = (sum(dOffset.* (t.'),2) - B*B);

end



