clear,clc
SetGlobalParam();
tspan0 = [3,inf]; % sec
%     dataFileNames = {[ GLOBAL_PARAM.SubFolderName.FlightData,'\','仿真数据_log_59']};
%     dataFileNames = {['仿真数据_log_home50']};
dataFileNames = {['20200416\仿真数据_log_3_飞机去往1点过程中飞机自动返航并再途中螺旋']};
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
%     [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i)] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i),tspan_set{i}] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
end
tspan = tspan_set{1};
INIT_Navi
INIT_SensorIntegrity
INIT_SensorAlignment
INIT_SensorFault