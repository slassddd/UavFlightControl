clear,clc
proj = currentProject;
SetGlobalParam();
tspan0 = [0,inf]; % sec
dataFileNames = {[proj.RootFolder{1},'20200430\日志数据_log_6_V1000 24# V31137固件调参全流程飞行']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_log_2020年6月18日 V1000-27# 毫米波v1']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 15-53-05 起落1']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 15-56-04 起落2']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 15-59-02 起落3']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-02-53 起落4']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-06-52 起落5']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-12-56 起落6']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-16-54 起落7']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-20-08 起落8']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-23-43 起落9']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-27-13 起落10']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 16-59-14 起落11']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-02-37 起落12']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-05-38 起落13']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-08-58 起落14']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-12-18 起落15']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-16-15 起落16']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-19-21 起落17']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-22-25 起落18']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-26-01 起落19']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 17-29-26 起落20']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-00-05 起落21']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-03-46 起落22']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-09-45 起落23']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-13-28 起落24']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-16-37 起落25']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-19-43 起落26']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-22-59 起落27']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-26-05 起落28']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-29-38 起落29']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200618\仿真数据_2020-06-18 18-32-57 起落30']};
%% 55号
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-15-03 27#起落1 弹起']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-22-07 27#起落2']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-25-46 27#起落3']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-29-25 27#起落4']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-32-03 27#起落5']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-34-51 27#起落6']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-37-44 27#起落7']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-40-41 27#起落8']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-43-04 27#起落9']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-45-27 27#起落10']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-48-12 27#起落11']};  % 复现
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-51-01 27#起落12']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-53-23 27#起落13']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-56-04 27#起落14']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 11-59-01 27#起落15']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 12-01-24 27#起落16']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 12-03-54 27#起落17']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 12-06-34 27#起落18']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 12-10-53 27#起落19 横移1m']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200620\仿真数据_2020-06-20 12-14-01 27#起落20']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 1 2020-06-23 11-12-06']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 2 2020-06-23 11-15-07']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 3 2020-06-23 11-19-33']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 4 2020-06-23 11-22-37']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 5 2020-06-23 11-26-26']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 6 2020-06-23 11-30-03']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 7 2020-06-23 11-34-09']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 8 2020-06-23 11-38-07']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 9 2020-06-23 11-42-16']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 10 2020-06-23 11-47-35']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 11 2020-06-23 11-51-32']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 12 2020-06-23 11-56-21']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 13 2020-06-23 12-11-06']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 14 2020-06-23 12-16-01']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 15 2020-06-23 12-20-40']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 16 2020-06-23 12-25-02']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 17 2020-06-23 12-29-23']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 18 2020-06-23 12-33-23']};
% dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200623\仿真数据_31#起落 19 2020-06-23 12-37-21']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20200708\仿真数据_log_4_天津宝坻 V10011固件 测试']};

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

%% 运行模型
sim('TESTENV_SignalIntegrity')