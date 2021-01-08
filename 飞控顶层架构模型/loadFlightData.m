function DataSet = loadFlightData(tspan0,dataFileNames,BUS_SENSOR)
global GLOBAL_PARAM
%% output
% IN_SENSOR_SIM_SET: 用于from workspace模块
DataSet.nFlightDataFile = length(dataFileNames);
for i = 1:DataSet.nFlightDataFile
    fprintf('%slog file:\t%s\n',GLOBAL_PARAM.Print.lineHead,dataFileNames{i});
    thisDataSet = sub_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    DataSet.IN_SENSOR(i) = thisDataSet.IN_SENSOR;
    DataSet.IN_SENSOR_SIM(i) = thisDataSet.IN_SENSOR_SIM;
    DataSet.FlightLog_Original(i) = thisDataSet.FlightLog_Original;
    DataSet.FlightLog_SecondProc(i) = thisDataSet.FlightLog_SecondProc;
    DataSet.tspan{i} = thisDataSet.tspan;
    DataSet.validflag = thisDataSet.validflag;    
    if ~DataSet.validflag
        str = sprintf('%s第%d号数据 (%s) 的时间设置错误: 中止时间(%d) < 起始时间(%d)',GLOBAL_PARAM.Print.lineHead,...
            i,dataFileNames{i},int64(DataSet.tspan{i}(2)),int64(DataSet.tspan{i}(1)));
        fprintf('%s[ERROR] %s\n',GLOBAL_PARAM.Print.lineHead,str);
        fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
        fprintf('%s[END] 退出仿真\n',GLOBAL_PARAM.Print.lineHead);
        fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
        warndlg(str)
        return;
    else
        fprintf('%s仿真时间范围 [%.2f, %.2f]\n',GLOBAL_PARAM.Print.lineHead,DataSet.tspan{i}(1),DataSet.tspan{i}(2));
    end
end