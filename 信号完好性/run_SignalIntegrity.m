clear,clc
proj = currentProject;
SetGlobalParam();
tspan0 = [0,200]; % sec
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\V1000 客户飞行数据\20201205 起飞异常\仿真数据_起飞异常 2020-12-05 09-34-02']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20201230\仿真数据_10031异常爬升 2020-12-30 14-11-15']};
dataFileNames = {[proj.RootFolder{1},'\SubFolder_飞行数据\20201228\仿真数据_104号摔机']};
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR(i),IN_SENSOR_SIM(i),tspan_set{i},validflag,SL,SL_LOAD] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
end
figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;
tspan = tspan_set{1};
%% 设置机型变量
PlaneMode.mode = selParamForPlaneMode();
%% 初始化相关模块
INIT_Navi
INIT_SensorIntegrity
INIT_SensorAlignment
INIT_SensorFault
%% 运行模型
fprintf('/n--------调试信息--------/n')
sim('TESTENV_SignalIntegrity')