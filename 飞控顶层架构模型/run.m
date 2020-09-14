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
%%
Ts_SimBigModel.Ts_base = 0.004;
Ts_BigModel.Ts_base = 0.012;
%% ͨ�ò�������
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%%
if strcmp( GLOBAL_PARAM.ModeSel.simMode,'matlab_flightdata') || strcmp( GLOBAL_PARAM.ModeSel.simMode,'simulink_flightdata') % �������ݷ���
    %% ����������ݲ����ɷ����ʽ����
    tspan = [0,100]; % sec
    dataFileNames = {['20200418\��������_log_1_V1000-24#V31132�̼��ܼҵ����ɺ�ɻ��������Һ��ƶ�']};
    dataFileNames = {['SubFolder_��������\20200820\��������_����ʱ 2 2020-08-20 12-32-56']};
    dataFileNames = {['SubFolder_��������\20200827\��������_1 ��2�ܴ� ����ʱ 2020-08-27 13-28-41']};
    dataFileNames = {['SubFolder_��������\20200910\��������_1 2020��9��10�� ���� V1000-55# V31196�̼� ����']};
    dataFileNames = {['SubFolder_��������\20200910\��������_2020��9��11�� ���� V1000-55# V31199�̼� �������ȵ͸߶���ͣ  ���ֲ�����ʱȫ���� 2020-09-11 18-04-08']};
    nFlightDataFile = length(dataFileNames);
    for i = 1:nFlightDataFile
        [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i),tspan_set{i},~,SL(i),SL_LOAD(i)] = step1_loadFlightData(tspan,dataFileNames{i},BUS_SENSOR);
    end
    tspan = tspan_set{1};
    % ����������
    if 1
        fig = figure(102);
        GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR(1),2,2,fig)
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
        figure(104)
        subplot(2,2,1)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.numSv);
        ylabel('����')
        xlabel('sec')
        subplot(2,2,2)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.pDop);
        ylabel('pDOP')
        xlabel('sec')
        subplot(2,2,3)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.sAcc);
        ylabel('sAcc')
        xlabel('sec')
        subplot(2,2,4)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.hAcc);
        ylabel('hAcc')
        xlabel('sec')
    end
end
%% ���û��ͱ���
PlaneMode.mode = selParamForPlaneMode();
%% ��ʼ����
nSim = 1;
nStateMARG = 22; % �˲���״̬ά��
%% ִ�з���
switch GLOBAL_PARAM.ModeSel.simMode
    case 'simulink_flightdata'
        tic
        %%
        SimulinkRunMode = 1;
        %% �����ʳ�ʼ��
        Ts_Control.Ts_base = 0.012;
        Ts_Compass.Ts_base = 0.012;
        try
            INIT_Control;
        catch ME
            fprintf('INIT_Control:\n')
            fprintf(ME.message);
            fprintf('\n')
            return;
        end
        %% ���ģ��
        Ts_Architechure.Ts_base = 0.012;
        %% ����ģ���ʼ��
        % INIT_CONTROL
        %% ��ϵ�����ʼ��
        INIT_Navi
        %%
        INIT_UAV
        %% �����ʼ��
        INIT_TASK
        % �򻯵��˶�ģ��
        INIT_SIMPLEUAVMOTION
        %% ����վָ��
        INIT_GROUNDSTATION
        %% ���������ϲ���
        INIT_SensorFault
        %% ��������װ����
        INIT_SensorAlignment
        %% �źż��
        INIT_SensorIntegrity
        %% ��������
        INIT_FlightPerformance
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