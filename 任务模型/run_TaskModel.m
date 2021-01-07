clear,clc
setGlobalParam();
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型
%% 初始化任务模型
INIT_SIMPLEUAVMOTION
INIT_TASK 
%% 地面站指令等参数的初始化
INIT_GROUNDSTATION
%% 飞行性能参数
INIT_FlightPerformance
% INIT_MPCPath
%% 运行model
tic
out = sim('TESTENV_Task');
toc
%% 数据画图
Plot_TaskSimData();
Plot_TaskLog();