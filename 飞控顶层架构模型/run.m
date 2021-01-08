%% 完整飞控固件仿真
clear,clc,clear global
%% 设置参数
setGlobalParam();
% 选择 【仿真模式】 【机型】
[SimParam.Architecture.runMode, isCancel] = selectArchiSimMode();if isCancel,return;end    % 选择仿真模式 【并行】or【串行】
[SimParam.SystemInfo.planeMode, isCancel] = selPlaneMode();      if isCancel,return;end    % 选择机型
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
%% 载入飞行数据
tspan0 = [0,50]; % 仿真时间区间 [sec]
dataFileNames{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201223\仿真数据_3 全流程 2020-12-23 12-53-11.mat'];
% dataFileNames{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_9 大风 人为观察飞机姿态晃动严重，人为点击返航 2020-12-24 12-39-34.mat'];
SimDataSet = loadFlightData(tspan0,dataFileNames,BUS_SENSOR);if ~SimDataSet.validflag,return;end
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
%% 初始化固件参数
tspan = SimDataSet.tspan{1};
IN_SENSOR = SimDataSet.IN_SENSOR(1);
INIT_SystemArchitecture();
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
%% 执行仿真
switch GLOBAL_PARAM.sourceMode % 选择仿真模式
    case 'simulink_flightdata'
        switch SimParam.Architecture.runMode % 选择仿真模式 【并行】or【串行】
            case '仿真'
                SimParam.Architecture.modelname = 'firmwareV1000_sim';
                tic,out = sim(SimParam.Architecture.modelname);timeSpend = toc;
            case '飞行数据回放'
                SimParam.Architecture.modelname = 'firmwareV1000_flight_replay';
                tic,out = sim(SimParam.Architecture.modelname);timeSpend = toc;
        end
        fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
    otherwise
        error('仿真模式选择错误!');
end
%% 数据处理
for i = 1:SimDataSet.nFlightDataFile
    [SimRes.Navi.MARG(i),SimRes.Navi.timeInit(i)] = getSimRes_Navi(out(i),SimParam.Navi.Ts_Base);
end
%% 数据绘图
% 导航模块
Plot_NaviSimData(SimRes,SimDataSet,GLOBAL_PARAM,dataFileNames);
% 任务模块
Plot_TaskSimData(out,TASK_PARAM_V1000,SimParam.GroundStation);
Plot_TaskLog();
%% 结束
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
fprintf('%s[END] 仿真完成, 耗时 %.2f [s]\n',GLOBAL_PARAM.Print.lineHead,timeSpend);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);