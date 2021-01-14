%% 
global GLOBAL_PARAM
GLOBAL_PARAM.project = currentProject;
GLOBAL_PARAM.plotOpt = setPlotOpt;
GLOBAL_PARAM.plotOpt.hold = 'on';
GLOBAL_PARAM.Print.lineHead = '|    ';
GLOBAL_PARAM.Print.flagHalfBegin = '--------------------------';
GLOBAL_PARAM.Print.flagBegin = '-------------------------------------------------------------------';
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_飞行数据';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_仿真结果';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% 仿真模式选择 【仿真(已长期不维护)】 or 【数据回放】
GLOBAL_PARAM.SimulinkRunMode = 1; % 飞行参数源选择；1 飞行数据  2 仿真(已经很久没有维护，肯定不好用了)
GLOBAL_PARAM.sourceMode = 'simulink_flightdata'; % 'simulink_flightdata'  'simulink_simdata'
%% 创建作图对象
GLOBAL_PARAM.hPlot = UAVPlotLib;
%%
% fprintf('%s 开始大模型仿真 %s\n',GLOBAL_PARAM.Print.flagHalfBegin,GLOBAL_PARAM.Print.flagHalfBegin);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
fprintf('%sICD文件:%s\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.SubFolderName.ICD);