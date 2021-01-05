clear,clc
proj = currentProject;
SetGlobalParam();
tspan0 = [0,200]; % sec
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\V1000 �ͻ���������\20201205 ����쳣\��������_����쳣 2020-12-05 09-34-02']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20201230\��������_10031�쳣���� 2020-12-30 14-11-15']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20201228\��������_104��ˤ��']};
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR(i),IN_SENSOR_SIM(i),tspan_set{i},validflag,SL,SL_LOAD] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
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
fprintf('/n--------������Ϣ--------/n')
sim('TESTENV_SignalIntegrity')