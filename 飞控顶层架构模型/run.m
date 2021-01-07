%% 完整飞控固件仿真
clear,clc,clear global
%% 选择 【仿真模式】 【机型】
[mode_architechure,             isCancel] = selectArchiSimMode();if isCancel,return;end    % 选择仿真模式 【并行】or【串行】
[SimParam.SystemInfo.planeMode, isCancel] = selPlaneMode();      if isCancel,return;end    % 选择机型 
%% 设置参数
SimulinkRunMode = 1; % 飞行参数源选择；1 飞行数据  2 仿真(已经很久没有维护，肯定不好用了)
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'simulink_flightdata'  'simulink_simdata'
setGlobalParam();
%% 载入飞行数据
tspan0 = [0,10]; % sec
dataFileNames{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201223\仿真数据_3 全流程 2020-12-23 12-53-11.mat'];
% dataFileNames{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_9 大风 人为观察飞机姿态晃动严重，人为点击返航 2020-12-24 12-39-34.mat'];
if strcmp( GLOBAL_PARAM.ModeSel.simMode,'simulink_flightdata') % 
    loadFlightData();
end
tspan = tspan_SET{1};
IN_SENSOR = IN_SENSOR_SET(1);
%% 初始化固件参数
INIT_SystemArchitecture();
%% 执行仿真
switch GLOBAL_PARAM.ModeSel.simMode
    % 选择仿真模式
    case 'simulink_flightdata'
        tic       
        switch mode_architechure
            % 选择仿真模式 【并行】or【串行】
            case '仿真'
                modelname = 'firmwareV1000_sim';
                tic,out = sim(modelname);toc
            case '飞行数据回放'
                modelname = 'firmwareV1000_flight_replay';
                INIT_Mavlink_FlightData();
                GSParam.PATH.pathPoints = STRUCT_mavlink_mission_item_def_ARRAY;
                GSParam.PATH.home(1) = STRUCT_mavlink_mission_item_def_ARRAY(1).x;
                GSParam.PATH.home(2) = STRUCT_mavlink_mission_item_def_ARRAY(2).y;
                Battery_mavlink_msg_mission_current.time = SL.PowerConsume.time_cal;
                Battery_mavlink_msg_mission_current.signals.values = SL.PowerConsume.AllTheTimePowerConsume;
                tic,out = sim(modelname);toc
        end
        timeSpend = toc;
        fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
    otherwise
        error('仿真模式选择错误!');
end
%% 数据处理
[navFilterMARGRes_SET,t_alignment] = PostDataHandle_SimulinkModel(out,Ts_Navi.Ts_Base);
%% 数据绘图
% 导航模块
Plot_NaviSimData();
% 任务模块
Plot_TaskSimData();
Plot_TaskLog();