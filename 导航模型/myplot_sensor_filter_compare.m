function myplot_sensor_filter_compare(sensors,filter,plotOpt,idx_color,idx_style,stepSpace)
%% ----------  组合导航输出  ----------
nrow = 8;
ncol = 3;
iplot = 0;
%

% 角速度
try
    time = sensors.IMU.time_imu;
    data{1} = [sensors.IMU.gx,sensors.IMU.gy,sensors.IMU.gz];
    data{2} = [sensors.IMU.gx,sensors.IMU.gy,sensors.IMU.gz]-...
        [filter.Algo.dWB_00,filter.Algo.dWB_11,filter.Algo.dWB_22];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        
        for i_data = 1:length(data)
            
            plot(time,data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_omegad{i})  % ylabel
            ylim(plotOpt.ylim_omegad);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end

% 加速度
try
    time = sensors.IMU.time_imu;
    data{1} = [sensors.IMU.ax,sensors.IMU.ay,sensors.IMU.az];
    data{2} = [sensors.IMU.ax,sensors.IMU.ay,sensors.IMU.az]-...
        [filter.Algo.dAB_00,filter.Algo.dAB_11,filter.Algo.dAB_22];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        
        for i_data = 1:length(data)
            
            plot(time,data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_AB_ms2{i})  % ylabel
            ylim(plotOpt.ylim_AB_ms2);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end
% 位置 LLA
try
    clear time data
    time{1} = sensors.GPS.time_ublox;
    time{2} = filter.Algo.time_algo;
    data{1} = [sensors.GPS.ublox_lat,sensors.GPS.ublox_lon,sensors.GPS.ublox_height];
    data{2} = [filter.Algo.algo_curr_pos_0,filter.Algo.algo_curr_pos_1,filter.Algo.algo_curr_pos_2];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        for i_data = 1:length(data)
            
            plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_lla{i})  % ylabel
            ylim(plotOpt.ylim_posm);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end
% 位置 XYZ
try
    clear time data
    time{1} = sensors.GPS.time_ublox;
    time{2} = filter.Algo.time_algo;    
    data{1} = [sensors.GPS.posmNED];
    filterLLA = [filter.Algo.algo_curr_pos_0,filter.Algo.algo_curr_pos_1,filter.Algo.algo_curr_pos_2];
    data{2} = lla2flat(filterLLA,filterLLA(1,1:2),0,filterLLA(1,3));
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        for i_data = 1:length(data)
            
            plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_posm{i})  % ylabel
            ylim(plotOpt.ylim_posm);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end
% 速度
try
    clear time data
    time{1} = sensors.GPS.time_ublox;
    time{2} = filter.Algo.time_algo;        
    data{1} = [sensors.GPS.ublox_velN,sensors.GPS.ublox_velE,sensors.GPS.ublox_velD];
    data{2} = [filter.Algo.algo_curr_vel_0,filter.Algo.algo_curr_vel_1,filter.Algo.algo_curr_vel_2];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        for i_data = 1:length(data)
            
            plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_velm{i})  % ylabel
            ylim(plotOpt.ylim_velm);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end 
% 磁矢量 1
try
    clear time data
    time{1} = sensors.Mag.time_mag;
    time{2} = filter.Algo.time_algo;       
    data{1} = 1e2*[sensors.Mag.mag1calib_x_magFrame,sensors.Mag.mag1calib_y_magFrame,sensors.Mag.mag1calib_z_magFrame];
    data{2} = [filter.Algo.magB_x,filter.Algo.magB_y,filter.Algo.magB_z];
    euler = [filter.Algo.algo_yaw,filter.Algo.algo_pitch,filter.Algo.algo_roll];
    quat = quaternion(euler,'eulerd','ZYX','frame');
    temp = rotateframe(quat,data{2});
    data{2} = rotateframe(conj(quat),data{2});
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        for i_data = 1:length(data)
            plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_magB_Gs{i})  % ylabel
            ylim(plotOpt.ylim_magB_Gs);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end
% 磁矢量 2
try
    clear time data
    time{1} = sensors.Mag.time_mag;
    time{2} = filter.Algo.time_algo;       
    data{1} = 1e2*[sensors.Mag.mag2calib_x_magFrame,sensors.Mag.mag2calib_y_magFrame,sensors.Mag.mag2calib_z_magFrame];
    data{2} = [filter.Algo.magB_x,filter.Algo.magB_y,filter.Algo.magB_z];
    euler = [filter.Algo.algo_yaw,filter.Algo.algo_pitch,filter.Algo.algo_roll];
    quat = quaternion(euler,'eulerd','ZYX','frame');
    temp = rotateframe(quat,data{2});
    data{2} = rotateframe(conj(quat),data{2});
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        for i_data = 1:length(data)
            plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_magB_Gs{i})  % ylabel
            ylim(plotOpt.ylim_magB_Gs);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end
% % 磁矢量 3
% try
%     clear time data
%     time{1} = sensors.Mag.time_mag;
%     time{2} = filter.Algo.time_algo;       
%     data{1} = 1e2*[sensors.Mag.mag3_x,sensors.Mag.mag3_y,sensors.Mag.mag3_z];
%     data{2} = [filter.Algo.magB_x,filter.Algo.magB_y,filter.Algo.magB_z];
%     euler = [filter.Algo.algo_yaw,filter.Algo.algo_pitch,filter.Algo.algo_roll];
%     quat = quaternion(euler,'eulerd','ZYX','frame');
%     temp = rotateframe(quat,data{2});
%     data{2} = rotateframe(conj(quat),data{2});
%     for i = 1:3
%         iplot = iplot + 1;
%         subplot(nrow,ncol,iplot)
%         for i_data = 1:length(data)
%             plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
%             hold(plotOpt.hold);
%             grid(plotOpt.grid);
%             xlabel(plotOpt.xlabel)
%             ylabel(plotOpt.ylabel_magB_Gs{i})  % ylabel
%             ylim(plotOpt.ylim_magB_Gs);        % ylim
%             xlim(plotOpt.xlim_time);          % xlim
%         end
%     end
% catch ME
%     sl = 1;
% end
% 气压高
try
    clear time data
    time{1} = sensors.Baro.time_baro;
    time{2} = filter.Algo.time_algo;       
    data{1} = sensors.Baro.altitue;
    data{2} = filter.Algo.algo_curr_pos_2;
    for i = 1:1
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        for i_data = 1:length(data)
            plot(time{i_data},data{i_data}(:,i),'color',plotOpt.color{idx_color+i_data-1},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
            hold(plotOpt.hold);
            grid(plotOpt.grid);
            xlabel(plotOpt.xlabel)
            ylabel(plotOpt.ylabel_posm{i})  % ylabel
            ylim(plotOpt.ylim_posm);        % ylim
            xlim(plotOpt.xlim_time);          % xlim
        end
    end
catch ME
    sl = 1;
end