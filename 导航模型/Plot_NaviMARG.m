function Plot_NaviMARG(naviRes,idx_color,idx_style,stepSpace)
global GLOBAL_PARAM
%% ----------  组合导航输出  ----------
nrow = 8;
ncol = 3;
iplot = 0;
%
time = naviRes.time;
if length(time) > length(naviRes.lat)
    time(end) = []; 
end
stepNum = size(time,1);
idxspan = [1:stepSpace:stepNum];
% 欧拉角
data = [naviRes.yawd,naviRes.pitchd,naviRes.rolld];
for i = 1:3
    iplot = iplot + 1;
    subplot(nrow,ncol,iplot)
    plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
    hold(GLOBAL_PARAM.plotOpt.hold);
    grid(GLOBAL_PARAM.plotOpt.grid);
    xlabel(GLOBAL_PARAM.plotOpt.xlabel)
    ylabel(GLOBAL_PARAM.plotOpt.ylabel_eulerd{i})  % ylabel
    ylim(GLOBAL_PARAM.plotOpt.ylim_eulerd);        % ylim
    xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
end
% 角速度
try
    data = [naviRes.IMU.gx,naviRes.IMU.gy,naviRes.IMU.gz];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
        hold(GLOBAL_PARAM.plotOpt.hold);
        grid(GLOBAL_PARAM.plotOpt.grid);
        xlabel(GLOBAL_PARAM.plotOpt.xlabel)
        ylabel(GLOBAL_PARAM.plotOpt.ylabel_omegad{i})  % ylabel
        ylim(GLOBAL_PARAM.plotOpt.ylim_omegad);        % ylim
        xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
    end
end
% 位置 LLA
try
    data = [naviRes.lat,naviRes.lon,naviRes.alt];
    tempZeroData = data(data(:,1)==0,:);
    data(data(:,1)==0,:) = nan*tempZeroData;    
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
        hold(GLOBAL_PARAM.plotOpt.hold);
        grid(GLOBAL_PARAM.plotOpt.grid);
        xlabel(GLOBAL_PARAM.plotOpt.xlabel)
        ylabel(GLOBAL_PARAM.plotOpt.ylabel_lla{i})  % ylabel
        ylim(GLOBAL_PARAM.plotOpt.ylim_posm);        % ylim
        xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
    end
end
% 位置 XYZ
try
    data = [naviRes.lat,naviRes.lon,naviRes.alt];
    tempZeroData = data(data(:,1)==0,:);
    data(data(:,1)==0,:) = nan*tempZeroData;
    tempZeroNum = size(tempZeroData,1);
    data(tempZeroNum+1:end,:) = lla2flat(data(tempZeroNum+1:end,:),data(tempZeroNum+1,1:2),0,0);
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
        hold(GLOBAL_PARAM.plotOpt.hold);
        grid(GLOBAL_PARAM.plotOpt.grid);
        xlabel(GLOBAL_PARAM.plotOpt.xlabel)
        ylabel(GLOBAL_PARAM.plotOpt.ylabel_posm{i})  % ylabel
        ylim(GLOBAL_PARAM.plotOpt.ylim_posm);        % ylim
        xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
    end
catch ME
    fprintf('XYZ位置绘图出错，跳过\n')
end
% 速度
try
    data = [naviRes.velN,naviRes.velE,naviRes.velD];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
        hold(GLOBAL_PARAM.plotOpt.hold);
        grid(GLOBAL_PARAM.plotOpt.grid);
        xlabel(GLOBAL_PARAM.plotOpt.xlabel)
        ylabel(GLOBAL_PARAM.plotOpt.ylabel_velm{i})  % ylabel
        ylim(GLOBAL_PARAM.plotOpt.ylim_velm);        % ylim
        xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
    end
end
% 加速度偏差
data = [naviRes.dABx,naviRes.dABy,naviRes.dABz];  % 理解可能有问题
for i = 1:3
    iplot = iplot + 1;
    subplot(nrow,ncol,iplot)
    plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
    hold(GLOBAL_PARAM.plotOpt.hold);
    grid(GLOBAL_PARAM.plotOpt.grid);
    xlabel(GLOBAL_PARAM.plotOpt.xlabel)
    ylabel(GLOBAL_PARAM.plotOpt.ylabel_dAB_ms2{i})  % ylabel
    ylim(GLOBAL_PARAM.plotOpt.ylim_dAB_ms2);        % ylim
    xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
end
% 角速度偏差
data = [naviRes.dGBx,naviRes.dGBy,naviRes.dGBz];  % 理解可能有问题
for i = 1:3
    iplot = iplot + 1;
    subplot(nrow,ncol,iplot)
    plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
    hold(GLOBAL_PARAM.plotOpt.hold);
    grid(GLOBAL_PARAM.plotOpt.grid);
    xlabel(GLOBAL_PARAM.plotOpt.xlabel)
    ylabel(GLOBAL_PARAM.plotOpt.ylabel_dWB_degs{i})  % ylabel
    ylim(GLOBAL_PARAM.plotOpt.ylim_dWB_degs);        % ylim
    xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
end
% 磁矢量
try
    data = [naviRes.magNEDx,naviRes.magNEDy,naviRes.magNEDz];
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
        hold(GLOBAL_PARAM.plotOpt.hold);
        grid(GLOBAL_PARAM.plotOpt.grid);
        xlabel(GLOBAL_PARAM.plotOpt.xlabel)
        ylabel(GLOBAL_PARAM.plotOpt.ylabel_magB_Gs{i})  % ylabel
        ylim(GLOBAL_PARAM.plotOpt.ylim_magB_Gs);        % ylim
        xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
    end
end
% 磁矢量偏差
try
    data = [naviRes.dmagBx,naviRes.dmagBy,naviRes.dmagBz];
    for i = 1:3
        iplot = iplot + 1;
        subplot(nrow,ncol,iplot)
        plot(time(idxspan),data(idxspan,i),'color',GLOBAL_PARAM.plotOpt.color{idx_color},'linewidth',GLOBAL_PARAM.plotOpt.linewidth(1),'linestyle',GLOBAL_PARAM.plotOpt.linestyle{idx_style});
        hold(GLOBAL_PARAM.plotOpt.hold);
        grid(GLOBAL_PARAM.plotOpt.grid);
        xlabel(GLOBAL_PARAM.plotOpt.xlabel)
        ylabel(GLOBAL_PARAM.plotOpt.ylabel_dMagB_Gs{i})  % ylabel
        ylim(GLOBAL_PARAM.plotOpt.ylim_magB_Gs);        % ylim
        xlim(GLOBAL_PARAM.plotOpt.xlim_time);          % xlim
    end
catch ME
    sl = 1;
end


