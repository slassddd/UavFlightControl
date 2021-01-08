Ts_SimBigModel.Ts_base = 0.004; % firmwareV1000_flight_replay和firmwareV1000_sim的仿真步长
Ts_BigModel.Ts_base = 0.012; % RefModel_SystemArchitecture的仿真步长
%% 设置flight data模型参数
SimParam.FlightDataSimParam = INIT_FlightData();
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
switch SimParam.Architecture.runMode
    case '飞行数据回放'
        SimParam.GroundStation.mavlinkCmd_time = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.IN_MAVLINK_mavlink_msg_id_command_long_time;
        SimParam.GroundStation.mavlinkCmd = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long;
        SimParam.GroundStation.mavlinkPathPoints = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def;
        SimParam.GroundStation.mavlinkHome(1) = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(1).x;
        SimParam.GroundStation.mavlinkHome(2) = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(2).y;
        SimParam.GroundStation.current.time = SimDataSet.FlightLog_Original.PowerConsume.time_cal;
        SimParam.GroundStation.current.signals.values = SimDataSet.FlightLog_Original.PowerConsume.AllTheTimePowerConsume;
end
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
