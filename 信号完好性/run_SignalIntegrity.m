clear,clc
%% 参数设置
setGlobalParams();
tspan0 = [0,inf]; % sec
%% 载入数据
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\V1000 客户飞行数据\20201205 起飞异常\仿真数据_起飞异常 2020-12-05 09-34-02']};
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\20201223\仿真数据_3 全流程 2020-12-23 12-53-11']};
dataFileNames = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\20201228\仿真数据_104号摔机']};
SimDataSet = loadFlightDataFile(tspan0,dataFileNames,BUS_SENSOR);if ~SimDataSet.validflag,return;end
tspan = SimDataSet.tspan{1};
IN_SENSOR = SimDataSet.IN_SENSOR(1);
figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;
%% 设置测试用例
[TestCase.SensorFaultPanel,isCancel] = selSimCaseSource('sensorfaultpanel');if isCancel,return;end
for i = 1:length(TestCase.SensorFaultPanel.filename)
    TestCase.SensorFaultPanel.data(i) = eval(TestCase.SensorFaultPanel.filename{i});
end
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
%% 初始化相关模块
SimParam.FlightDataSimParam = ...
    SetSimParam_FlightData();
[SimParam.Navi,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = ...
    SetAlgoParam_Navi();
[SimParam.SensorIntegrity,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = ...
    SetAlgoParam_SensorIntegrity();
[SENSOR_ALIGNMENT_PARAM_V1000,SENSOR_ALIGNMENT_PARAM_V10,SENSOR_ALIGNMENT_PARAM_V10_1] = ...
    SetAlgoParam_SensorAlignment();
[SimParam.SensorFault] = ...
    SetAlgoParam_SensorFault();
%% 运行模型
SimParam.Basic.modelname = 'TESTENV_SignalIntegrity';
IN_TestCase_SensorFault = TestCase.SensorFaultPanel.data(1); % 在workspace中保留一份副本，保证可以直接通过点击模型Run进行仿真
for i = 1:length(TestCase.SensorFaultPanel.data)
    SimInput(i) = Simulink.SimulationInput();
    SimInput(i) = SimInput(i).setVariable('IN_TestCase_SensorFault',TestCase.SensorFaultPanel.data(i));
end
fprintf('/n--------调试信息--------/n')
sim(SimParam.Basic.modelname)