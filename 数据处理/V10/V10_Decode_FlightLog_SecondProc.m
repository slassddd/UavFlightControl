% function FlightLog_SecondProc = V10_Decode_FlightLog_SecondProc(V10Log)

% STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
% STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
% FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long_time = 0;
% FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long = STRUCT_mavlink_msg_id_command_long;
% FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def = STRUCT_mavlink_mission_item_def;

formatMavlinkFromFlightData;
FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(1).x = FlightLog_Original.HomePointFromGS.mavlink_msg_groundHomeLLA0(end);
FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(1).y = FlightLog_Original.HomePointFromGS.mavlink_msg_groundHomeLLA1(end);
FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def(1).z = FlightLog_Original.HomePointFromGS.mavlink_msg_groundHomeLLA2(end);