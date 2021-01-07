
TaskLog_SimRes(1).time_sec = out.Task_logData1.time_sec.Data;
TaskLog_SimRes(1).idx = out.Task_logData1.idx.Data;
TaskLog_SimRes(1).blockName = out.Task_logData1.blockName.Data;
TaskLog_SimRes(1).message = out.Task_logData1.message.Data;
TaskLog_SimRes(1).var1 = out.Task_logData1.var1.Data;
%%
TaskLog_All = parserLogData(TaskLog_SimRes)
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Protect;
TaskLog_Protect = parserLogData(TaskLog_SimRes,matchMessages);
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Payload;
TaskLog_Payload = parserLogData(TaskLog_SimRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput];
TaskLog_ParserInput = parserLogData(TaskLog_SimRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
TaskLog_MavCmd = parserLogData(TaskLog_SimRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_FlightMode];
TaskLog_FlightMode = parserLogData(TaskLog_SimRes,matchMessages);