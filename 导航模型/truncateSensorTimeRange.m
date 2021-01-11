function [in_sensors,sensorsForSim] = truncateSensorTimeRange(in_sensors,tspan,busData)
sensorNames = fieldnames(in_sensors);
nSensor = length(sensorNames);
% 进行数据区间截取 ----------------------------------------------------
for i_sensor = 1:nSensor
    sensorName = sensorNames{i_sensor};
    sensorFullName = in_sensors.(sensorName);
    if isstruct(sensorFullName)
        childNames = fieldnames(in_sensors.(sensorName));
        nChild = length(childNames);
        for i_child = 1:nChild % 先行专门处理时间，防止time成员不在第一个位置的情况
            child = childNames{i_child};
            childFullName = in_sensors.(sensorName).(child);
            if strcmp(child,'time')
                eval(['idx1_',sensorName,' = childFullName<tspan(1) | childFullName>tspan(2);']);
            end
        end
        for i_child = 1:nChild
            child = childNames{i_child};
            if ~strcmp(child,'time')
                eval(['in_sensors.(sensorName).(child)(idx1_',sensorName,') = [];']);
            end
        end
        eval(['in_sensors.(sensorName).time(idx1_',sensorName,') = [];']);
    else
        idx_time = in_sensors.time<tspan(1) | in_sensors.time>tspan(2);
        in_sensors.time(idx_time) = [];
    end
end
if 0 % TEST
    figure;
    plot(temp.IN_SENSOR.IMU1.time,temp.IN_SENSOR.IMU1.gyro_x,'r');hold on;
    plot(in_sensors.IMU1.time,in_sensors.IMU1.gyro_x,'b--');hold on;
end
% 生成Simulink仿真数据 ----------------------------------------------------
AllSensorProp = busData.Elements;
for i_sensor = 1:nSensor % 遍历传感器
    sensorName = sensorNames{i_sensor};
    sensorFullName = in_sensors.(sensorName);
    for i_sensorProp = 1:length(AllSensorProp)
        if strcmp(AllSensorProp(i_sensorProp).Name,sensorName)
            sensorDataType = AllSensorProp(i_sensorProp).DataType;
        end
    end
    if isstruct(sensorFullName)
        childNames = fieldnames(in_sensors.(sensorName));
        
        tempIdx = strfind(sensorDataType,':');
        busName = strrep(sensorDataType(tempIdx+1:end),' ','');
        sensorBusData = evalin('base',busName);
        AllChildProp = sensorBusData.Elements;
        nChild = length(childNames);
        for i_child = 1:nChild
            child = childNames{i_child};
            for i_prop = 1:length(AllChildProp)
                if strcmp(AllChildProp(i_prop).Name,child) % 找到对应名称的成员属性
                    dataType = AllChildProp(i_prop).DataType;
                    eval(['sensorsForSim.(sensorName).(child).time = in_sensors.(sensorName).time;']);
                    eval(['sensorsForSim.(sensorName).(child).signals.values = ',dataType,'(in_sensors.(sensorName).(child));']);
                    break
                end
            end
        end
        
    else % 只有time是非结构体
        dataType = sensorDataType;
        eval(['sensorsForSim.(sensorName).time = in_sensors.time;']);
        eval(['sensorsForSim.(sensorName).signals.values = ',dataType,'(in_sensors.time);']);
    end
end

