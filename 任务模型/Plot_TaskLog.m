for i_sim = 1:length(out)
    TaskLog_SimRes(1).time_sec = out(i_sim).Task_logData1.time_sec.Data;
    TaskLog_SimRes(1).idx = out(i_sim).Task_logData1.idx.Data;
    TaskLog_SimRes(1).blockName = out(i_sim).Task_logData1.blockName.Data;
    TaskLog_SimRes(1).message = out(i_sim).Task_logData1.message.Data;
    TaskLog_SimRes(1).var1 = out(i_sim).Task_logData1.var1.Data;
    %%
    excludeMessages = [ENUM_RTInfo_Task.Payload_Camera_Shot,ENUM_RTInfo_Task.WarningInfo_ShotTimeIntervalSmall]; % 排除的 messages
    excludeMessages = [];
    TaskLog_All = parserLogData(TaskLog_SimRes,'exclude',excludeMessages)
    matchBlocks = ENUM_TaskLogBlockName.TASKLOG_Protect;
    TaskLog_Protect = parserLogData(TaskLog_SimRes,'BlockName',matchBlocks,'exclude',excludeMessages);
    matchBlocks = ENUM_TaskLogBlockName.TASKLOG_Payload;
    TaskLog_Payload = parserLogData(TaskLog_SimRes,'BlockName',matchBlocks,'exclude',excludeMessages);
    matchBlocks = [...
        ENUM_TaskLogBlockName.TASKLOG_ParserInput];
    TaskLog_ParserInput = parserLogData(TaskLog_SimRes,'BlockName',matchBlocks,'exclude',excludeMessages);
    matchBlocks = [...
        ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
    TaskLog_MavCmd = parserLogData(TaskLog_SimRes,'BlockName',matchBlocks,'exclude',excludeMessages);
    matchBlocks = [...
        ENUM_TaskLogBlockName.TASKLOG_FlightMode];
    TaskLog_FlightMode = parserLogData(TaskLog_SimRes,'BlockName',matchBlocks,'exclude',excludeMessages);
    
    matchMessages = [...
        ENUM_RTInfo_Task.PathFollow_PathPointInfo];
    T_taskLog_PathInfo = parserLogData(TaskLog_SimRes,'messagename',matchMessages,'exclude',excludeMessages);
    if ~isempty(T_taskLog_PathInfo)
    [mavPathPoints,pathtype] = getPathInfo(T_taskLog_PathInfo);
    end
    
    matchBlocks = [...
        ENUM_TaskLogBlockName.TASKLOG_Warning];
    TaskLog_Warning = parserLogData(TaskLog_SimRes,'BlockName',matchBlocks,'exclude',excludeMessages);    
end