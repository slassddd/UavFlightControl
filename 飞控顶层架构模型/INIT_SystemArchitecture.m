Ts_SimBigModel.Ts_base = 0.004; % firmwareV1000_flight_replay和firmwareV1000_sim的仿真步长
Ts_BigModel.Ts_base = 0.012; % RefModel_SystemArchitecture的仿真步长
%% 控制率初始化
INIT_Control;
%% 组合导航初始化
INIT_Navi
%% 无人机动力学
INIT_UAV
%% 任务初始化
[SimParam.Task,TASK_PARAM_V1000,TASK_PARAM_V10] = INIT_Task();
%% 简化的运动模型
SimParam.SimpleUavModel = INIT_UavModelForTaskSim();
%% 地面站指令
SimParam.GroundStation = INIT_GroundStation(TASK_PARAM_V1000);
%% 传感器故障参数
INIT_SensorFault
%% 传感器安装参数
INIT_SensorAlignment
%% 信号检测
INIT_SensorIntegrity
%% 飞行性能
[SimParam.FightPerf,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = INIT_FlightPerformance();
%% 视觉着陆
INIT_VisualLanding
%% 设置模块优先级
INIT_Priority
