%% 
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_��������';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_������';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% ����ģʽѡ��
SIMULINK_FLIGHTDATA = Simulink.Variant('SimulinkRunMode==1');
SIMULINK_SIMDATA = Simulink.Variant('SimulinkRunMode==2'); 
%% ������ͼ����
GLOBAL_PARAM.hPlot = UAVPlotLib;
%% ����ģ���������
basePeriod = 0.004;
ArchitectureManage.Period.SignalIntegrity = basePeriod;
ArchitectureManage.Period.NaviFilter = basePeriod;
ArchitectureManage.Period.TaskPlanner = 10*basePeriod;
ArchitectureManage.Period.Controller = 10*basePeriod;