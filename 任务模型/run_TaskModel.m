clear,clc
SetGlobalParam
%% ���û��ͱ���
PlaneMode.mode = selParamForPlaneMode();
%% ��ʼ������ģ��
INIT_SIMPLEUAVMOTION
INIT_TASK 
%% ����վָ��Ȳ����ĳ�ʼ��
INIT_GROUNDSTATION
%% �������ܲ���
INIT_FlightPerformance
% INIT_MPCPath
%% ����model
tic
out = sim('TESTENV_Task');
toc
%% ���ݻ�ͼ
plot_simdata
plot_taskLogTable