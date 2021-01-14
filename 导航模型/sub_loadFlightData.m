function DataSet = sub_loadFlightData(tspan,dataFileName,BUS_SENSOR)
global GLOBAL_PARAM
loadData = load(dataFileName,'IN_SENSOR','FlightLog_Original','FlightLog_SecondProc');
fprintf('%sIMU time span: [%.2f, %.2f]\n',GLOBAL_PARAM.Print.lineHead,...
    loadData.IN_SENSOR.IMU1.time(1),loadData.IN_SENSOR.IMU1.time(end));
if tspan(2) > loadData.IN_SENSOR.IMU1.time(end-1)
    tspan(2) = loadData.IN_SENSOR.IMU1.time(end-1);
end
if tspan(2) < tspan(1) % 时间异常判断
    validflag = false;
else
    validflag = true;
end
[loadData.IN_SENSOR,loadData.IN_SENSOR_SIM] = truncateSensorTimeRange(loadData.IN_SENSOR,tspan,BUS_SENSOR);

DataSet.IN_SENSOR = loadData.IN_SENSOR;
DataSet.IN_SENSOR_SIM = loadData.IN_SENSOR_SIM;
DataSet.FlightLog_Original = loadData.FlightLog_Original;
DataSet.FlightLog_SecondProc = loadData.FlightLog_SecondProc;
DataSet.tspan = tspan;
DataSet.validflag = validflag;