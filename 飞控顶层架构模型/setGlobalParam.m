%% 
GLOBAL_PARAM.project = currentProject;
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_��������';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_������';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% ����ģʽѡ�� ������(�ѳ��ڲ�ά��)�� or �����ݻطš�
SIMULINK_FLIGHTDATA = Simulink.Variant('SimulinkRunMode==1');
SIMULINK_SIMDATA = Simulink.Variant('SimulinkRunMode==2'); 
%% ������ͼ����
GLOBAL_PARAM.hPlot = UAVPlotLib;