clear,clc
SetGlobalParam();
tspan0 = [3,inf]; % sec
%     dataFileNames = {[ GLOBAL_PARAM.SubFolderName.FlightData,'\','��������_log_59']};
%     dataFileNames = {['��������_log_home50']};
dataFileNames = {['20200416\��������_log_3_�ɻ�ȥ��1������зɻ��Զ���������;������']};
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