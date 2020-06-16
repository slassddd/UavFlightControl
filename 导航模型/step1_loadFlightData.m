function [IN_SENSOR,IN_SENSOR_SIM,sensors,tspan,validflag] = step1_loadFlightData(tspan,dataFileName,BUS_SENSOR)
fprintf('�����������:%s\n',dataFileName)
temp = load(dataFileName,'IN_SENSOR','sensors');
fprintf('�������ݵ�IMUʱ�䷶Χ [%.2f, %.2f]\n',temp.sensors.IMU.time_imu(1),temp.sensors.IMU.time_imu(end))
if tspan(2) > temp.sensors.IMU.time_imu(end)
    tspan(2) = temp.sensors.IMU.time_imu(end);
end
if tspan(2) < tspan(1) % ʱ�䷶Χ��Ч
    validflag = false;
else
    validflag = true;
end
[temp.IN_SENSOR,temp.IN_SENSOR_SIM] = truncateSensorTimeRange1(temp.IN_SENSOR,tspan,BUS_SENSOR);
IN_SENSOR = temp.IN_SENSOR;
IN_SENSOR_SIM = temp.IN_SENSOR_SIM;
sensors = truncateSensorTimeRange(temp.sensors,tspan);

