
taskLogDataRes(1).time_sec = out.Task_logData1.time_sec.Data;
taskLogDataRes(1).idx = out.Task_logData1.idx.Data;
taskLogDataRes(1).blockName = out.Task_logData1.blockName.Data;
taskLogDataRes(1).message = out.Task_logData1.message.Data;
taskLogDataRes(1).var1 = out.Task_logData1.var1.Data;
%%
T_taskLog_All = parserLogData(taskLogDataRes)
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Protect;
T_taskLog_Protect = parserLogData(taskLogDataRes,matchMessages);
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Payload;
T_taskLog_Payload = parserLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput];
T_taskLog_ParserInput = parserLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_FlightMode];
T_taskLog_FlightMode = parserLogData(taskLogDataRes,matchMessages);