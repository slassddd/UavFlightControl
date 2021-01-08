function DataSet = loadFlightData(tspan0,dataFileNames,BUS_SENSOR)
%% output
% IN_SENSOR_SIM_SET: 用于from workspace模块
DataSet.nFlightDataFile = length(dataFileNames);
for i = 1:DataSet.nFlightDataFile
    thisDataSet = sub_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    DataSet.IN_SENSOR(i) = thisDataSet.IN_SENSOR;
    DataSet.IN_SENSOR_SIM(i) = thisDataSet.IN_SENSOR_SIM;
    DataSet.FlightLog_Original(i) = thisDataSet.FlightLog_Original;
    DataSet.FlightLog_SecondProc(i) = thisDataSet.FlightLog_SecondProc;
    DataSet.tspan{i} = thisDataSet.tspan;
    DataSet.validflag = thisDataSet.validflag;
    if ~DataSet.validflag
        str = sprintf('第%d号数据 (%s) 的时间设置错误: 中止时间(%d) < 起始时间(%d)',i,dataFileNames{i},int64(DataSet.tspan{i}(2)),int64(DataSet.tspan{i}(1)));
        fprintf('[ERROR] %s\n',str);
        fprintf('[END] 退出仿真\n');
        warndlg(str)
        return;
    else
        fprintf('仿真数据的IMU时间范围 [%.2f, %.2f]\n',DataSet.tspan{i}(1),DataSet.tspan{i}(2))
    end
end