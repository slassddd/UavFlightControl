%%
clear,clc
clear global
%% 选择仿真模式
mode_architechure = questdlg('选择仿真模式', ...
    '选择仿真模式', ...
    '飞行数据回放','仿真','取消','飞行数据回放');
if strcmp(mode_architechure,'取消')
    disp('退出仿真');
    return;
end
%% 通用参数设置
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%% 载入飞行数据
tspan = [0,inf]; % sec
dataFileNames = {['SubFolder_飞行数据\20201201\仿真数据_空中修改参数失速测试 2020-12-01 11-34-17']};
dataFileNames = {['SubFolder_飞行数据\20201204\仿真数据_2 全流程 2020-12-04 16-36-39']};
LoadFlightData();
%% 固件测试环境参数
PlaneMode.mode = selParamForPlaneMode(); % 设置机型变量
SimulinkRunMode = 1; % 飞行参数源选择；1 飞行数据  2 仿真(已经很久没有维护，肯定不好用了)
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