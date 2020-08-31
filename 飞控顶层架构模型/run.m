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
    tspan = [0,inf]; % sec
    dataFileNames = {['20200418\��������_log_1_V1000-24#V31132�̼��ܼҵ����ɺ�ɻ��������Һ��ƶ�']};
    dataFileNames = {['SubFolder_��������\20200506\��������_90dae1f08ccd46efba27d5c1121debf6']};
    dataFileNames = {['SubFolder_��������\20200522\��������_log_2_�����2�ܴ�V1000-27# V31145�̼� ȫ���̷���']};
    dataFileNames = {['SubFolder_��������\20200720\��������_5bd11c4543e747c29c5f9fe535b14e98']};
    dataFileNames = {['SubFolder_��������\20200731\��������_2020-07-31 18-37-01 ��������ñȽ�Ƶ��']};
    dataFileNames = {['SubFolder_��������\20200820\��������_����ʱ 2 2020-08-20 12-32-56']};
    dataFileNames = {['SubFolder_��������\20200827\��������_1 ��2�ܴ� ����ʱ 2020-08-27 13-28-41']};
    
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
%% ��ʼ����
nSim = 1;
PARALLEL_PARAM_SET(1).std_gyro = pi/180*0.1*[1,1,1];  % rad/s ��׼���ƽ����
PARALLEL_PARAM_SET(2).std_gyro = pi/180*0.05*[1,1,1];
PARALLEL_PARAM_SET(3).std_gyro = pi/180*0.01*[1,1,1];
PARALLEL_PARAM_SET(1).ALGO_SET.SensorSelect.Mag = 2;
PARALLEL_PARAM_SET(2).ALGO_SET.SensorSelect.Mag = 2;
nStateMARG = 22; % �˲���״̬ά��
%% ִ�з���
switch GLOBAL_PARAM.ModeSel.simMode
    case 'matlab_flightdata'
        for i_mat = 1:nFlightDataFile
            for i_sim = 1:nSim
                tic
                % �˲���������
                N = size(IN_SENSOR.IMU1.time,1);
                %% ��ϵ�����ʼ��
                INIT_Navi
                % �����˲�ʵ��
                idx = (i_mat-1)*nFlightDataFile + i_sim;
                runFilter_Matlab
                timeSpend = toc;
                fprintf('ģ��<%d>�������, ��ʱ %.2f [s]\n',idx,timeSpend);
            end
        end
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
        
        % nSim = 1;
        % SIM_FLIGHTDATA_IN(nSim) = Simulink.SimulationInput(modelname);
        % for i = 1:nSim
        %     SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
        % %     SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('ALGO_SET.noise_std.std_mag',i*ALGO_SET.noise_std.std_mag);
        % end
        % out = parsim(SIM_FLIGHTDATA_IN,'RunInBackground','on',...
        %                                'TransferBaseWorkspaceVariables','on');
        %%
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
                tic,ArchiRes_replay = sim(modelname);toc
                %% �����ͼ
                AchiPlot_replay
        end
        timeSpend = toc;
        fprintf('�������, ��ʱ %.2f [s]\n',timeSpend);
    case 'simulink_simdata'
        tic
        runFilter_Simulink_SimData
        timeSpend = toc;
        fprintf('ģ��<%d>�������, ��ʱ %.2f [s]\n',i_sim,timeSpend);
        return
    otherwise
        error('����ķ���ģʽ')
end