SimulinkRunMode = 2;
for i_sim = 1:nSim
    [ALGO_SET,sensorFs] = step2_setALGOparam_simData(PARALLEL_PARAM_SET(i_sim));
    %% 无人机相关参数初始化
    INIT_UAV
    %% 任务初始化
    INIT_TASK
    %% 传感器故障参数
    INIT_SensorFault
    %% 传感器安装参数
    INIT_SensorAlignment
    %% 信号检测
    INIT_SensorIntegrity    
    %% 仿真
    tspan = [0,30];
    out(i_sim) = sim('model_navfilter');
    %% 数据后处理
    [navFilterMARGRes(i_sim),t_alignment(i_sim)] = PostDataHandle_SimulinkModel(out(i_sim),sensorFs);
    %% 仿真绘图
    plotOpt = setPlotOpt;
    stepSpace = 1;
    plotEnable = 1;
    % ------------  原算法数据 ---------------
    if 1
        figure(103)
        myplot_navfilter(navFilterMARGRes(i_sim),plotOpt,2,2,stepSpace); % 显示组合导航数据
    end
end
