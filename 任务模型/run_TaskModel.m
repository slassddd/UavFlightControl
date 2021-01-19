clear,clc
%% 通用参数
fprintf('-------------------------- 开始 Task 仿真 --------------------------\n');
setGlobalParams();
%% Algorithm 算法参数
% 任务
SimParam.SimpleUavModel = SetAlgoParam_UavModelForTaskSim();
[SimParam.Task,TASK_PARAM_V1000,TASK_PARAM_V10] = SetAlgoParam_Task();
% 飞行性能
[SimParam.FightPerf,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = SetAlgoParam_FlightPerformance();
%% Simulation 仿真参数
% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型
% 设置测试用例
[TestCase.GroundStation,isCancel] = selSimCaseSource('task');if isCancel,return;end
for i = 1:length(TestCase.GroundStation.filename)
    TestCase.GroundStation.data(i) = eval(TestCase.GroundStation.filename{i});
end
% 地面站指令
SimParam.GroundStation = SetSimParam_GroundStation(TASK_PARAM_V1000);
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