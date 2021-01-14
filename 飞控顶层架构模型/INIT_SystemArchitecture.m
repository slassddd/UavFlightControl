SimParam.ArchitectureEnv.Ts_base = 0.004; % firmwareV1000_flight_replay和firmwareV1000_sim的仿真步长
SimParam.Architecture.Ts_base = 0.012; % RefModel_SystemArchitecture的仿真步长
%% 设置flight data模型参数
SimParam.FlightDataSimParam = INIT_FlightData();
%% 控制率初始化
INIT_Control;
load('IOBusInfo_V1000'); % Control模块的结构体可能存在不一致的情况,在此重新载入一次
%% 组合导航初始化
[SimParam.Navi,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = INIT_Navi();
%% 无人机动力学
INIT_UAV
%% 任务初始化
[SimParam.Task,TASK_PARAM_V1000,TASK_PARAM_V10] = INIT_Task();
%% 简化的运动模型
SimParam.SimpleUavModel = INIT_UavModelForTaskSim();
%% 地面站指令
SimParam.GroundStation = INIT_GroundStation(TASK_PARAM_V1000);
try
    SimParam.Architecture.taskMode
    switch SimParam.Architecture.taskMode
        case '飞行数据回放'
            SimParam.GroundStation.mavlinkCmd_time = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long_time;
            SimParam.GroundStation.mavlinkCmd = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long;
            SimParam.GroundStation.mavlinkPathPoints = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def;
            SimParam.GroundStation.mavlinkHome(1) = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(1).x;
            SimParam.GroundStation.mavlinkHome(2) = SimDataSet.FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(2).y;
            SimParam.GroundStation.current.time = SimDataSet.FlightLog_Original.PowerConsume.time_cal;
            SimParam.GroundStation.current.signals.values = SimDataSet.FlightLog_Original.PowerConsume.AllTheTimePowerConsume;
    end
catch
    fprintf('%s[WARNING] 跳过Groundstation仿真数据赋值,仅应在运行 run_RTWBuild 进行代码生成时报该警告\n',GLOBAL_PARAM.Print.lineHead);
end
%% 传感器故障参数
[SimParam.SensorFault,SENSOR_FAULT] = INIT_SensorFault();
%% 传感器安装参数
[SENSOR_ALIGNMENT_PARAM_V1000,SENSOR_ALIGNMENT_PARAM_V10,SENSOR_ALIGNMENT_PARAM_V10_1] = INIT_SensorAlignment();
%% 信号检测
[SimParam.SensorIntegrity,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = ...
    INIT_SensorIntegrity();
%% 飞行性能
[SimParam.FightPerf,FLIGHT_PERF_PARAM_V1000,FLIGHT_PERF_PARAM_V10] = INIT_FlightPerformance();
%% 视觉着陆
[SimParam.VLand,VISLANDING_PARAM_V1000,VISLANDING_PARAM_V10] = INIT_VisualLanding();
%% 设置模块优先级
INIT_Priority('RefModel_SystemArchitecture');
