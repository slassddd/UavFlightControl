%% 
GLOBAL_PARAM.project = currentProject;
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_飞行数据';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_仿真结果';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% 仿真模式选择 【仿真(已长期不维护)】 or 【数据回放】
SIMULINK_FLIGHTDATA = Simulink.Variant('SimulinkRunMode==1');
SIMULINK_SIMDATA = Simulink.Variant('SimulinkRunMode==2'); 
%% 创建作图对象
GLOBAL_PARAM.hPlot = UAVPlotLib;