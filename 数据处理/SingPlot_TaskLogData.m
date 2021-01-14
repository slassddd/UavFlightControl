% 解析taskLogData
taskLogData1 = FlightLog_Original.Debug_TaskLogData;
idxValid = [];
for i = 1:length(taskLogData1.message)
    try % 防止ENUM_RTInfo_Task中成员改名造成的错误
        ENUM_RTInfo_Task(taskLogData1.message(i));
        idxValid = [idxValid i];
    end
end
clear taskLogDataRes;
taskLogDataRes(1).time_sec = taskLogData1.time_sec(idxValid);
taskLogDataRes(1).idx = taskLogData1.idx(idxValid);
taskLogDataRes(1).blockName = ENUM_TaskLogBlockName(taskLogData1.blockName(idxValid));
taskLogDataRes(1).message = ENUM_RTInfo_Task(taskLogData1.message(idxValid));
taskLogDataRes(1).var1 = [taskLogData1.var10(idxValid),taskLogData1.var11(idxValid),...
    taskLogData1.var12(idxValid),taskLogData1.var13(idxValid),taskLogData1.var14(idxValid)];
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
FlightLog_SecondProc.TaskLog.T_taskLog_All = T_taskLog_All;
FlightLog_SecondProc.TaskLog.T_taskLog_Protect = T_taskLog_Protect;
FlightLog_SecondProc.TaskLog.T_taskLog_Payload = T_taskLog_Payload;
FlightLog_SecondProc.TaskLog.T_taskLog_ParserInput = T_taskLog_ParserInput;
FlightLog_SecondProc.TaskLog.T_taskLog_MavCmd = T_taskLog_MavCmd;
FlightLog_SecondProc.TaskLog.T_taskLog_FlightMode = T_taskLog_FlightMode;
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