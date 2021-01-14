clear,clc
cd D:\work\V1000_firmware\数据处理\V10\
binFileName{1} = 'D:\work\V1000_firmware\数据处理\V10\log_31.bin-488896.mat';
V10Log = V10_decode_auto([binFileName{1}]);
V10_decode_sensor;
V10_decode_task;
%%
load('SubFolder_ICD\IOBusInfo_V1000')
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long_time = 0;
FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long = STRUCT_mavlink_msg_id_command_long;
FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def = STRUCT_mavlink_mission_item_def;
%%
FlightLog_Original = SL;
saveFileName{1} = ['D:\work\V1000_firmware\数据处理\V10\仿真日志.mat'];
save(saveFileName{1},'IN_SENSOR','FlightLog_Original','FlightLog_SecondProc')