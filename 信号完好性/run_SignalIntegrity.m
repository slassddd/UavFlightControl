clear,clc
SetGlobalParam();
tspan0 = [660,inf]; % sec
%     dataFileNames = {[ GLOBAL_PARAM.SubFolderName.FlightData,'\','仿真数据_log_59']};
%     dataFileNames = {['仿真数据_log_home50']};
% dataFileNames = {['20200416\仿真数据_log_3_飞机去往1点过程中飞机自动返航并再途中螺旋']};
dataFileNames = {['20200430\日志数据_log_6_V1000 24# V31137固件调参全流程飞行']};
dataFileNames = {['SubFolder_飞行数据\20200613\仿真数据_2020-06-12 17-57-43 全流程 落地弹跳']};
% dataFileNames = {['SubFolder_飞行数据\20200512\日志数据_log_2_到达不了home点']};
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

figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;