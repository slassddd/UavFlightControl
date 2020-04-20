classdef UAVPlotLib
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        plotOpt
    end
    
    methods
        function obj = UAVPlotLib()
            %UNTITLED 构造此类的实例
            obj.plotOpt = setPlotOpt;
        end
        function PlotPosition(obj,sensorNames,sensors,mode,idx_color,idx_style,varargin)
            % ----------  传感器输出  ----------
            nNames = length(sensorNames);
            if ~isempty(varargin)
                fig = varargin{1};
                str = ['平面地图'];
                try
                    fig.Name = str;
                catch
                    fig = figure;
                    fig.Name = str;
                end
            end
            for i = 1:nNames
                multiplot = 0;
                if contains(lower(sensorNames{i}),';')
                    multiplot = 1;
                    multiNames = splitNames(sensorNames{i});
                end        
                if multiplot
                    for i_m = 1:length(multiNames)
                        switch lower(mode)
                            case 'xy'
                                plot_XYZ(multiNames{i_m},sensors,mode,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1)
                            case 'xyz'
                        end
                    end
                else
                    plot_XYZ(sensorNames{i},sensors,mode,obj.plotOpt,idx_color,idx_style)
                end
            end
            for i_plot = 1:2
                subplot(1,2,i_plot)
                str = ['legend('];
                for i = 1:length(multiNames)
                    str = [str,'multiNames{',num2str(i),'},'];
                end
                str(end) = [];
                str = [str,')'];
                eval(str);
            end
        end
        function PlotSensor(obj,sensorNames,sensors,idx_color,idx_style,varargin)
            % ----------  传感器输出  ----------
            nNames = length(sensorNames);
            if ~isempty(varargin)
                
                fig = varargin{1};
                str = '';
                for i = 1:nNames
                    str = [str,'  ',sensorNames{i}];
                end
                try
                    fig.Name = ['传感器测量值:',str];
                catch
                    fig = figure;
                    fig.Name = ['传感器测量值:',str];
                end
            end
            nrow = 0;
            iplot = 0;
            for i = 1:nNames
                multiplot = 0;
                if contains(lower(sensorNames{i}),';')
                    multiplot = 1;
                    multiNames = splitNames(sensorNames{i});
                end
                
                if contains(lower(sensorNames{i}),'imu')
                    nrow = nrow + 2;
                elseif contains(lower(sensorNames{i}),'mag')
                    nrow = nrow + 1;
                elseif contains(lower(sensorNames{i}),'ublox')
                    nrow = nrow + 2;
                elseif contains(lower(sensorNames{i}),'um482')
                    nrow = nrow + 2;
                elseif contains(lower(sensorNames{i}),'radar')
                    nrow = nrow + 1/3;
                elseif contains(lower(sensorNames{i}),'baro')
                    nrow = nrow + 1/3;
                elseif contains(lower(sensorNames{i}),'airspeed')
                    nrow = nrow + 1/3;
                end
                %     end
            end
            nrow = ceil(nrow);
            %
            
            for i = 1:nNames
                multiplot = 0;
                if contains(lower(sensorNames{i}),';')
                    multiplot = 1;
                    multiNames = splitNames(sensorNames{i});
                end
                if multiplot
                    temp = iplot;
                    for i_m = 1:length(multiNames)
                        if contains(lower(sensorNames{i}),'imu')
                            iplot = plot_imu(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        elseif contains(lower(multiNames{i_m}),'mag')
                            iplot = plot_mag(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        elseif contains(lower(multiNames{i_m}),'ublox')
                            iplot = plot_ublox(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        elseif contains(lower(multiNames{i_m}),'um482')
                            iplot = plot_ublox(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        elseif contains(lower(multiNames{i_m}),'radar')
                            iplot = plot_radar(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        elseif contains(lower(multiNames{i_m}),'baro')
                            iplot = plot_baro(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        elseif contains(lower(multiNames{i_m}),'airspeed')
                            iplot = plot_airspeed(temp,multiNames{i_m},sensors,obj.plotOpt,idx_color+i_m-1,idx_style+i_m-1,nrow);
                        end
                    end
                else
                    if contains(lower(sensorNames{i}),'imu')
                        iplot = plot_imu(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    elseif contains(lower(sensorNames{i}),'mag')
                        iplot = plot_mag(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    elseif contains(lower(sensorNames{i}),'ublox')
                        iplot = plot_ublox(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    elseif contains(lower(sensorNames{i}),'um482')
                        iplot = plot_ublox(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    elseif contains(lower(sensorNames{i}),'radar')
                        iplot = plot_radar(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    elseif contains(lower(sensorNames{i}),'baro')
                        iplot = plot_baro(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    elseif contains(lower(sensorNames{i}),'airspeed')
                        iplot = plot_airspeed(iplot,sensorNames{i},sensors,obj.plotOpt,idx_color,idx_style,nrow);
                    end
                end
            end
        end
    end
end

%% 子函数
function plotOpt = setPlotOpt()
plotOpt.stepSpace = 1;
plotOpt.color = {'k','r','b','g','y','c',...
    [0 0.4470 0.7410], [0.8500 0.3250 0.0980], [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],...
    [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330],[0.6350 0.0780 0.1840]};
plotOpt.linewidth = 0.7;
plotOpt.linestyle = {'--','-','-.',':'};
plotOpt.hold = 'on'; % 'on'  'off'
plotOpt.grid = 'on'; % 'on'  'off'
plotOpt.xlabel = {'time [s]'};
plotOpt.ylabel_eulerd = {'yaw [deg]','pitch [deg]','roll [deg]'};
plotOpt.ylabel_omegad = {'wx [deg/s]','wy [deg/s]','wz [deg/s]'};
plotOpt.ylabel_AB_ms2 = {'ABx [m/s^2]','ABy [m/s^2]','ABz [m/s^2]'};
plotOpt.ylabel_posm = {'Pn [m]','Pe [m]','Pd [m]'};
plotOpt.ylabel_lla = {'lat [deg]','lon [deg]','height [m]'};
plotOpt.ylabel_velm = {'Vn [m/s]','Ve [m/s]','Vd [m/s]'};
plotOpt.ylabel_speedm = {'air speed [m/s]'};
plotOpt.ylabel_dAB_ms2 = {'dABx [m/s^2]','dABy [m/s^2]','dABz [m/s^2]'};
plotOpt.ylabel_dWB_degs = {'dWBx [deg/s]','dWBy [deg/s]','dWBz [deg/s]'};
plotOpt.ylabel_magB_Gs = {'magBx [G]','magBy [G]','magBz [G]'};
plotOpt.ylabel_magB_uT = {'magBx [uT]','magBy [uT]','magBz [uT]'};
plotOpt.ylabel_dMagB_Gs = {'dMagB [uT]','dMagB [uT]','dMagB [uT]'};
plotOpt.ylim_eulerd = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_omegad = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_AB_ms2 = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_posm = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_velm = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_dAB_ms2 = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_dWB_degs = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_magB_Gs = 'auto'; %  [-50,50] or 'auto'
plotOpt.ylim_dMagB_Gs = 'auto'; %  [-50,50] or 'auto'
plotOpt.xlim_time = 'auto'; % or 'auto'
end
% IMU -------------------------------------------------------------------
function iplot = plot_imu(iplot,sensorName,sensors,plotOpt,idx_color,idx_style,nrow)
% 加速度
data = [sensors.(sensorName).accel_x,sensors.(sensorName).accel_y,sensors.(sensorName).accel_z];
time = sensors.(sensorName).time;
stepNum = size(data,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_AB_ms2{i})  % ylabel
    ylim(plotOpt.ylim_AB_ms2);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
% 角速度
data = [sensors.(sensorName).gyro_x,sensors.(sensorName).gyro_y,sensors.(sensorName).gyro_z];
time = sensors.(sensorName).time;
stepNum = size(data,1);
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_omegad{i})  % ylabel
    ylim(plotOpt.ylim_omegad);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
end

% Mag -------------------------------------------------------------------
function iplot = plot_mag(iplot,sensorName,sensors,plotOpt,idx_color,idx_style,nrow)
% 磁力计
data = [sensors.(sensorName).mag_x,sensors.(sensorName).mag_y,sensors.(sensorName).mag_z];
time = sensors.(sensorName).time;
stepNum = size(data,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    magNorm = norm(mean(data(1:100:end,:))) ;
    if magNorm > 5 && magNorm < 200
        ylabel(plotOpt.ylabel_magB_uT{i})  % ylabel
        ylim(plotOpt.ylim_magB_uT);        % ylim
    else
        ylabel(plotOpt.ylabel_magB_Gs{i})  % ylabel
        ylim(plotOpt.ylim_magB_Gs);        % ylim
    end
    xlim(plotOpt.xlim_time);          % xlim
end
end

% ublox -------------------------------------------------------------------
function iplot = plot_ublox(iplot,sensorName,sensors,plotOpt,idx_color,idx_style,nrow)
% LLA
data = [sensors.(sensorName).Lat,sensors.(sensorName).Lon,sensors.(sensorName).height];
time = sensors.(sensorName).time;
stepNum = size(data,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_lla{i})  % ylabel
    ylim(plotOpt.ylim_posm);        % ylim
    xlim(plotOpt.xlim_time);        % xlim
end
% gpsvel
data = [sensors.(sensorName).velN,sensors.(sensorName).velE,sensors.(sensorName).velD];
time = sensors.(sensorName).time;
stepNum = size(data,1);
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_velm{i})  % ylabel
    ylim(plotOpt.ylim_velm);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
end
% baro1 -------------------------------------------------------------------
function iplot = plot_baro(iplot,sensorName,sensors,plotOpt,idx_color,idx_style,nrow)
data = [sensors.(sensorName).alt_baro];
time = sensors.(sensorName).time;
stepNum = size(data,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_lla{3})  % ylabel
    ylim(plotOpt.ylim_posm);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
end
% radar -------------------------------------------------------------------
function iplot = plot_radar(iplot,sensorName,sensors,plotOpt,idx_color,idx_style,nrow)
% 雷达高度
data = [sensors.(sensorName).Range];
time = sensors.(sensorName).time;
stepNum = size(data,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_lla{3})  % ylabel
    ylim(plotOpt.ylim_posm);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
end
% airspeed -------------------------------------------------------------------
function iplot = plot_airspeed(iplot,sensorName,sensors,plotOpt,idx_color,idx_style,nrow)
% 空速
data = [sensors.(sensorName).airspeed];
time = sensors.(sensorName).time;
stepNum = size(data,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
for i = 1:size(data,2)
    iplot = iplot + 1;
    subplot(nrow,3,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_speedm)  % ylabel
    ylim(plotOpt.ylim_posm);        % ylim
    xlim(plotOpt.xlim_time);        % xlim
end
end

% 绘制XY -------------------------------------------------------------------
function plot_XYZ(sensorName,sensors,mode,plotOpt,idx_color,idx_style)
% LLA
data_LLA = [sensors.(sensorName).Lat,sensors.(sensorName).Lon,sensors.(sensorName).height];
data_LLA(data_LLA(:,1)==0,:) = [];
data_LLA0 = data_LLA(1,:);
data_NED = lla2flat(data_LLA,data_LLA0(1:2),0,0);
time = sensors.(sensorName).time;
stepNum = size(data_LLA,1);
stepSpace = plotOpt.stepSpace;
idxspan = [1:stepSpace:stepNum];
data_LLA = data_LLA(idxspan,:);
data_NED = data_NED(idxspan,:);
data_LLA(data_LLA(:,1)==0,:) = [];
data_NED(data_NED(:,1)==0,:) = [];
switch lower(mode)
    case 'xy'
        subplot(1,2,1) % Lon Lat
        plot(data_LLA(:,2),data_LLA(:,1),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.ylabel_lla{2})
        ylabel(plotOpt.ylabel_lla{1})  % ylabel
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.ylim_posm);        % xlim
        axis equal
        subplot(1,2,2) % PE PN
        plot(data_NED(:,2),data_NED(:,1),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.ylabel_posm{2})
        ylabel(plotOpt.ylabel_posm{1})  % ylabel
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.ylim_posm);        % xlim
        axis equal
    case 'xyz'
        subplot(1,2,1) % Lon Lat
        plot3(data_LLA(:,2),data_LLA(:,1),data_LLA(:,3),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.ylabel_lla{2})
        ylabel(plotOpt.ylabel_lla{1})  % ylabel
        zlabel(plotOpt.ylabel_lla{3})  
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.ylim_posm);        % xlim
        axis equal
        subplot(1,2,2) % PE PN
        plot3(data_NED(:,2),data_NED(:,1),-data_NED(:,3),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.ylabel_posm{2})
        ylabel(plotOpt.ylabel_posm{1})  
        zlabel(plotOpt.ylabel_lla{3})  
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.ylim_posm);        % xlim
        axis equal        
end

end
% -------------------------------------------------------------------
function out = splitNames(names)
if contains(names,';')
    idxs = strfind(names,';');
    nName = length(idxs) + 1;
    idxs(2:end+1) = idxs;
    idxs(1) = 0;
    idxs(end+1) = length(names)+1;
    for i = 1:nName
        out{i} = strrep(names(idxs(i)+1:idxs(i+1)-1),' ','');
    end
end
end

