clear,clc
proj = currentProject;
SetGlobalParam();
tspan0 = [0,inf]; % sec
dataFileNames = {[proj.RootFolder{1},'20200430\��־����_log_6_V1000 24# V31137�̼�����ȫ���̷���']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_log_2020��6��18�� V1000-27# ���ײ�v1']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-53-05 ����1']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-56-04 ����2']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 15-59-02 ����3']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-02-53 ����4']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-06-52 ����5']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-12-56 ����6']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-16-54 ����7']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-20-08 ����8']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-23-43 ����9']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-27-13 ����10']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 16-59-14 ����11']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-02-37 ����12']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-05-38 ����13']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-08-58 ����14']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-12-18 ����15']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-16-15 ����16']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-19-21 ����17']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-22-25 ����18']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-26-01 ����19']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 17-29-26 ����20']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-00-05 ����21']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-03-46 ����22']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-09-45 ����23']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-13-28 ����24']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-16-37 ����25']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-19-43 ����26']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-22-59 ����27']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-26-05 ����28']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-29-38 ����29']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200618\��������_2020-06-18 18-32-57 ����30']};
%% 55��
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-15-03 27#����1 ����']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-22-07 27#����2']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-25-46 27#����3']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-29-25 27#����4']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-32-03 27#����5']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-34-51 27#����6']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-37-44 27#����7']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-40-41 27#����8']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-43-04 27#����9']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-45-27 27#����10']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-48-12 27#����11']};  % ����
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-51-01 27#����12']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-53-23 27#����13']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-56-04 27#����14']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 11-59-01 27#����15']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 12-01-24 27#����16']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 12-03-54 27#����17']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 12-06-34 27#����18']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 12-10-53 27#����19 ����1m']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_��������\20200620\��������_2020-06-20 12-14-01 27#����20']};
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