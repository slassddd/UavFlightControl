%% 
GLOBAL_PARAM.project = currentProject;
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_��������';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_������';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% ����ģʽѡ�� ������(�ѳ��ڲ�ά��)�� or �����ݻطš�
GLOBAL_PARAM.SimulinkRunMode = 1; % ���в���Դѡ��1 ��������  2 ����(�Ѿ��ܾ�û��ά�����϶���������)
SimulinkRunMode = 1; % ���в���Դѡ��1 ��������  2 ����(�Ѿ��ܾ�û��ά�����϶���������)
GLOBAL_PARAM.sourceMode = 'simulink_flightdata'; % 'simulink_flightdata'  'simulink_simdata'
% SIMULINK_FLIGHTDATA = Simulink.Variant('SimulinkRunMode==1');
% SIMULINK_SIMDATA = Simulink.Variant('SimulinkRunMode==2'); 
%% ������ͼ����
GLOBAL_PARAM.hPlot = UAVPlotLib;
