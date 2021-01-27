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
            for i = 1:SimDataSet.nFlightDataFile
                SimParam.GroundStation(i).mavlinkCmd_time = SimDataSet.FlightLog_SecondProc(i).IN_MAVLINK.mavlink_msg_id_command_long_time;
                SimParam.GroundStation(i).mavlinkCmd = SimDataSet.FlightLog_SecondProc(i).IN_MAVLINK.mavlink_msg_id_command_long;
                SimParam.GroundStation(i).mavlinkPathPoints = SimDataSet.FlightLog_SecondProc(i).IN_MAVLINK.mavlink_mission_item_def;
                SimParam.GroundStation(i).mavlinkHome(1) = SimDataSet.FlightLog_SecondProc(i).IN_MAVLINK.mavlink_mission_item_def(1).x;
                SimParam.GroundStation(i).mavlinkHome(2) = SimDataSet.FlightLog_SecondProc(i).IN_MAVLINK.mavlink_mission_item_def(2).y;
                SimParam.GroundStation(i).current.time = SimDataSet.FlightLog_Original(i).PowerConsume.time_cal;
                SimParam.GroundStation(i).current.signals.values = SimDataSet.FlightLog_Original(i).PowerConsume.AllTheTimePowerConsume;
            end
    end
catch
    fprintf('%s[WARNING] 跳过Groundstation仿真数据赋值,仅应在运行 run_RTWBuild 进行代码生成时报该警告\n',GLOBAL_PARAM.Print.lineHead);
end