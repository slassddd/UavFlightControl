% 解析taskLogData
taskLogData1 = SL.Debug_TaskLogData;
taskLogDataRes(1).time_sec = taskLogData1.time_sec;
taskLogDataRes(1).idx = taskLogData1.idx;
taskLogDataRes(1).blockName = ENUM_TaskLogBlockName(taskLogData1.blockName);
taskLogDataRes(1).message = ENUM_RTInfo_Task(taskLogData1.message);
taskLogDataRes(1).var1 = [taskLogData1.var10,taskLogData1.var11,...
    taskLogData1.var12,taskLogData1.var13,taskLogData1.var14];
%%
T_taskLog_All = parserLogData(taskLogDataRes);
matchBlock = ENUM_TaskLogBlockName.TASKLOG_Protect;
T_taskLog_Protect = parserLogData(taskLogDataRes,'BlockName',matchBlock);
matchBlock = ENUM_TaskLogBlockName.TASKLOG_Payload;
T_taskLog_Payload = parserLogData(taskLogDataRes,'BlockName',matchBlock);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput];
T_taskLog_ParserInput = parserLogData(taskLogDataRes,'BlockName',matchBlock);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserLogData(taskLogDataRes,'BlockName',matchBlock);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_FlightMode];
T_taskLog_FlightMode = parserLogData(taskLogDataRes,'BlockName',matchBlock);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput;
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
TT = parserLogData(taskLogDataRes,'BlockName',matchBlock);
%
SL_LOAD.TaskLog.T_taskLog_All = T_taskLog_All;
SL_LOAD.TaskLog.T_taskLog_Protect = T_taskLog_Protect;
SL_LOAD.TaskLog.T_taskLog_Payload = T_taskLog_Payload;
SL_LOAD.TaskLog.T_taskLog_ParserInput = T_taskLog_ParserInput;
SL_LOAD.TaskLog.T_taskLog_MavCmd = T_taskLog_MavCmd;
SL_LOAD.TaskLog.T_taskLog_FlightMode = T_taskLog_FlightMode;
%% 解析POS的时间
if 0
    idxsel_shot = find(T_taskLog_Payload.message == ENUM_RTInfo_Task.TaskLog_Payload_Camera_Shot);
    time_shot = T_taskLog_Payload.("记录时间")(idxsel_shot);
    num_shot = T_taskLog_Payload.var1(idxsel_shot,1);
    pos_data = [time_shot,num_shot];
    [~,ia] = unique(num_shot);
    pos_data = pos_data(ia,:);
    pos_data(end,:) = [];
end
% save('pos_timestamp.txt','pos_data','-ascii')