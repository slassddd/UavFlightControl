clear,clc
%% 通用参数
fprintf('-------------------------- 开始 Task 仿真 --------------------------\n');
setGlobalParams();
SimParam.Basic.selDefaultPlaneMode = [] ; % [] ENUM_plane_mode.V1000
SimParam.Basic.nameTestCase = [] ;%'GSTestCase_TakeOff_Land'; % 指定测试用例名称,[]表示不指定
%% Algorithm 算法参数
% 任务
SimParam.SimpleUavModel = SetAlgoParam_UavModelForTaskSim();
[SimParam.Task,TASK_PARAM_V1000,TASK_PARAM_V10] = SetAlgoParam_Task();
% 飞行性能
[SimParam.FightPerf,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = SetAlgoParam_FlightPerformance();
%% Simulation 仿真参数
% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode(SimParam.Basic.selDefaultPlaneMode);if isCancel,return;end % 选择机型
% 设置测试用例
[TestCase.GroundStation,isCancel] = selSimCaseSource('task','CaseFileName',SimParam.Basic.nameTestCase);if isCancel,return;end
for i = 1:length(TestCase.GroundStation.filename)
    TestCase.GroundStation.data(i) = eval(TestCase.GroundStation.filename{i});
end
% 地面站指令(包括航线设置)
SimParam.GroundStation = SetSimParam_GroundStation(TASK_PARAM_V1000);
% 【仿真】or【数据回放】
if 0
    [SimParam.SystemInfo.taskMode, isCancel] = selectArchiSimMode();if isCancel,return;end    % 选择仿真模式
    if strcmp( SimParam.SystemInfo.taskMode, '飞行数据回放')
        proj = matlab.project.rootProject;
%         PathData = load([proj.RootFolder{1},'\SubFolder_飞行数据\V1000 数据\20210325\航线数据_1 全流程 2021-03-25 13-37-25.mat']);
        PathData = load([proj.RootFolder{1},'\SubFolder_飞行数据\V10 数据\20210419\航线数据_地面仿真 变高巡线 2021-04-19 14-38-16.mat']);
        PathData.PathData(1).x = PathData.PathData(2).x + 500/111e3; % 重置home点位置
        PathData.PathData(1).y = PathData.PathData(2).y + 500/111e3;
        %     PathData = load([proj.RootFolder{1},'\SubFolder_飞行数据\V1000 数据\V1000 客户飞行数据\20210307 起飞80m悬停翻了\航线数据_2021-03-07 10-37-22']);
        SimParam.GroundStation(i).mavlinkPathPoints = PathData.PathData;
        SimParam.GroundStation(i).mavlinkHome(1) = PathData.PathData(1).x;
        SimParam.GroundStation(i).mavlinkHome(2) = PathData.PathData(2).y;
    end
end
%% 运行model
SimParam.Basic.parallelMode = 'serial';  % parallel serial auto
SimParam.Basic.modelname = 'TESTENV_Task';

IN_TestCase_GS = TestCase.GroundStation.data(1); % 在workspace中保留一份副本，保证可以直接通过点击模型Run进行仿真
for i = 1:length(TestCase.GroundStation.data)
    SimInput(i) = Simulink.SimulationInput(SimParam.Basic.modelname);
    SimInput(i) = SimInput(i).setVariable('IN_TestCase_GS',TestCase.GroundStation.data(i));
end
tic,  out = sim(SimInput);  SimParam.Basic.timeSpend = toc;
%% 数据画图
Plot_TaskSimData(out,TASK_PARAM_V1000,SimParam.GroundStation,TestCase.GroundStation);
Plot_TaskLog();
%% 结束
printSimEnd(SimParam.Basic.timeSpend);
