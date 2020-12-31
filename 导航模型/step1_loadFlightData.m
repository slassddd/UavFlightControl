function [IN_SENSOR,IN_SENSOR_SIM,tspan,validflag,SL,SL_LOAD] = step1_loadFlightData(tspan,dataFileName,BUS_SENSOR)
fprintf('飞行数据文件:%s\n',dataFileName)
loadData = load(dataFileName,'IN_SENSOR','SL','SL_LOAD');
fprintf('IMU时间范围 [%.2f, %.2f]\n',loadData.IN_SENSOR.IMU1.time(1),loadData.IN_SENSOR.IMU1.time(end))
if tspan(2) > loadData.IN_SENSOR.IMU1.time(end)
    tspan(2) = loadData.IN_SENSOR.IMU1.time(end);
end
if tspan(2) < tspan(1) % 鏃堕棿鑼冨洿鏃犳晥
    validflag = false;
else
    validflag = true;
end
[loadData.IN_SENSOR,loadData.IN_SENSOR_SIM] = truncateSensorTimeRange(loadData.IN_SENSOR,tspan,BUS_SENSOR);
IN_SENSOR = loadData.IN_SENSOR;
IN_SENSOR_SIM = loadData.IN_SENSOR_SIM;
SL = loadData.SL;
SL_LOAD = loadData.SL_LOAD;