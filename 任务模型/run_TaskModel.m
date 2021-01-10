clear,clc
%% 通用参数设置
fprintf('-------------------------- 开始 Task 仿真 --------------------------\n');
setGlobalParam();
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型
%% 初始化任务模型
SimParam.SimpleUavModel = INIT_UavModelForTaskSim();
[SimParam.Task,TASK_PARAM_V1000,TASK_PARAM_V10] = INIT_Task();
%% 地面站指令等参数的初始化
SimParam.GroundStation = INIT_GroundStation(TASK_PARAM_V1000);
%% 飞行性能参数
[SimParam.FightPerf,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = INIT_FlightPerformance();
% INIT_MPCPath
%% 运行model
tic
out = sim('TESTENV_Task');
SimParam.timeSpend = toc;
%% 数据画图
Plot_TaskSimData(out,TASK_PARAM_V1000,SimParam.GroundStation);
Plot_TaskLog();
%% 结束
printSimEnd(SimParam.timeSpend);