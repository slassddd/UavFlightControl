function postplot_marg_flightdata(sensors,plotOpt,idx_color,idx_style,stepSpace)
%% ----------  组合导航输出  ----------
nrow = 8;
ncol = 3;
iplot = 0;
%
time = sensors.Algo.time_algo;
stepNum = size(time,1);
idxspan = [1:stepSpace:stepNum];
% 欧拉角
data = [sensors.Algo.algo_yaw,sensors.Algo.algo_pitch,sensors.Algo.algo_roll];
for i = 1:3
    iplot = iplot + 1;
    subplot(nrow,ncol,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_eulerd{i})  % ylabel
    ylim(plotOpt.ylim_eulerd);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
% 角速度
try
    data = [sensors.IMU.gx,sensors.IMU.gy,sensors.IMU.gz];
    for i = 1:3
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
% 位置 LLA
try
    data = [sensors.Algo.algo_curr_pos_0,sensors.Algo.algo_curr_pos_1,sensors.Algo.algo_curr_pos_2];
    tempZeroData = data(data(:,1)==0,:);
    data(data(:,1)==0,:) = nan*tempZeroData;    
    for i = 1:3
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
% 位置 XYZ
try
    data = [sensors.Algo.algo_curr_pos_0,sensors.Algo.algo_curr_pos_1,sensors.Algo.algo_curr_pos_2];
    tempZeroData = data(data(:,1)==0,:);
    data(data(:,1)==0,:) = nan*tempZeroData;
    tempZeroNum = size(tempZeroData,1);
    data(tempZeroNum+1:end,:) = lla2flat(data(tempZeroNum+1:end,:),data(tempZeroNum+1,1:2),0,0);
    for i = 1:3
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
catch ME
    fprintf('XYZ位置绘图出错，跳过')
end
% 速度
try
    data = [sensors.Algo.algo_curr_vel_0,sensors.Algo.algo_curr_vel_1,sensors.Algo.algo_curr_vel_2];
    for i = 1:3
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
% 加速度偏差
data = [sensors.Algo.dAB_00,sensors.Algo.dAB_11,sensors.Algo.dAB_22];  % 理解可能有问题
for i = 1:3
    iplot = iplot + 1;
    subplot(nrow,ncol,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_dAB_ms2{i})  % ylabel
    ylim(plotOpt.ylim_dAB_ms2);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
% 角速度偏差
data = [sensors.Algo.dWB_00,sensors.Algo.dWB_11,sensors.Algo.dWB_22];  % 理解可能有问题
for i = 1:3
    iplot = iplot + 1;
    subplot(nrow,ncol,iplot)
    plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
    hold(plotOpt.hold);
    grid(plotOpt.grid);
    xlabel(plotOpt.xlabel)
    ylabel(plotOpt.ylabel_dWB_degs{i})  % ylabel
    ylim(plotOpt.ylim_dWB_degs);        % ylim
    xlim(plotOpt.xlim_time);          % xlim
end
% 磁矢量
try
    data = [sensors.Algo.magB_x,sensors.Algo.magB_y,sensors.Algo.magB_z];
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:3
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
% 磁矢量偏差
try
    data = [sensors.Algo.dmagB_x,sensors.Algo.dmagB_y,sensors.Algo.dmagB_z];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(plotOpt.ylabel_dMagB_Gs{i})  % ylabel
        ylim(plotOpt.ylim_magB_Gs);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
    end
catch ME
    sl = 1;
end


