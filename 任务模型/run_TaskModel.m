clear,clc
%% 参数设置
fprintf('-------------------------- 开始 Task 仿真 --------------------------\n');
setGlobalParam();
% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型
% 设置测试用例
[SimParam.TestCase.filename,SimParam.TestCase.sel,isCancel] = selSimCaseSource('task');if isCancel,return;end % 选择机型
for i = 1:length(SimParam.TestCase.filename)
    TestCase.Task(i) = eval(SimParam.TestCase.filename{i});
end
% 初始化任务模型
SimParam.SimpleUavModel = INIT_UavModelForTaskSim();
[SimParam.Task,TASK_PARAM_V1000,TASK_PARAM_V10] = INIT_Task();
% 地面站指令等参数的初始化
SimParam.GroundStation = INIT_GroundStation(TASK_PARAM_V1000);
% 飞行性能参数
[SimParam.FightPerf,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = INIT_FlightPerformance();
% INIT_MPCPath
%% 运行model
SimParam.Basic.parallelMode = 'serial';  % parallel serial auto
SimParam.Basic.modelname = 'TESTENV_Task';
IN_TestCase_Task = TestCase.Task(1); % 在workspace中保留一份副本，保证可以直接通过点击模型Run进行仿真
for i = 1:length(TestCase.Task)
    SimInput(i) = Simulink.SimulationInput(SimParam.Basic.modelname);
    SimInput(i) = SimInput(i).setVariable('IN_TestCase_Task',TestCase.Task(i));
end
tic,  out = sim(SimInput);  SimParam.timeSpend = toc;
%% 数据画图
Plot_TaskSimData(out,TASK_PARAM_V1000,SimParam.GroundStation,SimParam.TestCase);
Plot_TaskLog();
%% 结束
printSimEnd(SimParam.timeSpend);