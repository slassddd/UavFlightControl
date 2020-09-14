%%
clear,clc
clear global
%% 选择仿真模式
mode_architechure = questdlg('选择仿真模式', ...
    '选择仿真模式', ...
    '飞行数据回放','仿真','取消','飞行数据回放');
if strcmp(mode_architechure,'取消')
    return;
end
%%
Ts_SimBigModel.Ts_base = 0.004;
Ts_BigModel.Ts_base = 0.012;
%% 通用参数设置
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%%
if strcmp( GLOBAL_PARAM.ModeSel.simMode,'matlab_flightdata') || strcmp( GLOBAL_PARAM.ModeSel.simMode,'simulink_flightdata') % 飞行数据仿真
    %% 载入飞行数据并生成仿真格式数据
    tspan = [0,100]; % sec
    dataFileNames = {['20200418\仿真数据_log_1_V1000-24#V31132固件管家点击起飞后飞机快速向右后方移动']};
    dataFileNames = {['SubFolder_飞行数据\20200820\仿真数据_长航时 2 2020-08-20 12-32-56']};
    dataFileNames = {['SubFolder_飞行数据\20200827\仿真数据_1 第2架次 长航时 2020-08-27 13-28-41']};
    dataFileNames = {['SubFolder_飞行数据\20200910\仿真数据_1 2020年9月10日 宝坻 V1000-55# V31196固件 飞行']};
    dataFileNames = {['SubFolder_飞行数据\20200910\仿真数据_2020年9月11日 宝坻 V1000-55# V31199固件 旋翼增稳低高度悬停  保持参数短时全流程 2020-09-11 18-04-08']};
    nFlightDataFile = length(dataFileNames);
    for i = 1:nFlightDataFile
        [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i),tspan_set{i},~,SL(i),SL_LOAD(i)] = step1_loadFlightData(tspan,dataFileNames{i},BUS_SENSOR);
    end
    tspan = tspan_set{1};
    % 传感器曲线
    if 1
        fig = figure(102);
        GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR(1),2,2,fig)
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
        figure(104)
        subplot(2,2,1)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.numSv);
        ylabel('星数')
        xlabel('sec')
        subplot(2,2,2)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.pDop);
        ylabel('pDOP')
        xlabel('sec')
        subplot(2,2,3)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.sAcc);
        ylabel('sAcc')
        xlabel('sec')
        subplot(2,2,4)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.hAcc);
        ylabel('hAcc')
        xlabel('sec')
    end
end
%% 设置机型变量
PlaneMode.mode = selParamForPlaneMode();
%% 开始仿真
nSim = 1;
nStateMARG = 22; % 滤波器状态维数
%% 执行仿真
switch GLOBAL_PARAM.ModeSel.simMode
    case 'simulink_flightdata'
        tic
        %%
        SimulinkRunMode = 1;
        %% 控制率初始化
        Ts_Control.Ts_base = 0.012;
        Ts_Compass.Ts_base = 0.012;
        try
            INIT_Control;
        catch ME
            fprintf('INIT_Control:\n')
            fprintf(ME.message);
            fprintf('\n')
            return;
        end
        %% 框架模型
        Ts_Architechure.Ts_base = 0.012;
        %% 控制模块初始化
        % INIT_CONTROL
        %% 组合导航初始化
        INIT_Navi
        %%
        INIT_UAV
        %% 任务初始化
        INIT_TASK
        % 简化的运动模型
        INIT_SIMPLEUAVMOTION
        %% 地面站指令
        INIT_GROUNDSTATION
        %% 传感器故障参数
        INIT_SensorFault
        %% 传感器安装参数
        INIT_SensorAlignment
        %% 信号检测
        INIT_SensorIntegrity
        %% 飞行性能
        INIT_FlightPerformance
        %% 运行仿真      
        switch mode_architechure
            case '仿真' % 仿真
                modelname = 'firmwareV1000_sim';
                tic,out = sim(modelname);toc
                %% 数据后处理
                [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,Ts_Navi.Ts_Base);
                %% 仿真绘图
                AchiPlot_sim
            case '飞行数据回放' % 飞行数据
                modelname = 'firmwareV1000_flight_replay';
                INIT_Mavlink_FlightData
                Battery_mavlink_msg_mission_current.time = SL.PowerConsume.time_cal;
                Battery_mavlink_msg_mission_current.signals.values = SL.PowerConsume.AllTheTimePowerConsume;
                %% 执行仿真
                tic
                ArchiRes_replay = sim(modelname);
                toc
                %% 数据后处理
                [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(ArchiRes_replay,Ts_Navi.Ts_Base);
                %% 仿真绘图
                AchiPlot_replay
        end
        timeSpend = toc;
        fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
    case 'simulink_simdata'
        % 不用了
    case 'matlab_flightdata'
        % 不用了        
    otherwise
        error('错误的仿真模式')
end