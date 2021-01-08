%% 
global GLOBAL_PARAM
GLOBAL_PARAM.project = currentProject;
GLOBAL_PARAM.Print.lineHead = '|    ';
GLOBAL_PARAM.Print.flagHalfBegin = '--------------------------';
GLOBAL_PARAM.Print.flagBegin = '-------------------------------------------------------------------';
GLOBAL_PARAM.SubFolderName.ICD = 'SubFolder_ICD';
GLOBAL_PARAM.SubFolderName.FlightData = 'SubFolder_��������';
GLOBAL_PARAM.SubFolderName.SimRes = 'SubFolder_������';
load([GLOBAL_PARAM.SubFolderName.ICD,'\','IOBusInfo_V1000'])
%% ����ģʽѡ�� ������(�ѳ��ڲ�ά��)�� or �����ݻطš�
GLOBAL_PARAM.SimulinkRunMode = 1; % ���в���Դѡ��1 ��������  2 ����(�Ѿ��ܾ�û��ά�����϶���������)
GLOBAL_PARAM.sourceMode = 'simulink_flightdata'; % 'simulink_flightdata'  'simulink_simdata'
%% ������ͼ����
GLOBAL_PARAM.hPlot = UAVPlotLib;
%%
fprintf('%s ��ʼ��ģ�ͷ��� %s\n',GLOBAL_PARAM.Print.flagHalfBegin,GLOBAL_PARAM.Print.flagHalfBegin);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
fprintf('%sICD�ļ�:%s\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.SubFolderName.ICD);