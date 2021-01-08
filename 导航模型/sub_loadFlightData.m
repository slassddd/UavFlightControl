function DataSet = sub_loadFlightData(tspan,dataFileName,BUS_SENSOR)
fprintf('log file:\t%s\n',dataFileName)
loadData = load(dataFileName,'IN_SENSOR','FlightLog_Original','FlightLog_SecondProc');
fprintf('IMU time span: [%.2f, %.2f]\n',loadData.IN_SENSOR.IMU1.time(1),loadData.IN_SENSOR.IMU1.time(end))
if tspan(2) > loadData.IN_SENSOR.IMU1.time(end)
    tspan(2) = loadData.IN_SENSOR.IMU1.time(end);
end
if tspan(2) < tspan(1) % Ê±¼äÒì³£ÅÐ¶Ï
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