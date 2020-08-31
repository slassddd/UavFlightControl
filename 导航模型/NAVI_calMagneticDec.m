function out = NAVI_calMagneticDec(varargin)
% NAVI_calMagneticDec(2020)
% 计算磁偏角插值数据
decimal_year = 2020;
if nargin == 1
    decimal_year = varargin{1};
    model_sel = 'igrfmagm';
elseif nargin == 2
    decimal_year = varargin{1};
    model_sel = varargin{2};
end
model_epoch_wrldmagm = '2015v2';
model_epoch_igrfmagm = 12;

step = 10;
geod_lat = linspace(-89,89,round(180/step));
geod_lon = linspace(-179,179,round(360/step));
height = 1e3;
magDec_wrldmagm = zeros(length(geod_lat),length(geod_lon));
magDec_igrfmagm = zeros(length(geod_lat),length(geod_lon));
magMagnitude_wrldmagm = zeros(length(geod_lat),length(geod_lon));
magMagnitude_igrfmagm = zeros(length(geod_lat),length(geod_lon));
% switch model_sel
%     case 'igrfmagm'
        for latIdx = 1:length(geod_lat)
            for lonIdx = 1:length(geod_lon)
                %% igrfmagm
                [xyz_igrfmagm, ~, magDec_igrfmagm(latIdx,lonIdx)] = igrfmagm(height, geod_lat(latIdx),geod_lon(lonIdx), decimal_year, model_epoch_igrfmagm);
                magMagnitude_igrfmagm(latIdx,lonIdx) = 1e-3*norm(xyz_igrfmagm); % uT
            end
        end
%     case 'wrldmagm'
        for latIdx = 1:length(geod_lat)
            for lonIdx = 1:length(geod_lon)
                %% wrldmagm
                [xyz_wrldmagm, ~, magDec_wrldmagm(latIdx,lonIdx)] = wrldmagm(height, geod_lat(latIdx),geod_lon(lonIdx), decimal_year, model_epoch_wrldmagm);
                magMagnitude_wrldmagm(latIdx,lonIdx) = 1e-3*norm(xyz_wrldmagm); % uT
            end
        end
% end
out.lat = geod_lat;
out.lon = geod_lon;
out.height = height;
switch model_sel
    case 'igrfmagm'
        out.magDec = magDec_igrfmagm;
        out.magMagnitude = magMagnitude_igrfmagm;
    otherwise
        out.magDec = magDec_wrldmagm;
        out.magMagnitude = magMagnitude_wrldmagm;        
end
sl = 1; % abs(magDec_igrfmagm - magDec_wrldmagm)./magDec_wrldmagm  ,  abs(magMagnitude_igrfmagm - magMagnitude_wrldmagm)./magMagnitude_wrldmagm
% TEST
if 0
    decimal_year = 2020;
    out = NAVI_calMagneticDec(decimal_year);
    step = 5;
    geod_lat = [0:step:60];
    geod_lon = [70:step:130];
    height = 0;
    magDec_wrldmagm = zeros(length(geod_lat),length(geod_lon));
    for latIdx = 1:length(geod_lat)
        for lonIdx = 1:length(geod_lon)
            [~, ~, magDec_wrldmagm(latIdx,lonIdx)] = wrldmagm(height, geod_lat(latIdx),geod_lon(lonIdx), decimal_year, '2015v2');
        end
    end
    [lat0,lon0] = meshgrid(out.lat,out.lon);
    [lat1,lon1] = meshgrid(geod_lat,geod_lon);
    magDec_interp = interpn(lon0,lat0,out.magDec',lon1,lat1);
    mesh((magDec_wrldmagm-magDec_interp'));
    xlabel('lat (deg)');
    ylabel('lon (deg)');
    zlabel('magDec interp error (deg)');
end