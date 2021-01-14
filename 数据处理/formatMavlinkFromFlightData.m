%% 保存Mavlink结构体数据
load('SubFolder_ICD\IOBusInfo_V1000')
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
%% 航点 —— IN_MAVLINK.mavlink_mission_item_def
% 从飞行log中解析航点
maxPathNum = 500;
[mavPathPoints,homeLLA] = getPathFromFlightData(SL.mavlink_mission_item_def);
IN_MAVLINK.mavlink_mission_item_def = formatMavPath(STRUCT_mavlink_mission_item_def,mavPathPoints,maxPathNum);
%% 管家命令 —— IN_MAVLINK.mavlink_msg_id_command_long
taskLogData1 = SL.Debug_TaskLogData;
taskLogDataRes(1).time_sec = taskLogData1.time_sec;
taskLogDataRes(1).idx = taskLogData1.idx;
taskLogDataRes(1).blockName = ENUM_TaskLogBlockName(taskLogData1.blockName);
for i = 1:length(taskLogData1.message)
    try
        taskLogDataRes(1).message(i,1) = ENUM_RTInfo_Task(taskLogData1.message(i));
    catch
        taskLogDataRes(1).message(i,1) = ENUM_RTInfo_Task(0);
    end
end
taskLogDataRes(1).var1 = [taskLogData1.var10,taskLogData1.var11,...
    taskLogData1.var12,taskLogData1.var13,taskLogData1.var14];
matchBlock = [ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserLogData(taskLogDataRes,'BlockName',matchBlock);
idxMavCmd = find(T_taskLog_MavCmd.message ==  ENUM_RTInfo_Task.TaskLog_Mav_CmdChange);

tempTime = T_taskLog_MavCmd.("记录时间");
[tempTime,idxSel] = unique(tempTime);
command = T_taskLog_MavCmd.var1(idxSel,1);
param1 = T_taskLog_MavCmd.var1(idxSel,2);

maxNum_cmd = 200;
for i = 1:maxNum_cmd
    if i <= length(idxSel)
        mavlink_msg_id_command_long_time(i) = tempTime(i);
        IN_MAVLINK.mavlink_msg_id_command_long(i) = STRUCT_mavlink_msg_id_command_long;
        IN_MAVLINK.mavlink_msg_id_command_long(i).param1 = single(param1(i));
        IN_MAVLINK.mavlink_msg_id_command_long(i).command = uint16(command(i));
    else
        mavlink_msg_id_command_long_time(i) = 0;
        IN_MAVLINK.mavlink_msg_id_command_long(i) = STRUCT_mavlink_msg_id_command_long;
    end
end
FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long_time = mavlink_msg_id_command_long_time;
FlightLog_SecondProc.IN_MAVLINK.mavlink_msg_id_command_long = IN_MAVLINK.mavlink_msg_id_command_long;
FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def = IN_MAVLINK.mavlink_mission_item_def;
%% 子函数
function STRUCT_mavlink_mission_item_def_ARRAY = formatMavPath(namePathStruct,pathpoints,maxPathNum,flagPath)
num_point = size(pathpoints,1);
if nargin == 3
    % 按耕田航线方式赋值flag
    for i = 1:num_point
        flagPath(i) = rem(i,2);
    end
end
speed = 19;
 
for i = 1:maxPathNum
    STRUCT_mavlink_mission_item_def_ARRAY(i) = namePathStruct;
    if i <= num_point
        STRUCT_mavlink_mission_item_def_ARRAY(i).param1 = single(flagPath(i));
        STRUCT_mavlink_mission_item_def_ARRAY(i).seq = uint16(i); % 航点序列号（0：Home点）
        STRUCT_mavlink_mission_item_def_ARRAY(i).autocontinue = uint8(1); % 悬停拐弯:0, 协调拐弯:1
        STRUCT_mavlink_mission_item_def_ARRAY(i).param4 = single(speed);
        STRUCT_mavlink_mission_item_def_ARRAY(i).x = single(pathpoints(i,1));  % lattitude
        STRUCT_mavlink_mission_item_def_ARRAY(i).y = single(pathpoints(i,2));  % longitude
        STRUCT_mavlink_mission_item_def_ARRAY(i).z = single(pathpoints(i,3));  % altitude
    end
end
end