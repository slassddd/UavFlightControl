clear,clc
SetGlobalParam
%% ��ʼ������ģ��
INIT_SIMPLEUAVMOTION
INIT_TASK
%% ����վָ��Ȳ����ĳ�ʼ��
INIT_GROUNDSTATION
%% �������ܲ���
INIT_FlightPerformance
%% ����model
out = sim('TESTENV_Task');
%% ���ݻ�ͼ
plot_simdata
