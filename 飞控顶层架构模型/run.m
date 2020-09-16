%%
clear,clc
clear global
%% ѡ�����ģʽ
mode_architechure = questdlg('ѡ�����ģʽ', ...
    'ѡ�����ģʽ', ...
    '�������ݻط�','����','ȡ��','�������ݻط�');
if strcmp(mode_architechure,'ȡ��')
    return;
end
%% ͨ�ò�������
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%% �����������
tspan = [0,10]; % sec
dataFileNames = {['SubFolder_��������\20200820\��������_����ʱ 2 2020-08-20 12-32-56']};
dataFileNames = {['SubFolder_��������\20200827\��������_1 ��2�ܴ� ����ʱ 2020-08-27 13-28-41']};
dataFileNames = {['SubFolder_��������\20200910\��������_1 2020��9��10�� ���� V1000-55# V31196�̼� ����']};
dataFileNames = {['SubFolder_��������\20200910\��������_2020��9��11�� ���� V1000-55# V31199�̼� �������ȵ͸߶���ͣ  ���ֲ�����ʱȫ���� 2020-09-11 18-04-08']};
LoadFlightData();
%% �̼����Ի�������
PlaneMode.mode = selParamForPlaneMode(); % ���û��ͱ���
SimulinkRunMode = 1; % ���в���Դѡ�񣻷���or��������
Ts_Compass.Ts_base = 0.012;
%% �̼�������ʼ��
INIT_SystemArchitecture
%% ִ�з���
nSim = 1;
switch GLOBAL_PARAM.ModeSel.simMode
    case 'simulink_flightdata'
        tic
        %% ���з���
        switch mode_architechure
            case '����' % ����
                modelname = 'firmwareV1000_sim';
                tic,out = sim(modelname);toc
                %% ���ݺ���
                [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,Ts_Navi.Ts_Base);
                %% �����ͼ
                AchiPlot_sim
            case '�������ݻط�' % ��������
                modelname = 'firmwareV1000_flight_replay';
                INIT_Mavlink_FlightData
                Battery_mavlink_msg_mission_current.time = SL.PowerConsume.time_cal;
                Battery_mavlink_msg_mission_current.signals.values = SL.PowerConsume.AllTheTimePowerConsume;
                %% ִ�з���
                tic
                ArchiRes_replay = sim(modelname);
                toc
                %% ���ݺ���
                [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(ArchiRes_replay,Ts_Navi.Ts_Base);
                %% �����ͼ
                AchiPlot_replay
        end
        timeSpend = toc;
        fprintf('�������, ��ʱ %.2f [s]\n',timeSpend);
    case 'simulink_simdata'
        % ������
    case 'matlab_flightdata'
        % ������
    otherwise
        error('����ķ���ģʽ')
end