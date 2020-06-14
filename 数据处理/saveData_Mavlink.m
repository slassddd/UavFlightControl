%% 保存Mavlink结构体数据
load('SubFolder_ICD\IOBusInfo_V1000')
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
% 航点
IN_MAVLINK.mavlink_mission_item_def = SL.mavlink_mission_item_def;
% 管家命令
taskLogData1 = SL.Debug_TaskLogData;
taskLogDataRes(1).time_sec = taskLogData1.time_sec;
taskLogDataRes(1).idx = taskLogData1.idx;
taskLogDataRes(1).blockName = ENUM_TaskLogBlockName(taskLogData1.blockName);
taskLogDataRes(1).message = ENUM_RTInfo_Task(taskLogData1.message);
taskLogDataRes(1).var1 = [taskLogData1.var10,taskLogData1.var11,...
    taskLogData1.var12,taskLogData1.var13,taskLogData1.var14];
matchMessages = [ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserTaskLogData(taskLogDataRes,matchMessages);
idxMavCmd = find(T_taskLog_MavCmd.message ==  ENUM_RTInfo_Task.TaskLog_Mav_CmdChange);

tempTime = T_taskLog_MavCmd.("记录时间");
[tempTime,idxSel] = unique(tempTime);
command = T_taskLog_MavCmd.var1(idxSel,1);
param1 = T_taskLog_MavCmd.var1(idxSel,2);
for i = 1:length(idxSel)
    IN_MAVLINK.mavlink_msg_id_command_long(i) = STRUCT_mavlink_msg_id_command_long;
    IN_MAVLINK.mavlink_msg_id_command_long(i).param1 = param1(i);
    IN_MAVLINK.mavlink_msg_id_command_long(i).command = command(i);
end
