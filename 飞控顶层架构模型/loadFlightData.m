% function [IN_SENSOR_SET,IN_SENSOR_SIM_SET,tspan_SET,timeSpanValidflag,SL,SL_LOAD] = loadFlightData(tspan0,dataFileNames,BUS_SENSOR)
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR_SET(i),IN_SENSOR_SIM_SET(i),tspan_SET{i},timeSpanValidflag,SL(i),SL_LOAD(i)] = sub_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    if ~timeSpanValidflag
        str = sprintf('时间设置错误: 中止时间(%d) < 起始时间(%d)',int64(tspan_SET{i}(2)),int64(tspan_SET{i}(1)));
        warndlg(str)
        return;
    else
        fprintf('仿真数据的IMU时间范围 [%.2f, %.2f]\n',tspan_SET{i}(1),tspan_SET{i}(2))
    end
end