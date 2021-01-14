%% 通用参数设置
fprintf('-------------------------- 开始导航仿真 --------------------------\n');
setGlobalParams
tspan0 = [0,inf]; % sec   [0,inf]
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
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
%% 初始化模型参数
% 设置flight data模型参数
SimParam.FlightDataSimParam = INIT_FlightData();
% 设置滤波参数
[SimParam.Navi,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = INIT_Navi();
% 传感器故障参数
[SimParam.SensorFault,SENSOR_FAULT] = INIT_SensorFault();
% 传感器安装参数
[SENSOR_ALIGNMENT_PARAM_V1000,SENSOR_ALIGNMENT_PARAM_V10,SENSOR_ALIGNMENT_PARAM_V10_1] = INIT_SensorAlignment();
% 信号检测
[SimParam.SensorIntegrity,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = ...
    INIT_SensorIntegrity();
% 视觉着陆
[SimParam.VLand,VISLANDING_PARAM_V1000,VISLANDING_PARAM_V10] = INIT_VisualLanding();
%% 运行仿真
runSimulation_Navi
%% 数据后处理
for i = 1:SimDataSet.nFlightDataFile
    [SimRes.Navi.MARG(i),SimRes.Navi.timeInit(i)] = getSimRes_Navi(out(i),SimParam.Navi.Ts_Base);
end
%% 仿真绘图
Plot_NaviSimData(SimRes,SimDataSet,SimParam.TestCase.filename)
% Plot_NaviLogTable();
%% 结束
printSimEnd(SimParam.Basic.timeSpend);