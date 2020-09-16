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
%% 通用参数设置
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%% 载入飞行数据
tspan = [0,10]; % sec
dataFileNames = {['SubFolder_飞行数据\20200820\仿真数据_长航时 2 2020-08-20 12-32-56']};
dataFileNames = {['SubFolder_飞行数据\20200827\仿真数据_1 第2架次 长航时 2020-08-27 13-28-41']};
dataFileNames = {['SubFolder_飞行数据\20200910\仿真数据_1 2020年9月10日 宝坻 V1000-55# V31196固件 飞行']};
dataFileNames = {['SubFolder_飞行数据\20200910\仿真数据_2020年9月11日 宝坻 V1000-55# V31199固件 旋翼增稳低高度悬停  保持参数短时全流程 2020-09-11 18-04-08']};
LoadFlightData();
%% 固件测试环境参数
PlaneMode.mode = selParamForPlaneMode(); % 设置机型变量
SimulinkRunMode = 1; % 飞行参数源选择；仿真or飞行数据
Ts_Compass.Ts_base = 0.012;
%% 固件参数初始化
INIT_SystemArchitecture
%% 执行仿真
nSim = 1;
switch GLOBAL_PARAM.ModeSel.simMode
    case 'simulink_flightdata'
        tic
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