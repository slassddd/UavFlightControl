clear,clc
proj = currentProject;
SetGlobalParam();
tspan0 = [0,inf]; % sec
% dataFileNames = {[proj.RootFolder{1},'20200430\��־����_log_6_V1000 24# V31137�̼�����ȫ���̷���']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_log_2020��6��18�� V1000-27# ���ײ�v1']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-53-05 ����1']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��5������\20200618\��������_2020-06-18 15-56-04 ����2']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-59-02 ����3']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-02-53 ����4']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200820\4+1 ��\��������_log 6 2020-08-20 11-40-02']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200820\4+1 ��\��������_log 5 2020-08-20 11-36-49']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200904\��������_1 2020��09��04��  ����  V1000-55# v31191�̼�  ��̬�������� 2020-09-04 13-39-39']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200907\��������_��2�ܴ�-�ֶ��л�']};
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i),tspan_set{i},validflag,SL,SL_LOAD] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
end
figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;
tspan = tspan_set{1};
%% ���û��ͱ���
PlaneMode.mode = selParamForPlaneMode();
%% ��ʼ�����ģ��
INIT_Navi
INIT_SensorIntegrity
INIT_SensorAlignment
INIT_SensorFault
%% ����ģ��
sim('TESTENV_SignalIntegrity')