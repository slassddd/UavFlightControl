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
        PathData = load([proj.RootFolder{1},'\SubFolder_飞行数据\V10 数据\20210425\航线数据_变高航线 异常返航 2021-04-25 18-33-50.mat']);
%         PathData = load([proj.RootFolder{1},'\SubFolder_飞行数据\V10 数据\20210425\航线数据_仿真 高度不对 2021-04-25 17-34-04.mat']);
        PathData.PathData(1).x = PathData.PathData(2).x + 500/111e3; % 重置home点位置
        PathData.PathData(1).y = PathData.PathData(2).y + 500/111e3;
        %     PathData = load([proj.RootFolder{1},'\SubFolder_飞行数据\V1000 数据\V1000 客户飞行数据\20210307 起飞80m悬停翻了\航线数据_2021-03-07 10-37-22']);
        SimParam.GroundStation(1).mavlinkPathPoints = PathData.PathData;
        SimParam.GroundStation(1).mavlinkHome(1) = PathData.PathData(1).x;
        SimParam.GroundStation(1).mavlinkHome(2) = PathData.PathData(2).y;
        %         SimParam.GroundStation(1).XYGraph_lat_min =
        if 1
            for i = 3:length(SimParam.GroundStation(1).mavlinkPathPoints)
                SimParam.GroundStation(1).mavlinkPathPoints(i).param1 = single(1);
            end
        end
    end
end
%%
SimParam.GroundStation(1).XYGraph_lat_min = inf;
SimParam.GroundStation(1).XYGraph_lat_max = -inf;
SimParam.GroundStation(1).XYGraph_lon_min = inf;
SimParam.GroundStation(1).XYGraph_lon_max = -inf;
for i = 1:length(SimParam.GroundStation(1).mavlinkPathPoints)
    thisLat = SimParam.GroundStation(1).mavlinkPathPoints(i).x;
    thisLon = SimParam.GroundStation(1).mavlinkPathPoints(i).y;
    if thisLat ~= TASK_PARAM_V1000.nanFlag && thisLat ~= 0
        SimParam.GroundStation(1).XYGraph_lat_min = min(thisLat,SimParam.GroundStation(1).XYGraph_lat_min);
        SimParam.GroundStation(1).XYGraph_lat_max = max(thisLat,SimParam.GroundStation(1).XYGraph_lat_max);
        SimParam.GroundStation(1).XYGraph_lon_min = min(thisLon,SimParam.GroundStation(1).XYGraph_lon_min);
        SimParam.GroundStation(1).XYGraph_lon_max = max(thisLon,SimParam.GroundStation(1).XYGraph_lon_max);
    else
        break;
    end
end
SimParam.GroundStation(1).XYGraph_lat_min = SimParam.GroundStation(1).XYGraph_lat_min - 300/111e3;
SimParam.GroundStation(1).XYGraph_lat_max = SimParam.GroundStation(1).XYGraph_lat_max + 300/111e3;
SimParam.GroundStation(1).XYGraph_lon_min = SimParam.GroundStation(1).XYGraph_lon_min - 300/111e3;
SimParam.GroundStation(1).XYGraph_lon_max = SimParam.GroundStation(1).XYGraph_lon_max + 300/111e3;
%% 运行model
SimParam.Basic.parallelMode = 'serial';  % parallel serial auto
SimParam.Basic.modelname = 'TESTENV_Task';
SimParam.TaskEnv = SetSimParam_TaskEnv();
IN_TestCase_GS = TestCase.GroundStation.data(1); % 在workspace中保留一份副本，保证可以直接通过点击模型Run进行仿真
for i = 1:length(TestCase.GroundStation.data)
    SimInput(i) = Simulink.SimulationInput(SimParam.Basic.modelname);
    SimInput(i) = SimInput(i).setVariable('IN_TestCase_GS',TestCase.GroundStation.data(i));
end
tic,  out = sim(SimInput);  SimParam.Basic.timeSpend = toc;
%% 数据画图
Plot_TaskSimData(out,TASK_PARAM_V1000,SimParam.GroundStation,TestCase.GroundStation);
Plot_TaskLog();
figure;
plot(out.Task_TaskModeData.heightCmd.Time,out.Task_TaskModeData.heightCmd.Data);hold on;
plot(out.Task_FlightData.curLLA.Time,permute(out.Task_FlightData.curLLA.Data(1,3,:),[3,2,1]));hold on;
plot(out.Task_TaskModeData.currentPointNum.Time,10*out.Task_TaskModeData.currentPointNum.Data);hold on;grid on;
%% 结束
printSimEnd(SimParam.Basic.timeSpend);
