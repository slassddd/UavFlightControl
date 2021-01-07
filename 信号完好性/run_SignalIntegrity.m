clear,clc
%% 参数设置
setGlobalParam();
tspan0 = [0,200]; % sec
%% 载入数据
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\V1000 客户飞行数据\20201205 起飞异常\仿真数据_起飞异常 2020-12-05 09-34-02']};
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\20201230\仿真数据_10031异常爬升 2020-12-30 14-11-15']};
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\20201228\仿真数据_104号摔机']};
loadFlightData();
IN_SENSOR = IN_SENSOR_SET(1);
tspan = tspan_SET{1};
figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
%% 初始化相关模块
INIT_Navi
INIT_SensorIntegrity
INIT_SensorAlignment
INIT_SensorFault
%% 运行模型
fprintf('/n--------调试信息--------/n')
sim('TESTENV_SignalIntegrity')