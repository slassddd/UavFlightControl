clear,clc
%% 参数设置
setGlobalParams();
SimParam.Basic.selDefaultPlaneMode = [] ; % [] ENUM_plane_mode.V1000 
SimParam.Basic.selTestCase_SensorFault_Manual = true; % 默认选择 SensorFault 测试用例为Manual: true false
tspan0 = [1620,inf]; % sec
%% 载入数据
TestCase.FlightLog.filename = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\V10 数据\0客户数据\20210508 南通赛维\仿真数据_重着陆 2021-05-08 09-05-19']};
% TestCase.FlightLog.filename = {[GLOBAL_PARAM.project.RootFolder{1},'\SubFolder_飞行数据\V10 新平台数据\20210506\仿真数据_v10-17手动.bin-2375919.mat']};
SimDataSet = loadFlightDataFile(tspan0,TestCase.FlightLog.filename,BUS_SENSOR);if ~SimDataSet.validflag,return;end
tspan = SimDataSet.tspan{1};
IN_SENSOR = SimDataSet.IN_SENSOR(1);
figure;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Flag);hold on;
%% 设置测试用例
[TestCase.SensorFaultPanel,isCancel] = selSimCaseSource('SensorFaultPanel',SimParam.Basic.selTestCase_SensorFault_Manual);if isCancel,return;end
for i = 1:length(TestCase.SensorFaultPanel.filename)
    TestCase.SensorFaultPanel.data(i) = eval(TestCase.SensorFaultPanel.filename{i});
end
checkTestCase_SensorFault(TestCase.SensorFaultPanel.data);
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode(SimParam.Basic.selDefaultPlaneMode);if isCancel,return;end % 选择机型
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
    SimInput(i) = Simulink.SimulationInput(SimParam.Basic.modelname);
    SimInput(i) = SimInput(i).setVariable('IN_TestCase_SensorFault',TestCase.SensorFaultPanel.data(i));
end
fprintf('/n--------调试信息--------/n')
out = sim(SimInput);
%%
Plot_IntegritySimData(out,SimDataSet,TestCase.SensorFaultPanel.data);