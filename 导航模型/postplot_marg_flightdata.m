function postplot_marg_flightdata(naviRes,plotOpt,idx_color,idx_style,stepSpace)
%% ----------  ��ϵ������  ----------
nrow = 8;
ncol = 3;
iplot = 0;
%
time = naviRes.Algo.time_algo;
if length(time) > length(naviRes.Algo.algo_curr_pos_0)
    time(end) = []; 
end
stepNum = size(time,1);
idxspan = [1:stepSpace:stepNum];
% ŷ����
data = [naviRes.Algo.algo_yaw,naviRes.Algo.algo_pitch,naviRes.Algo.algo_roll];
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
% ���ٶ�
try
    data = [naviRes.IMU.gx,naviRes.IMU.gy,naviRes.IMU.gz];
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
% λ�� LLA
try
    data = [naviRes.Algo.algo_curr_pos_0,naviRes.Algo.algo_curr_pos_1,naviRes.Algo.algo_curr_pos_2];
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
% λ�� XYZ
try
    data = [naviRes.Algo.algo_curr_pos_0,naviRes.Algo.algo_curr_pos_1,naviRes.Algo.algo_curr_pos_2];
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
    fprintf('XYZλ�û�ͼ��������\n')
end
% �ٶ�
try
    data = [naviRes.Algo.algo_curr_vel_0,naviRes.Algo.algo_curr_vel_1,naviRes.Algo.algo_curr_vel_2];
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
% ���ٶ�ƫ��
data = [naviRes.Algo.dAB_00,naviRes.Algo.dAB_11,naviRes.Algo.dAB_22];  % ������������
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
% ���ٶ�ƫ��
data = [naviRes.Algo.dWB_00,naviRes.Algo.dWB_11,naviRes.Algo.dWB_22];  % ������������
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
% ��ʸ��
try
    data = [naviRes.Algo.magB_x,naviRes.Algo.magB_y,naviRes.Algo.magB_z];
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
% ��ʸ��ƫ��
try
    data = [naviRes.Algo.dmagB_x,naviRes.Algo.dmagB_y,naviRes.Algo.dmagB_z];
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


