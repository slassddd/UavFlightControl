%% 完整飞控固件仿真
clear,clc,clear global
%% 设置参数
fprintf('-------------------------- 开始大模型仿真 --------------------------\n');
setGlobalParams();
[SimParam.Architecture.taskMode, isCancel] = selectArchiSimMode();if isCancel,return;end    % 选择仿真模式 【仿真】or【数据回放】
[SimParam.SystemInfo.planeMode, isCancel] = selPlaneMode();      if isCancel,return;end    % 选择机型
%% 设置测试用例(若选择【数据回放】则测试用例设置无效)
% GroundStation
[TestCase.GroundStation,isCancel] = selSimCaseSource('Task');if isCancel,return;end % 
for i = 1:length(TestCase.GroundStation.filename)
    TestCase.GroundStation.data(i) = eval(TestCase.GroundStation.filename{i});
end
% SensorFault
[TestCase.SensorFaultPanel,isCancel] = selSimCaseSource('SensorFaultPanel');if isCancel,return;end
for i = 1:length(TestCase.SensorFaultPanel.filename)
    TestCase.SensorFaultPanel.data(i) = eval(TestCase.SensorFaultPanel.filename{i});
end
checkTestCase_SensorFault(TestCase.SensorFaultPanel.data);
%
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
%% 载入飞行数据
tspan0 = [0,50]; % 仿真时间区间 [sec]
TestCase.FlightLog.filename{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201223\仿真数据_3 全流程 2020-12-23 12-53-11.mat'];
SimDataSet = loadFlightDataFile(tspan0,TestCase.FlightLog.filename,BUS_SENSOR);if ~SimDataSet.validflag,return;end
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
%% 初始化固件参数
SetAlgoParam_SystemArchitecture
SetSimParam_SystemArchitecture
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
%% 执行仿真
switch SimParam.ArchitectureEnv.sourceMode % 选择仿真模式
    case 'simulink_flightdata'
        switch SimParam.Architecture.taskMode
            case '仿真'
                SimParam.Architecture.modelname = 'firmwareV1000_sim';
            case '飞行数据回放'
                SimParam.Architecture.modelname = 'firmwareV1000_flight_replay';
        end
    otherwise
        error('仿真模式选择错误!');
end
tspan = SimDataSet.tspan{1}; % 在workspace中保留一份副本，保证可以直接通过点击模型Run进行仿真
IN_SENSOR = SimDataSet.IN_SENSOR(1);
IN_TestCase_GS = TestCase.GroundStation.data(1);
IN_TestCase_SensorFault = TestCase.SensorFaultPanel.data(1);
for i = 1:length(TestCase.FlightLog.filename)
    SimInput(i) = Simulink.SimulationInput(SimParam.Architecture.modelname);
    SimInput(i) = SimInput(i).setVariable('tspan',SimDataSet.tspan{i}); % setVariable 优先级大于工作空间
    SimInput(i) = SimInput(i).setVariable('IN_SENSOR',SimDataSet.IN_SENSOR(i)); % setVariable 优先级大于工作空间
%     SimInput(i) = SimInput(i).setVariable('IN_TestCase_GS',TestCase.GroundStation.data(i));
%     SimInput(i) = SimInput(i).setVariable('IN_TestCase_SensorFault',TestCase.SensorFaultPanel.data(i));
    tic,out(i) = sim(SimInput(i));SimParam.Basic.timeSpend = toc;
%     tic,out = sim(SimParam.Architecture.modelname);SimParam.Basic.timeSpend = toc;
end
fprintf('仿真完成, 耗时 %.2f [s]\n',SimParam.Basic.timeSpend);
%% 数据处理
for i = 1:SimDataSet.nFlightDataFile
    [SimRes.Navi.MARG(i),SimRes.Navi.timeInit(i)] = getSimRes_Navi(out(i),SimParam.Navi.Ts_Base);
end
%% 数据绘图
% 导航模块
Plot_NaviSimData(SimRes,SimDataSet,TestCase.FlightLog.filename);
% 任务模块
Plot_TaskSimData(out,TASK_PARAM_V1000,SimParam.GroundStation,TestCase.GroundStation);
Plot_TaskLog();
%% 结束
printSimEnd(SimParam.Basic.timeSpend);