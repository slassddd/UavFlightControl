clear,clc
SetGlobalParam
%% ��ʼ������ģ��
INIT_SIMPLEUAVMOTION
INIT_TASK 
%% ����վָ��Ȳ����ĳ�ʼ��
INIT_GROUNDSTATION
%% �������ܲ���
INIT_FlightPerformance
%% MPC���߸�����44
% INIT_MPCPath
%% ����model
tic
out = sim('TESTENV_Task');
toc
%% ���ݻ�ͼ
plot_simdata
plot_taskLogTable
