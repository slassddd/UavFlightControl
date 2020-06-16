clear,clc
SetGlobalParam();
tspan0 = [660,inf]; % sec
%     dataFileNames = {[ GLOBAL_PARAM.SubFolderName.FlightData,'\','��������_log_59']};
%     dataFileNames = {['��������_log_home50']};
% dataFileNames = {['20200416\��������_log_3_�ɻ�ȥ��1������зɻ��Զ���������;������']};
dataFileNames = {['20200430\��־����_log_6_V1000 24# V31137�̼�����ȫ���̷���']};
dataFileNames = {['SubFolder_��������\20200613\��������_2020-06-12 17-57-43 ȫ���� ��ص���']};
% dataFileNames = {['SubFolder_��������\20200512\��־����_log_2_���ﲻ��home��']};
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