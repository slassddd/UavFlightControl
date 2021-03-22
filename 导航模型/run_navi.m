%% 通用参数设置
fprintf('-------------------------- 开始导航仿真 --------------------------\n');
setGlobalParams
SimParam.Basic.selDefaultPlaneMode = [] ; % [] ENUM_plane_mode.V1000 
SimParam.Basic.selTestCase_SensorFault_Manual = true; % 默认选择 SensorFault 测试用例为Manual: true false
tspan0 = [1800,2000]; % sec   [0,inf]
%% 选择机型
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode(SimParam.Basic.selDefaultPlaneMode);if isCancel,return;end % 选择机型
%% 选择并载入数据文件
if 0
    % 执行指定数据文件
    SimParam.TestCase.filename{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_9 大风 人为观察飞机姿态晃动严重，人为点击返航 2020-12-24 12-39-34.mat'];
    SimParam.TestCase.filename{2} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_3 着陆不加锁 2020-12-24 11-24-02.mat'];
else
    selDataFile;
end
% 载入飞行数据
SimDataSet = loadFlightDataFile(tspan0,SimParam.TestCase.filename,BUS_SENSOR);if ~SimDataSet.validflag,return;end
%% 设置测试用例
% SensorFault
[TestCase.SensorFaultPanel,isCancel] = selSimCaseSource('SensorFaultPanel',SimParam.Basic.selTestCase_SensorFault_Manual);if isCancel,return;end
for i = 1:length(TestCase.SensorFaultPanel.filename)
    TestCase.SensorFaultPanel.data(i) = eval(TestCase.SensorFaultPanel.filename{i});
end
checkTestCase_SensorFault(TestCase.SensorFaultPanel.data);
%% 初始化模型参数
% 设置flight data模型参数
SimParam.FlightDataSimParam = SetSimParam_FlightData();
% 设置滤波参数
[SimParam.Navi,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = SetAlgoParam_Navi();
% 传感器故障参数
[SimParam.SensorFault] = SetAlgoParam_SensorFault();
% 传感器安装参数
[SENSOR_ALIGNMENT_PARAM_V1000,SENSOR_ALIGNMENT_PARAM_V10,SENSOR_ALIGNMENT_PARAM_V10_1] = SetAlgoParam_SensorAlignment();
% 信号检测
[SimParam.SensorIntegrity,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = ...
    SetAlgoParam_SensorIntegrity();
% 视觉着陆
[SimParam.VLand,VISLANDING_PARAM_V1000,VISLANDING_PARAM_V10] = SetAlgoParam_VisualLanding();
%% 运行仿真
doSimulation_Navi
%% 数据后处理
for i = 1:SimDataSet.nFlightDataFile
    [SimRes.Navi.MARG(i),SimRes.Navi.timeInit(i)] = getSimRes_Navi(out(i),SimParam.Navi.Ts_Base);
end
%% 仿真绘图
Plot_NaviSimData(SimRes,SimDataSet,SimParam.TestCase.filename)
% Plot_NaviLogTable();
%% 结束
printSimEnd(SimParam.Basic.timeSpend);