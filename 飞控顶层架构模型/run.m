clear,clc
clear global
%%
Ts_SimBigModel.Ts_base = 0.004;
Ts_BigModel.Ts_base = 0.012;
%% ͨ�ò�������
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%%
if strcmp( GLOBAL_PARAM.ModeSel.simMode,'matlab_flightdata') || strcmp( GLOBAL_PARAM.ModeSel.simMode,'simulink_flightdata') % �������ݷ���
    %% ����������ݲ����ɷ����ʽ����
    tspan = [0,1500]; % sec
    dataFileNames = {['20200418\��������_log_1_V1000-24#V31132�̼��ܼҵ����ɺ�ɻ��������Һ��ƶ�']};    
    dataFileNames = {['SubFolder_��������\20200506\��������_90dae1f08ccd46efba27d5c1121debf6']};    
    dataFileNames = {['SubFolder_��������\20200522\��������_log_2_�����2�ܴ�V1000-27# V31145�̼� ȫ���̷���']};    
    dataFileNames = {['SubFolder_��������\20200720\��������_5bd11c4543e747c29c5f9fe535b14e98']};
    dataFileNames = {['SubFolder_��������\20200731\��������_2020-07-31 18-37-01 ��������ñȽ�Ƶ��']};
    dataFileNames = {['SubFolder_��������\20200818\��������_log ������� ����']};
%     dataFileNames = {['SubFolder_��������\V1000 �ͻ���������\20200811 �����ռ���Ϣ�����������޹�˾���人�� ����\��������_2020-08-09 11-59-55 ������ʾ�쳣']};
    nFlightDataFile = length(dataFileNames);
    for i = 1:nFlightDataFile
        [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i),tspan_set{i}] = step1_loadFlightData(tspan,dataFileNames{i},BUS_SENSOR);
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
                % ����ժȡ
                %                 measureData = MeasureDatas(i_mat);
                %                 simdata = SimDatas(i_mat);
                %                 sensors = Sensors(i_mat);
                %                 filterdata = FilterDatas(i_mat);
                % �˲���������
                N = size(IN_SENSOR.IMU1.time,1);
                %                 [ALGO_SET,sensorFs] = step2_setALGOparam_flightData(PARALLEL_PARAM_SET(i_sim));
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
        % [ALGO_SET,sensorFs] = step2_setALGOparam_flightData();
        %% �����ʳ�ʼ��
        Ts_Control.Ts_base = 0.012;
        Ts_Compass.Ts_base = 0.012;
        INIT_Control
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
        modelname = 'model_V1000Sim';
        % nSim = 1;
        % SIM_FLIGHTDATA_IN(nSim) = Simulink.SimulationInput(modelname);
        % for i = 1:nSim
        %     SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
        % %     SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('ALGO_SET.noise_std.std_mag',i*ALGO_SET.noise_std.std_mag);
        % end
        % out = parsim(SIM_FLIGHTDATA_IN,'RunInBackground','on',...
        %                                'TransferBaseWorkspaceVariables','on');
        tic,out = sim(modelname);toc
        %% ���ݺ���
        [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,Ts_Navi.Ts_Base);
        %%  
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
%% �����ͼ
plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    % ------------  ԭ�㷨���� ---------------
    if 0
        figure(103)
        myplot_navfilter(sensors,plotOpt,1,1,stepSpace); % ��ʾ��ϵ�������
        myplot_navfilter(navFilterMARGRes(1),plotOpt,2,2,stepSpace); % ��ʾ��ϵ�������
    end
    % ------------  mag���� ---------------
    if 0
        figure;
        time_m = IN_SENSOR.mag2.time;
        time_est = navFilterMARGRes(1).Algo.time_algo;
        euler_temp = [navFilterMARGRes(1).Algo.algo_yaw,navFilterMARGRes(1).Algo.algo_pitch,navFilterMARGRes(1).Algo.algo_roll];
        quat_temp = quaternion(euler_temp,'eulerd','ZYX','frame');
        magBody_m = -[sensors.Mag.mag2calib_y_magFrame,sensors.Mag.mag2calib_x_magFrame,sensors.Mag.mag2calib_z_magFrame];
        magNED_true = ones(size(quat_temp,1),1)*[30.15,0,44.98];
        magBody_est = rotateframe(quat_temp,magNED_true);
        plot(time_m,1e2*magBody_m,'r');hold on;
        plot(time_est,magBody_est,'b');hold on;
    end
    % ------------  MARG�˲��� ---------------
    plotOpt.hold = 'on';
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    for i_sim = 1:nSim
        idx_color = rem(i_sim,nColor)+1;
        idx_style = ceil(i_sim/nColor);
        idx_color = rem(idx_color,nColor) + 1;
        idx_style = rem(idx_style,nStyle) + 1;
        
        fid = figure(2);
        fid.Name = 'MARG';
        postplot_marg_flightdata(navFilterMARGRes(i_sim),plotOpt,idx_color,idx_style,stepSpace) %��ʾ��ϵ�������
        
        if isempty(t_alignment(i_sim))
            fprintf('δ�ܳɹ���ɳ���׼\n')
        else
            fprintf('����׼���ʱ��: %.2f \n',t_alignment(i_sim))
        end
        %
        if 1
            fig = figure(222);
            fig.Name = '�˲�ֵ vs ����ֵ';
            myplot_sensor_filter_compare(sensors,navFilterMARGRes(i_sim),plotOpt,idx_color,idx_style,stepSpace);
        end
        if 0
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\','��������_log0_0107_PX4'])
            % ��̬
            figure(33)
            subplot(321)
            PX4yaw = NKF1(1:end-1,5);
            PX4yaw(PX4yaw>180) = PX4yaw(PX4yaw>180)-360;
            plot(NKF1(1:end-1,2)*1e-6,PX4yaw);hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_yaw);hold on;
            subplot(323)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,4));hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_pitch);hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_2,'k--');hold on;
            subplot(325)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,3));hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_roll);hold on;
            % λ��
            subplot(322)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,10));hold on;
            plot(navFilterMARGRes.Algo.time_algo,out.NavFilterRes.state.Data(:,5));hold on;
            subplot(324)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,11));hold on;
            plot(navFilterMARGRes.Algo.time_algo,out.NavFilterRes.state.Data(:,6));hold on;
            subplot(326)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,12));hold on;
            plot(navFilterMARGRes.Algo.time_algo,out.NavFilterRes.state.Data(:,7));hold on;
        end
        if 1
            % �㷨�Աȣ� ���� vs ����
            SinglePlot_Online_Vs_Offline
        end
        % ���Ʒ���
        if 0
            SinglePlot_Pcov
        end        
    end
end