clear,clc
SetGlobalParam
%% 初始化任务模型
INIT_SIMPLEUAVMOTION
INIT_TASK 
%% 地面站指令等参数的初始化
INIT_GROUNDSTATION
%% 飞行性能参数
INIT_FlightPerformance
%% MPC航线跟踪器44
% INIT_MPCPath
%% 运行model
tic
out = sim('TESTENV_Task');
toc
%% 数据画图
plot_simdata
plot_taskLogTable
