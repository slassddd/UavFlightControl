clear,clc
%% 参数设置
setGlobalParam();
tspan0 = [0,200]; % sec
%% 载入数据
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\V1000 客户飞行数据\20201205 起飞异常\仿真数据_起飞异常 2020-12-05 09-34-02']};
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\20201230\仿真数据_10031异常爬升 2020-12-30 14-11-15']};
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\20201228\仿真数据_104号摔机']};
SimDataSet = loadFlightData(tspan0,dataFileNames,BUS_SENSOR);if ~SimDataSet.validflag,return;end
tspan = SimDataSet.tspan{1};
IN_SENSOR = SimDataSet.IN_SENSOR(1);
figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
%% 初始化相关模块
SimParam.FlightDataSimParam = ...
    INIT_FlightData();
[SimParam.Navi,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = ...
    INIT_Navi( SimParam.SystemInfo.planeMode );
[SimParam.SensorIntegrity,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = ...
    INIT_SensorIntegrity();
[SENSOR_ALIGNMENT_PARAM_V1000,SENSOR_ALIGNMENT_PARAM_V10,SENSOR_ALIGNMENT_PARAM_V10_1] = ...
    INIT_SensorAlignment();
[SimParam.SensorFault,SENSOR_FAULT] = ...
    INIT_SensorFault();
%% 运行模型
fprintf('/n--------调试信息--------/n')
sim('TESTENV_SignalIntegrity')