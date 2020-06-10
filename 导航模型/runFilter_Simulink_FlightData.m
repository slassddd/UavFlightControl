SimulinkRunMode = 1;
% [ALGO_SET,sensorFs] = step2_setALGOparam_flightData();
%% 控制率初始化
Ts_Control.Ts_base = 0.012;
INIT_Control
%% 框架模型
Ts_Architechure.Ts_base = 0.012;
%% 控制模块初始化
% INIT_CONTROL
%% 组合导航初始化
INIT_Navi
%% 
INIT_UAV
%% 任务初始化
INIT_TASK
% 简化的运动模型
INIT_SIMPLEUAVMOTION
%% 地面站指令
INIT_GROUNDSTATION
%% 传感器故障参数
INIT_SensorFault
%% 传感器安装参数
INIT_SensorAlignment
%% 信号检测
INIT_SensorIntegrity
%% 运行仿真
modelname = 'model_navfilter';
% nSim = 1;
% SIM_FLIGHTDATA_IN(nSim) = Simulink.SimulationInput(modelname);
% for i = 1:nSim    
%     SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
% %     SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('ALGO_SET.noise_std.std_mag',i*ALGO_SET.noise_std.std_mag);    
% end
% out = parsim(SIM_FLIGHTDATA_IN,'RunInBackground','on',...
%                                'TransferBaseWorkspaceVariables','on');                        
out = sim(modelname);
%% 数据后处理
[navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,sensorFs);