function [timeData,meanCurrentData,meanVoltageData,meanPowerData] = SinglePlot_CurrentPower(current,voltage,taskMode,uavMode,timeTask)
%% 输入说明
% current:  全程电流 [A]
% voltage:  全程电压 [V]
% taskMode: 任务模式
% timeTask: 任务模式对应的时间 [sec]
%%
current = abs(current);
voltage = abs(voltage);
% GroundStandByMode
thisMode = ENUM_FlightTaskMode.GroundStandByMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.GroundStandByMode = sumTime;
meanCurrentData.GroundStandByMode = meanCurrentDataTemp;
maxCurrentData.GroundStandByMode = maxCurrentDataTemp;
meanmax1_CurrentData.GroundStandByMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.GroundStandByMode = meanmax5_CurrentDataTemp;
meanVoltageData.GroundStandByMode = meanVoltageDataTemp;
meanPowerData.GroundStandByMode = meanPowerDataTemp;
% TakeOffMode
thisMode = ENUM_FlightTaskMode.TakeOffMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.TakeOffMode = sumTime;
meanCurrentData.TakeOffMode = meanCurrentDataTemp;
maxCurrentData.TakeOffMode = maxCurrentDataTemp;
meanmax1_CurrentData.TakeOffMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.TakeOffMode = meanmax5_CurrentDataTemp;
meanVoltageData.TakeOffMode = meanVoltageDataTemp;
meanPowerData.TakeOffMode = meanPowerDataTemp;
% HoverAdjustMode
thisMode = ENUM_FlightTaskMode.HoverAdjustMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.HoverAdjustMode = sumTime;
meanCurrentData.HoverAdjustMode = meanCurrentDataTemp;
maxCurrentData.HoverAdjustMode = maxCurrentDataTemp;
meanmax1_CurrentData.HoverAdjustMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.HoverAdjustMode = meanmax5_CurrentDataTemp;
meanVoltageData.HoverAdjustMode = meanVoltageDataTemp;
meanPowerData.HoverAdjustMode = meanPowerDataTemp;
% Rotor2Fix_Mode
thisMode = ENUM_FlightTaskMode.Rotor2Fix_Mode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.Rotor2Fix_Mode = sumTime;
meanCurrentData.Rotor2Fix_Mode = meanCurrentDataTemp;
maxCurrentData.Rotor2Fix_Mode = maxCurrentDataTemp;
meanmax1_CurrentData.Rotor2Fix_Mode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.Rotor2Fix_Mode = meanmax5_CurrentDataTemp;
meanVoltageData.Rotor2Fix_Mode = meanVoltageDataTemp;
meanPowerData.Rotor2Fix_Mode = meanPowerDataTemp;
% HoverUpMode
thisMode = ENUM_FlightTaskMode.HoverUpMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.HoverUpMode = sumTime;
meanCurrentData.HoverUpMode = meanCurrentDataTemp;
maxCurrentData.HoverUpMode = maxCurrentDataTemp;
meanmax1_CurrentData.HoverUpMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.HoverUpMode = meanmax5_CurrentDataTemp;
meanVoltageData.HoverUpMode = meanVoltageDataTemp;
meanPowerData.HoverUpMode = meanPowerDataTemp;
% PathFollowMode
thisMode = ENUM_FlightTaskMode.PathFollowMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.PathFollowMode = sumTime;
meanCurrentData.PathFollowMode = meanCurrentDataTemp;
maxCurrentData.PathFollowMode = maxCurrentDataTemp;
meanmax1_CurrentData.PathFollowMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.PathFollowMode = meanmax5_CurrentDataTemp;
meanVoltageData.PathFollowMode = meanVoltageDataTemp;
meanPowerData.PathFollowMode = meanPowerDataTemp;
% GoHomeMode固定翼
thisMode = ENUM_FlightTaskMode.GoHomeMode;
thisUav = ENUM_UAVMode.Fix;
timeDataTemp = timeTask;
if sum(taskMode == thisMode) > 0
    %%
    timeDataTemp(taskMode ~= thisMode | uavMode ~= thisUav) = [];
    dTime = diff(timeDataTemp);
    idxTime = find(dTime > 10);
    if isempty(idxTime)
        try
            sumTime = timeDataTemp(end) - timeDataTemp(1);
        catch
            sumTime = 0;
        end
    else
        sumTime = timeDataTemp(idxTime(1)) - timeDataTemp(1);
        for i = 1:length(idxTime)
            if i ~= length(idxTime)
                sumTime = sumTime + timeDataTemp(idxTime(i+1)) - timeDataTemp(idxTime(i)+1);
            else
                sumTime = sumTime + timeDataTemp(end) - timeDataTemp(idxTime(i)+1);
            end
        end
    end    
    %%
    idxDataTemp = find(taskMode == thisMode & uavMode == thisUav);
    currentDataTemp = current;
    voltageDataTemp = voltage;
    if ~isempty(idxDataTemp)        
        meanCurrentDataTemp = mean(currentDataTemp(idxDataTemp)); % A
        maxCurrentDataTemp = max(currentDataTemp(idxDataTemp)); % A
        meanmax1_CurrentDataTemp = getMaxPer(currentDataTemp(idxDataTemp),0.01); % A 最大1%
        meanmax5_CurrentDataTemp = getMaxPer(currentDataTemp(idxDataTemp),0.05); % A 最大5%
        meanVoltageDataTemp = mean(voltageDataTemp(idxDataTemp)); % V
        meanPowerDataTemp = mean(currentDataTemp(idxDataTemp).*voltageDataTemp(idxDataTemp)); % W
    else
        meanCurrentDataTemp = nan; % A
        maxCurrentDataTemp = nan; % A
        meanmax1_CurrentDataTemp = nan; % A 最大1%
        meanmax5_CurrentDataTemp = nan; % A 最大5%
        meanVoltageDataTemp = nan; % V
        meanPowerDataTemp = nan; % W        
    end
    fprintf('%s-%s:\t 平均功耗 %.2f [W], 平均电流 %.2f [A], 平均电压 %.2f [V]\n',thisMode,thisUav,meanPowerDataTemp,meanCurrentDataTemp,meanVoltageDataTemp)
else
    k = nan;
    sumTime = k;
    meanCurrentDataTemp = k;
    maxCurrentDataTemp = k;
    meanmax1_CurrentDataTemp = k;
    meanmax5_CurrentDataTemp = k;
    meanVoltageDataTemp = k;
    meanPowerDataTemp = k;    
    fprintf('该组数据不存在 %s\n',thisMode)
end
timeData.GoHomeMode_Fix = sumTime;
meanCurrentData.GoHomeMode_Fix = meanCurrentDataTemp;
maxCurrentData.GoHomeMode_Fix = maxCurrentDataTemp;
meanmax1_CurrentData.GoHomeMode_Fix = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.GoHomeMode_Fix = meanmax5_CurrentDataTemp;
meanVoltageData.GoHomeMode_Fix = meanVoltageDataTemp;
meanPowerData.GoHomeMode_Fix = meanPowerDataTemp;
% GoHomeMode旋翼
thisMode = ENUM_FlightTaskMode.GoHomeMode;
thisUav = ENUM_UAVMode.Rotor;
timeDataTemp = timeTask;
if sum(taskMode == thisMode) > 0
    %%
    timeDataTemp(taskMode ~= thisMode | uavMode ~= thisUav) = [];
    dTime = diff(timeDataTemp);
    idxTime = find(dTime > 10);
    if isempty(idxTime)
        sumTime = timeDataTemp(end) - timeDataTemp(1);
    else
        sumTime = timeDataTemp(idxTime(1)) - timeDataTemp(1);
        for i = 1:length(idxTime)
            if i ~= length(idxTime)
                sumTime = sumTime + timeDataTemp(idxTime(i+1)) - timeDataTemp(idxTime(i)+1);
            else
                sumTime = sumTime + timeDataTemp(end) - timeDataTemp(idxTime(i)+1);
            end
        end
    end    
    %%
    idxDataTemp = find(taskMode == thisMode & uavMode == thisUav);
    currentDataTemp = current;
    voltageDataTemp = voltage;
    meanCurrentDataTemp = mean(currentDataTemp(idxDataTemp)); % A
    maxCurrentDataTemp = max(currentDataTemp(idxDataTemp)); % A
    meanmax1_CurrentDataTemp = getMaxPer(currentDataTemp(idxDataTemp),0.01); % A 最大1%
    meanmax5_CurrentDataTemp = getMaxPer(currentDataTemp(idxDataTemp),0.05); % A 最大5%    
    meanVoltageDataTemp = mean(voltageDataTemp(idxDataTemp)); % V
    meanPowerDataTemp = mean(currentDataTemp(idxDataTemp).*voltageDataTemp(idxDataTemp)); % W
    fprintf('%s-%s:\t 平均功耗 %.2f [W], 平均电流 %.2f [A], 平均电压 %.2f [V]\n',thisMode,thisUav,meanPowerDataTemp,meanCurrentDataTemp,meanVoltageDataTemp)
else
    k = nan;
    sumTime = k;
    meanCurrentDataTemp = k;
    maxCurrentDataTemp = k;
    meanmax1_CurrentDataTemp = k;
    meanmax5_CurrentDataTemp = k;
    meanVoltageDataTemp = k;
    meanPowerDataTemp = k;    
    fprintf('该组数据不存在 %s\n',thisMode)
end
timeData.GoHomeMode_Rotor = sumTime;
meanCurrentData.GoHomeMode_Rotor = meanCurrentDataTemp;
maxCurrentData.GoHomeMode_Rotor = maxCurrentDataTemp;
meanmax1_CurrentData.GoHomeMode_Rotor = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.GoHomeMode_Rotor = meanmax5_CurrentDataTemp;
meanVoltageData.GoHomeMode_Rotor = meanVoltageDataTemp;
meanPowerData.GoHomeMode_Rotor = meanPowerDataTemp;
% HoverDownMode
thisMode = ENUM_FlightTaskMode.HoverDownMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.HoverDownMode = sumTime;
meanCurrentData.HoverDownMode = meanCurrentDataTemp;
maxCurrentData.HoverDownMode = maxCurrentDataTemp;
meanmax1_CurrentData.HoverDownMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.HoverDownMode = meanmax5_CurrentDataTemp;
meanVoltageData.HoverDownMode = meanVoltageDataTemp;
meanPowerData.HoverDownMode = meanPowerDataTemp;
% Fix2Rotor_Mode
thisMode = ENUM_FlightTaskMode.Fix2Rotor_Mode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.Fix2Rotor_Mode = sumTime;
meanCurrentData.Fix2Rotor_Mode = meanCurrentDataTemp;
maxCurrentData.Fix2Rotor_Mode = maxCurrentDataTemp;
meanmax1_CurrentData.Fix2Rotor_Mode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.Fix2Rotor_Mode = meanmax5_CurrentDataTemp;
meanVoltageData.Fix2Rotor_Mode = meanVoltageDataTemp;
meanPowerData.Fix2Rotor_Mode = meanPowerDataTemp;
% LandMode
thisMode = ENUM_FlightTaskMode.LandMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.LandMode = sumTime;
meanCurrentData.LandMode = meanCurrentDataTemp;
maxCurrentData.LandMode = maxCurrentDataTemp;
meanmax1_CurrentData.LandMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.LandMode = meanmax5_CurrentDataTemp;
meanVoltageData.LandMode = meanVoltageDataTemp;
meanPowerData.LandMode = meanPowerDataTemp;
% AirStandByMode
thisMode = ENUM_FlightTaskMode.AirStandByMode;
[sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeTask,thisMode,current,voltage,taskMode,uavMode);
timeData.AirStandByMode = sumTime;
meanCurrentData.AirStandByMode = meanCurrentDataTemp;
maxCurrentData.AirStandByMode = maxCurrentDataTemp;
meanmax1_CurrentData.AirStandByMode = meanmax1_CurrentDataTemp;
meanmax5_CurrentData.AirStandByMode = meanmax5_CurrentDataTemp;
meanVoltageData.AirStandByMode = meanVoltageDataTemp;
meanPowerData.AirStandByMode = meanPowerDataTemp;
%%
time = [...
    timeData.GroundStandByMode;
    timeData.TakeOffMode;
    timeData.HoverAdjustMode;
    timeData.Rotor2Fix_Mode;
    timeData.HoverUpMode;
    timeData.PathFollowMode;
    timeData.GoHomeMode_Fix;
    timeData.GoHomeMode_Rotor;
    timeData.HoverDownMode;
    timeData.Fix2Rotor_Mode;
    timeData.LandMode;
    timeData.AirStandByMode;];
time = round(time,1);
% 平均功率
meanPower = [...
    meanPowerData.GroundStandByMode;
    meanPowerData.TakeOffMode;
    meanPowerData.HoverAdjustMode;
    meanPowerData.Rotor2Fix_Mode;
    meanPowerData.HoverUpMode;
    meanPowerData.PathFollowMode;
    meanPowerData.GoHomeMode_Fix;
    meanPowerData.GoHomeMode_Rotor;
    meanPowerData.HoverDownMode;
    meanPowerData.Fix2Rotor_Mode;
    meanPowerData.LandMode;
    meanPowerData.AirStandByMode;];
meanPower = round(meanPower); % 数值较大，取整方便查看
% 平均电流
meanCurrent = [...
    meanCurrentData.GroundStandByMode;
    meanCurrentData.TakeOffMode;
    meanCurrentData.HoverAdjustMode;
    meanCurrentData.Rotor2Fix_Mode;
    meanCurrentData.HoverUpMode;
    meanCurrentData.PathFollowMode;
    meanCurrentData.GoHomeMode_Fix;
    meanCurrentData.GoHomeMode_Rotor;
    meanCurrentData.HoverDownMode;
    meanCurrentData.Fix2Rotor_Mode;
    meanCurrentData.LandMode;
    meanCurrentData.AirStandByMode;];
meanCurrent = round(meanCurrent,1);
% 最大电流
maxCurrent = [...
    maxCurrentData.GroundStandByMode;
    maxCurrentData.TakeOffMode;
    maxCurrentData.HoverAdjustMode;
    maxCurrentData.Rotor2Fix_Mode;
    maxCurrentData.HoverUpMode;
    maxCurrentData.PathFollowMode;
    maxCurrentData.GoHomeMode_Fix;
    maxCurrentData.GoHomeMode_Rotor;
    maxCurrentData.HoverDownMode;
    maxCurrentData.Fix2Rotor_Mode;
    maxCurrentData.LandMode;
    maxCurrentData.AirStandByMode;];
maxCurrent = round(maxCurrent,1);
% 最大1%电流
meanmax1_Current = [...
    meanmax1_CurrentData.GroundStandByMode;
    meanmax1_CurrentData.TakeOffMode;
    meanmax1_CurrentData.HoverAdjustMode;
    meanmax1_CurrentData.Rotor2Fix_Mode;
    meanmax1_CurrentData.HoverUpMode;
    meanmax1_CurrentData.PathFollowMode;
    meanmax1_CurrentData.GoHomeMode_Fix;
    meanmax1_CurrentData.GoHomeMode_Rotor;
    meanmax1_CurrentData.HoverDownMode;
    meanmax1_CurrentData.Fix2Rotor_Mode;
    meanmax1_CurrentData.LandMode;
    meanmax1_CurrentData.AirStandByMode;];
meanmax1_Current = round(meanmax1_Current,1);
% 最大5%电流
meanmax5_Current = [...
    meanmax5_CurrentData.GroundStandByMode;
    meanmax5_CurrentData.TakeOffMode;
    meanmax5_CurrentData.HoverAdjustMode;
    meanmax5_CurrentData.Rotor2Fix_Mode;
    meanmax5_CurrentData.HoverUpMode;
    meanmax5_CurrentData.PathFollowMode;
    meanmax5_CurrentData.GoHomeMode_Fix;
    meanmax5_CurrentData.GoHomeMode_Rotor;
    meanmax5_CurrentData.HoverDownMode;
    meanmax5_CurrentData.Fix2Rotor_Mode;
    meanmax5_CurrentData.LandMode;
    meanmax5_CurrentData.AirStandByMode;];
meanmax5_Current = round(meanmax5_Current,1);
% 平均电压
meanVoltage = [...
    meanVoltageData.GroundStandByMode;
    meanVoltageData.TakeOffMode;
    meanVoltageData.HoverAdjustMode;
    meanVoltageData.Rotor2Fix_Mode;
    meanVoltageData.HoverUpMode;
    meanVoltageData.PathFollowMode;
    meanVoltageData.GoHomeMode_Fix;
    meanVoltageData.GoHomeMode_Rotor;
    meanVoltageData.HoverDownMode;
    meanVoltageData.Fix2Rotor_Mode;
    meanVoltageData.LandMode;
    meanVoltageData.AirStandByMode;];
meanVoltage = round(meanVoltage,1);
nameRow = {'GroundStandby','TakeOff','HoverAdjustMode','Rotor2fix','HoverUp','PathFollow','GoHome_Fix','GoHome_Rotor','HoverDown','Fix2Rotor','Land','AirStandBy'};
InfoTable = table(time,meanPower,meanCurrent,maxCurrent,meanmax1_Current,meanmax5_Current,meanVoltage);
InfoTable.Row = nameRow;
InfoTable.Properties.VariableNames = {'持续时间[sec]','平均功率[W]','平均电流[A]','最大电流[A]','1%最大电流[A]','5%最大电流[A]','平均电压[V]'};
InfoTable
% 功率由高到低排列
[~,idxPowerOrder] = sort(meanPower,'descend');
InfoTable = table(time(idxPowerOrder),meanPower(idxPowerOrder),meanCurrent(idxPowerOrder),maxCurrent(idxPowerOrder),meanmax1_Current(idxPowerOrder),meanmax5_Current(idxPowerOrder),meanVoltage(idxPowerOrder));
InfoTable.Row = nameRow(idxPowerOrder);
InfoTable.Properties.VariableNames = {'持续时间[sec]','平均功率[W]','平均电流[A]','最大电流[A]','1%最大电流[A]','5%最大电流[A]','平均电压[V]'};
InfoTable
end

%% 子函数
function [sumTime,meanCurrentDataTemp,maxCurrentDataTemp,meanmax1_CurrentDataTemp,meanmax5_CurrentDataTemp,meanVoltageDataTemp,meanPowerDataTemp] = commonCal(timeDataTemp,thisMode,current,voltage,taskMode,uavMode)
if sum(taskMode == thisMode) > 0
    timeDataTemp(taskMode ~= thisMode) = [];
    dTime = diff(timeDataTemp);
    idxTime = find(dTime > 10);
    if isempty(idxTime)
        sumTime = timeDataTemp(end) - timeDataTemp(1);
    else
        sumTime = timeDataTemp(idxTime(1)) - timeDataTemp(1);
        for i = 1:length(idxTime)
            if i ~= length(idxTime)
                sumTime = sumTime + timeDataTemp(idxTime(i+1)) - timeDataTemp(idxTime(i)+1);
            else
                sumTime = sumTime + timeDataTemp(end) - timeDataTemp(idxTime(i)+1);
            end
        end
    end
    idxDataTemp = find(taskMode == thisMode);
    currentDataTemp = current;
    voltageDataTemp = voltage;
    meanCurrentDataTemp = mean(currentDataTemp(idxDataTemp)); % A
    maxCurrentDataTemp = max(currentDataTemp(idxDataTemp)); % A
    meanmax1_CurrentDataTemp = getMaxPer(currentDataTemp(idxDataTemp),0.01); % A 最大1%
    meanmax5_CurrentDataTemp = getMaxPer(currentDataTemp(idxDataTemp),0.05); % A 最大5%
    meanVoltageDataTemp = mean(voltageDataTemp(idxDataTemp)); % V
    meanPowerDataTemp = mean(currentDataTemp(idxDataTemp).*voltageDataTemp(idxDataTemp)); % W
    fprintf('%s:\t 平均功耗 %.2f [W], 平均电流 %.2f [A], 平均电压 %.2f [V]\n',thisMode,meanPowerDataTemp,meanCurrentDataTemp,meanVoltageDataTemp)
else
    k = nan;
    sumTime = k;
    meanCurrentDataTemp = k;
    maxCurrentDataTemp = k;
    meanmax1_CurrentDataTemp = k;
    meanmax5_CurrentDataTemp = k;
    meanVoltageDataTemp = k;
    meanPowerDataTemp = k;
    fprintf('该组数据不存在 %s\n',thisMode)
end
end
%
function meanData = getMaxPer(data,p)
% 获取最大%p数据的均值
nData = length(data);
nReq = round(nData*p);
data_sort = sort(data,'descend');
meanData = mean(data_sort(1:nReq));
end
