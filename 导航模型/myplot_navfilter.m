function myplot_navfilter(sensors,plotOpt,idx_color,idx_style,stepSpace)
%% ----------  ��ϵ������  ----------
nrow = 7;
ncol = 3;
iplot = 0;
%
time = sensors.Algo.time_algo;
stepNum = size(time,1);
idxspan = [1:stepSpace:stepNum];
% ŷ����
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
% λ�� LLA
try
    data = [sensors.Algo.algo_curr_pos_0,sensors.Algo.algo_curr_pos_1,sensors.Algo.algo_curr_pos_2];
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
catch 
    iplot = iplot + 3;    
end
% λ�� XYZ
try
    data = [sensors.Algo.algo_curr_pos_0,sensors.Algo.algo_curr_pos_1,sensors.Algo.algo_curr_pos_2];
    data = lla2flat(data,data(1,1:2),0,0);
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
catch 
    iplot = iplot + 3;    
end
% �ٶ�
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
catch 
    iplot = iplot + 3;    
end
% ���ٶ�ƫ��
data = [sensors.Algo.dAB_00,sensors.Algo.dAB_11,sensors.Algo.dAB_22];  % ������������
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
data = [sensors.Algo.dWB_00,sensors.Algo.dWB_11,sensors.Algo.dWB_22];  % ������������
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
    data = [sensors.Algo.magB_x,sensors.Mag.magB_y,sensors.Mag.magB_z];
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
catch 
    iplot = iplot + 3;    
end
% ��ʸ��ƫ��
try
    data = [sensors.Algo.dmagB_x,sensors.Algo.dmagB_y,sensors.Algo.dmagB_z];
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
catch ME
    sl = 1;
end


