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
excludeMessages = [ENUM_RTInfo_Task.Payload_Camera_Shot,...
    ENUM_RTInfo_Task.WarningInfo_ShotTimeIntervalSmall,...
    ENUM_RTInfo_Task.BatteryInfo_AllZero]; % 排除的 messages
% excludeMessages = [ENUM_RTInfo_Task.Payload_Camera_Shot]; % 排除的 messages
% excludeMessages = [];
T_taskLog_All = parserLogData(taskLogDataRes,'exclude',excludeMessages);
matchBlock = ENUM_TaskLogBlockName.TASKLOG_Protect;
T_taskLog_Protect = parserLogData(taskLogDataRes,'BlockName',matchBlock,'exclude',excludeMessages);
matchBlock = ENUM_TaskLogBlockName.TASKLOG_Payload;
T_taskLog_Payload = parserLogData(taskLogDataRes,'BlockName',matchBlock,'exclude',excludeMessages);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput];
T_taskLog_ParserInput = parserLogData(taskLogDataRes,'BlockName',matchBlock,'exclude',excludeMessages);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
T_taskLog_MavCmd = parserLogData(taskLogDataRes,'BlockName',matchBlock,'exclude',excludeMessages);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_FlightMode];
T_taskLog_FlightMode = parserLogData(taskLogDataRes,'BlockName',matchBlock,'exclude',excludeMessages);
matchBlock = [...
    ENUM_TaskLogBlockName.TASKLOG_ParserInput;
    ENUM_TaskLogBlockName.TASKLOG_ParserCmd];
TT = parserLogData(taskLogDataRes,'BlockName',matchBlock);
matchMessages = [...
    ENUM_RTInfo_Task.PathFollow_PathPointInfo];
T_taskLog_PathInfo = parserLogData(taskLogDataRes,'messagename',matchMessages,'exclude',excludeMessages);

matchMessages = [...
    ENUM_RTInfo_Task.TaskLog_Payload_Lidar_BeginWork];
T_taskLog_LidarBegin = parserLogData(taskLogDataRes,'messagename',matchMessages,'exclude',excludeMessages);
matchMessages = [...
    ENUM_RTInfo_Task.TaskLog_Payload_Lidar_StandBy];
T_taskLog_LidarStop = parserLogData(taskLogDataRes,'messagename',matchMessages,'exclude',excludeMessages);


timeLidarBegin = [];
llaLidarBegin = [];
llaLidarStop = [];
nonzeroIdx = [];
flightLLA = [FlightLog_Original.OUT_TASKFLIGHTPARAM.time,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA0,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA1,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2];
nonzeroIdx = find(flightLLA(:,1)~=0 & flightLLA(:,2)~=0);
nonzeroIdx(1:10) = [];
flightLLA = flightLLA(nonzeroIdx,:);
timeLLA = flightLLA(:,1);
% flightLLA(:,1) = [];

timeLidarBegin = T_taskLog_LidarBegin.("记录时间"); 
for i = 1:length(timeLidarBegin)
    thisTime = timeLidarBegin(i);
    tempIdx = find(timeLLA>=thisTime);
    tempIdx = tempIdx(1);
    llaLidarBegin(i,:) = flightLLA(tempIdx,:); 
end
timeLidarStop = T_taskLog_LidarStop.("记录时间"); 
for i = 1:length(timeLidarStop)
    thisTime = timeLidarStop(i);
    tempIdx = find(timeLLA>=thisTime);
    tempIdx = tempIdx(1);
    llaLidarStop(i,:) = flightLLA(tempIdx,:); 
end
if 1 % 绘制雷达开关机
    figure('Name','雷达开关机点');
    % 航点
    llaPath = [];
    pathStruct = FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def;
    for i = 1:length(pathStruct)
        thisPathPoint = pathStruct(i);
        llaPath(i,:) = double([thisPathPoint.x,thisPathPoint.y,thisPathPoint.z]);
        if sum(llaPath(i,:)) == 0
            llaPath(i,:) = [];
            break;
        end
    end
    % 飞行轨迹
    flightLLA = [FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA0,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA1,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2];
    nonzeroIdx = find(flightLLA(:,1)~=0 & flightLLA(:,2)~=0);
    nonzeroIdx(1:10) = [];
    flightLLA = flightLLA(nonzeroIdx,:);
    plot(flightLLA(:,2),flightLLA(:,1),'-');hold on;grid on;
    plot(llaLidarBegin(:,3),llaLidarBegin(:,2),'go');hold on;grid on;
    plot(llaLidarStop(:,3),llaLidarStop(:,2),'r+');hold on;grid on;
    plot(llaPath(:,2),llaPath(:,1),'ko');hold on;
    plot(llaPath(1,2),llaPath(1,1),'co');hold on;
    legend('航线','开机','关机','航点','home点')
    xlabel('经度')
    ylabel('纬度')
    axis equal
    for i = 1:size(llaPath,1)
        thisOne = llaPath(i,:);
        str = sprintf('[path %03d]: %.5f %.5f',i-1,thisOne(2),thisOne(1));
        tempT = text(thisOne(2)+5e-5,thisOne(1),str);
        tempT.Color = 'k';
    end    
    for i = 1:length(timeLidarBegin)
        thisOne = llaLidarBegin(i,:);
        str = sprintf('[%.2f sec]: %.5f %.5f',thisOne(1),thisOne(3),thisOne(2));
        tempT = text(thisOne(3)+5e-5,thisOne(2)+2e-5,str);
        tempT.Color = 'g';
    end
    for i = 1:length(timeLidarStop)
        thisOne = llaLidarStop(i,:);
        str = sprintf('[%.2f sec]: %.5f %.5f',thisOne(1),thisOne(3),thisOne(2));
        tempT = text(thisOne(3)+5e-5,thisOne(2)-2e-5,str);
        tempT.Color = 'r';
    end
end
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