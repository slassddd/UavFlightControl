function myplot_sensor(sensors,plotOpt,idx_color,idx_style,stepSpace,varargin)
%% ----------  传感器输出  ----------
if nargin == 2
    figureNum = varargin{1};
    figureName = varargin{2};
    fid = figure(figureNum);
    fid.Name = figureName;
end
nrow = 7;
ncol = 3;
iplot = 0;
sensorSet = {'imu','gyro','acc','mag','gps','baro','radar'};
sensorNames = fieldnames(sensors(1));
flag = isSensorExist(sensorNames,sensorSet);
% 加速度
if flag.imu
    data = [sensors.IMU.ax,sensors.IMU.ay,sensors.IMU.az];
    time = sensors.IMU.time_imu;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_AB_ms2{i})  % ylabel
        ylim(plotOpt.ylim_AB_ms2);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 角速度
if flag.imu
    data = [sensors.IMU.gx,sensors.IMU.gy,sensors.IMU.gz];
    time = sensors.IMU.time_imu;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_omegad{i})  % ylabel
        ylim(plotOpt.ylim_omegad);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 磁矢量
if flag.mag
    data = [sensors.Mag.mag3_x,sensors.Mag.mag3_y,sensors.Mag.mag3_z];
    time = sensors.Mag.time_mag;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_magB_Gs{i})  % ylabel
        ylim(plotOpt.ylim_magB_Gs);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 位置 LLA
if flag.gps
    data = [sensors.GPS.ublox_lat,sensors.GPS.ublox_lon,sensors.GPS.ublox_height];
    time = sensors.GPS.time_ublox;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_lla{i})  % ylabel
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 位置 NED
if flag.gps
    data = [sensors.GPS.ublox_lat,sensors.GPS.ublox_lon,sensors.GPS.ublox_height];
    data0 = data(1,:);
    data = lla2flat(data,data0(1:2),0,0);
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_posm{i})  % ylabel
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 速度
if flag.gps
    data = [sensors.GPS.ublox_velN,sensors.GPS.ublox_velE,sensors.GPS.ublox_velD];
    time = sensors.GPS.time_ublox;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_velm{i})  % ylabel
        ylim(plotOpt.ylim_velm);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 气压高度
if flag.radar
    data = [sensors.Radar.radar_Range];
    time = sensors.Radar.time_radar;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_lla(3))  % ylabel
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
% 无线电高度
if flag.baro
    data = [sensors.Baro.altitue];
    time = sensors.Baro.time_baro;
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:size(data,2)
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_lla{3})  % ylabel
        ylim(plotOpt.ylim_posm);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
end
end
function flag = isSensorExist(sensorNames,sensorSet)
% sensorSet = {'imu','gyro','acc','mag','gps','baro','radar'};
% sensorNames = fieldnames(sensors(1));
for j = 1:length(sensorSet)
    flag.(sensorSet{j}) = 0;
    for i = 1:length(sensorNames)
        if strcmp(lower(sensorNames{i}),sensorSet{j})
            flag.(sensorSet{j}) = 1;
        end
    end
end
end
