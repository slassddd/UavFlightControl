%% 
GLOBAL_PARAM.project = currentProject;
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_飞行数据';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_仿真结果';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% 仿真模式选择 【仿真(已长期不维护)】 or 【数据回放】
GLOBAL_PARAM.SimulinkRunMode = 1; % 飞行参数源选择；1 飞行数据  2 仿真(已经很久没有维护，肯定不好用了)
SimulinkRunMode = 1; % 飞行参数源选择；1 飞行数据  2 仿真(已经很久没有维护，肯定不好用了)
GLOBAL_PARAM.sourceMode = 'simulink_flightdata'; % 'simulink_flightdata'  'simulink_simdata'
% SIMULINK_FLIGHTDATA = Simulink.Variant('SimulinkRunMode==1');
% SIMULINK_SIMDATA = Simulink.Variant('SimulinkRunMode==2'); 
%% 创建作图对象
GLOBAL_PARAM.hPlot = UAVPlotLib;
