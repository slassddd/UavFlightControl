clear,clc
proj = currentProject;
SetGlobalParam();
tspan0 = [0,inf]; % sec
% dataFileNames = {[proj.RootFolder{1},'20200430\��־����_log_6_V1000 24# V31137�̼�����ȫ���̷���']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_log_2020��6��18�� V1000-27# ���ײ�v1']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-53-05 ����1']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-56-04 ����2']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-59-02 ����3']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-02-53 ����4']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\V1000 �ͻ���������\2020.8.18�����쳤���ռ�8��17V1000-87#����쳣��\��������_eefff4cc05c54fce9564f1133e8d7c63']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\ר�� �����ƿ�����\V1000 64#�����ֳ� ģ������\��������_log_64#��������']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\ר�� �����ƿ�����\V1000 64#�����ֳ� ģ������\��������_log_6']};
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
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

%% ����ģ��
sim('TESTENV_SignalIntegrity')