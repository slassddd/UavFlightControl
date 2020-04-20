function [sensors,sensorsForSim] = truncateSensorTimeRange1(sensors,tspan,busData)
sensorNames = fieldnames(sensors);
nSensor = length(sensorNames);
% �������������ȡ ----------------------------------------------------
for i_sensor = 1:nSensor
    sensorName = sensorNames{i_sensor};
    sensorFullName = sensors.(sensorName);
    if isstruct(sensorFullName)
        childNames = fieldnames(sensors.(sensorName));
        nChild = length(childNames);
        for i_child = 1:nChild % ����ר�Ŵ���ʱ�䣬��ֹtime��Ա���ڵ�һ��λ�õ����
            child = childNames{i_child};
            childFullName = sensors.(sensorName).(child);
            if strcmp(child,'time')
                eval(['idx1_',sensorName,' = childFullName<tspan(1) | childFullName>tspan(2);']);
            end
        end
        for i_child = 1:nChild
            child = childNames{i_child};
            if ~strcmp(child,'time')
                eval(['sensors.(sensorName).(child)(idx1_',sensorName,') = [];']);
            end
        end
        eval(['sensors.(sensorName).time(idx1_',sensorName,') = [];']);
    else
        idx_time = sensors.time<tspan(1) | sensors.time>tspan(2);
        sensors.time(idx_time) = [];
    end
end
if 0 % TEST
    figure;
    plot(temp.IN_SENSOR.IMU1.time,temp.IN_SENSOR.IMU1.gyro_x,'r');hold on;
    plot(sensors.IMU1.time,sensors.IMU1.gyro_x,'b--');hold on;
end
% ����Simulink�������� ----------------------------------------------------
AllSensorProp = busData.Elements;
for i_sensor = 1:nSensor % ����������
    sensorName = sensorNames{i_sensor};
    sensorFullName = sensors.(sensorName);
    for i_sensorProp = 1:length(AllSensorProp)
        if strcmp(AllSensorProp(i_sensorProp).Name,sensorName)
            sensorDataType = AllSensorProp(i_sensorProp).DataType;
        end
    end
    if isstruct(sensorFullName)
        childNames = fieldnames(sensors.(sensorName));
        
        tempIdx = strfind(sensorDataType,':');
        busName = strrep(sensorDataType(tempIdx+1:end),' ','');
        sensorBusData = evalin('base',busName);
        AllChildProp = sensorBusData.Elements;
        nChild = length(childNames);
        for i_child = 1:nChild
            child = childNames{i_child};
            for i_prop = 1:length(AllChildProp)
                if strcmp(AllChildProp(i_prop).Name,child) % �ҵ���Ӧ���Ƶĳ�Ա����
                    dataType = AllChildProp(i_prop).DataType;
                    eval(['sensorsForSim.(sensorName).(child).time = sensors.(sensorName).time;']);
                    eval(['sensorsForSim.(sensorName).(child).signals.values = ',dataType,'(sensors.(sensorName).(child));']);
                    break
                end
            end
        end
        
    else % ֻ��time�Ƿǽṹ��
        dataType = sensorDataType;
        eval(['sensorsForSim.(sensorName).time = sensors.time;']);
        eval(['sensorsForSim.(sensorName).signals.values = ',dataType,'(sensors.time);']);
    end
end

