% 解析taskLogData
taskLogData1 = SL.Debug_TaskLogData;
taskLogDataRes(1).time_sec = taskLogData1.time_sec;
taskLogDataRes(1).idx = taskLogData1.idx;
taskLogDataRes(1).blockName = ENUM_TaskLogBlockName(taskLogData1.blockName);
taskLogDataRes(1).message = ENUM_RTInfo_Task(taskLogData1.message);
taskLogDataRes(1).var1 = [taskLogData1.var10,taskLogData1.var11,...
    taskLogData1.var12,taskLogData1.var13,taskLogData1.var14];
%%
T_taskLog_All = parserTaskLogData(taskLogDataRes);
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Protect;
T_taskLog_Protect = parserTaskLogData(taskLogDataRes,matchMessages);
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Payload;
T_taskLog_Payload = parserTaskLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput];
T_taskLog_ParserInput = parserTaskLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserTaskLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_FlightMode];
T_taskLog_FlightMode = parserTaskLogData(taskLogDataRes,matchMessages);