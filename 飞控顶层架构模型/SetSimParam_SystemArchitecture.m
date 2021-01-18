%% 设置flight data模型参数
SimParam.FlightDataSimParam = SetSimParam_FlightData();
%% 无人机动力学
% INIT_UAV
%% 地面站指令
SimParam.GroundStation = SetSimParam_GroundStation(TASK_PARAM_V1000);
try
    SimParam.Architecture.taskMode; % 该值是否存在
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