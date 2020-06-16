
taskLogDataRes(1).time_sec = out.taskLogData1.time_sec.Data;
taskLogDataRes(1).idx = out.taskLogData1.idx.Data;
taskLogDataRes(1).blockName = out.taskLogData1.blockName.Data;
taskLogDataRes(1).message = out.taskLogData1.message.Data;
taskLogDataRes(1).var1 = out.taskLogData1.var1.Data;
% taskLogDataRes(2).time_sec = out.taskLogData2.time_sec.Data;
% taskLogDataRes(2).idx = out.taskLogData2.idx.Data;
% taskLogDataRes(2).blockName = out.taskLogData1.blockName.Data;
% taskLogDataRes(2).message = out.taskLogData2.message.Data;
% taskLogDataRes(2).var1 = out.taskLogData2.var1.Data;
% taskLogDataRes(3).time_sec = out.taskLogData3.time_sec.Data;
% taskLogDataRes(3).idx = out.taskLogData3.idx.Data;
% taskLogDataRes(3).blockName = out.taskLogData1.blockName.Data;
% taskLogDataRes(3).message = out.taskLogData3.message.Data;
% taskLogDataRes(3).var1 = out.taskLogData3.var1.Data;
%%
T_taskLog_All = parserTaskLogData(taskLogDataRes);
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Protect;
T_taskLog_Protect = parserTaskLogData(taskLogDataRes,matchMessages);
matchMessages = ENUM_TaskLogBlockName.TASKLOG_Payload;
T_taskLog_Payload = parserTaskLogData(taskLogDataRes,matchMessages);
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput];
T_taskLog_ParserInput = parserTaskLogData(taskLogDataRes,matchMessages)
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserTaskLogData(taskLogDataRes,matchMessages)
matchMessages = [...
    ENUM_TaskLogBlockName.TASKLOG_FlightMode];
T_taskLog_FlightMode = parserTaskLogData(taskLogDataRes,matchMessages)