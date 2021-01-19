function [time,data,info] = setSensorFault(data,time,dataPair)
sensorNames = dataPair(:,1);
faultTypes = dataPair(:,2);
nSensor = length(sensorNames);
nType = length(faultTypes);
%% 数据检查
if nSensor > 1 && nType == 1
    for i = 2:nSensor
        faultTypes{i} = faultTypes{1};
    end
end
% 维数检查
if nType > 1 && nSensor ~= nType
    error('传感器维数与fault维数不一致');
end
% sensor名称检查
dataFields = fieldnames(data);
for i_sensor = 1:length(nSensor)
    thisSensor = sensorNames{i_sensor}; 
    isFind = false;
    for i_field = 1:length(dataFields)
        thisField = dataFields{i_field};
        if strcmp(thisSensor,thisField)
            isFind = true; 
            break;
        end
    end
    if ~isFind
        error('不存在与结构体成员相匹配的传感器名称: 传感器名称（%s）\n',thisSensor);
    end
end
%%
for i = 1:nSensor
    thisSensor = sensorNames{i};
    thisFault = faultTypes{i};
    data.(thisSensor).status = thisFault;
end
% 显示信息
info = sprintf('%.2f [sec]:',time);
for i = 1:nSensor
    thisSensor = sensorNames{i};
    thisFault = faultTypes{i};
    info = [info,sprintf('\t{%s:%s.%s}',thisSensor,class(thisFault),thisFault)];
end

