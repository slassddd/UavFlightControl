if 0
    clear,clc
    clear global
    dataFileNames = {['20200417\��������_log_4_V1000-24# V31131�̼� ȫ���̺��߷��е���']}; 
    dataFileNames = {['SubFolder_��������\20200522\��������_log_2_�����2�ܴ�V1000-27# V31145�̼� ȫ���̷���']};    
    dataFileNames = {['SubFolder_��������\20200601\��������_2020-06-01 16-47-50 �����쳣']};    
    dataFileNames = {['SubFolder_��������\20200910\��������_2020��9��11�� ���� V1000-55# V31199�̼� �������ȵ͸߶���ͣ  ���ֲ�����ʱȫ���� 2020-09-11 18-04-08']};
    %% AUTOCODE %%
else
    try
        dataFileNames = saveFileName;
        save lastFlightDataFileLoadedForNavi.mat dataFileNames
    catch
        load('lastFlightDataFileLoadedForNavi');
        fprintf('��ǰ�����ռ�û�� dataFileNames, ��ȡ���һ������������ļ�: %s\n',dataFileNames{1});
    end
end
%% ͨ�ò�������
SetGlobalParam();
%% 
Ts_Compass.Ts_base = 0.012;
%%
%% ����������ݲ����ɷ����ʽ����
tspan0 = [0,500]; % sec   [0,inf]
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR_SET(i),IN_SENSOR_SIM_SET(i),sensors_SET(i),tspan_SET{i},timeSpanValidflag] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    if ~timeSpanValidflag
        str = sprintf('ʱ�����ô���: ��ֹʱ��(%d) < ��ʼʱ��(%d)',int64(tspan_SET{i}(2)),int64(tspan_SET{i}(1)));
        warndlg(str)
        return;
    else
        fprintf('�������ݵ�IMUʱ�䷶Χ [%.2f, %.2f]\n',tspan_SET{i}(1),tspan_SET{i}(2))
    end
    % ������ ����
    if 0 % IMU
        figure;
        t_cor = zeros(length(IN_SENSOR_SET),1);
        t_cor(1) = 0;
        t_cor(2) = 4.4
        for jj = 1:length(IN_SENSOR_SET)
            subplot(3,2,1)
            plot(IN_SENSOR_SET(jj).IMU1.time+t_cor(jj),IN_SENSOR_SET(jj).IMU1.accel_x);hold on;
            subplot(3,2,3)
            plot(IN_SENSOR_SET(jj).IMU1.time+t_cor(jj),IN_SENSOR_SET(jj).IMU1.accel_y);hold on;
            subplot(3,2,5)
            plot(IN_SENSOR_SET(jj).IMU1.time+t_cor(jj),IN_SENSOR_SET(jj).IMU1.accel_z);hold on;
            subplot(3,2,2)
            plot(IN_SENSOR_SET(jj).IMU1.time+t_cor(jj),IN_SENSOR_SET(jj).IMU1.gyro_x);hold on;
            subplot(3,2,4)
            plot(IN_SENSOR_SET(jj).IMU1.time+t_cor(jj),IN_SENSOR_SET(jj).IMU1.gyro_y);hold on;
            subplot(3,2,6)
            plot(IN_SENSOR_SET(jj).IMU1.time+t_cor(jj),IN_SENSOR_SET(jj).IMU1.gyro_z);hold on;
        end
    end
    if 0
        IN_SENSOR = IN_SENSOR_SET(i);
        SinglePlot_Sensor
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
        figure(104)
        subplot(2,2,1)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.numSv);hold on;
        plot(IN_SENSOR.um482.time,IN_SENSOR.um482.numSv);hold on;
        ylabel('����')
        xlabel('sec')
        legend('ublox','um482')
        subplot(2,2,2)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.pDop);hold on;
        plot(IN_SENSOR.um482.time,IN_SENSOR.um482.pDop);hold on;
        ylabel('pDOP')
        xlabel('sec')
        legend('ublox','um482')
        subplot(2,2,3)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.sAcc);hold on;
%         plot(IN_SENSOR.ublox1.time,IN_SENSOR.um482.delta_height);hold on;
        ylabel('sAcc')
        xlabel('sec')
%         legend('ublox','um482')
        subplot(2,2,4)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.hAcc);hold on;
        plot(IN_SENSOR.um482.time,IN_SENSOR.um482.delta_height);hold on;
        ylabel('hAcc')
        xlabel('sec')
        legend('ublox','um482')
    end
end
%% ���û��ͱ���
PlaneMode.mode = selParamForPlaneMode();
%% ��ʼ����
nStateMARG = 22; % �˲���״̬ά��
%% �����˲�����
INIT_Navi;
%% ���÷ɻ�����
% INIT_UAV
%% �����ʼ��
% INIT_TASK
%% ����վָ��
% INIT_GROUNDSTATION
%% ���������ϲ���
INIT_SensorFault
%% ��������װ����
INIT_SensorAlignment
%% �źż��
INIT_SensorIntegrity
%% �Ӿ���½
INIT_VisualLanding
%% ���з���
modelname = 'TESTENV_NAVI';
% modelname = 'TESTENV_NAVI_12ms';
simMode = 'serial';  % parallel serial
switch simMode
    case 'parallel'
        tic
        SIM_FLIGHTDATA_IN(nFlightDataFile) = Simulink.SimulationInput(modelname);
        for i = 1:nFlightDataFile
            SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('IN_SENSOR',IN_SENSOR_SET(i));
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('IN_SENSOR_SIM',IN_SENSOR_SIM_SET(i));
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('tspan',tspan_SET(i));
        end
        out = parsim(SIM_FLIGHTDATA_IN,'RunInBackground','on',...
            'TransferBaseWorkspaceVariables','on');
        toc
        timeSpend = toc;
        fprintf('�������, ��ʱ %.2f [s]\n',timeSpend);
    case 'serial'
        for i = 1:nFlightDataFile
            tic
            IN_SENSOR = IN_SENSOR_SET(i);
            IN_SENSOR_SIM = IN_SENSOR_SIM_SET(i);
            if 0 %
                lowpassFreq = 5;
                figure;lowpass(IN_SENSOR_SIM.IMU1.gyro_x.signals.values,lowpassFreq,250)
                figure;lowpass(IN_SENSOR_SIM.IMU1.gyro_y.signals.values,lowpassFreq,250)
                figure;lowpass(IN_SENSOR_SIM.IMU1.gyro_z.signals.values,lowpassFreq,250)
                figure;lowpass(IN_SENSOR_SIM.IMU1.accel_x.signals.values,lowpassFreq,250)
                figure;lowpass(IN_SENSOR_SIM.IMU1.accel_y.signals.values,lowpassFreq,250)
                figure;lowpass(IN_SENSOR_SIM.IMU1.accel_z.signals.values,lowpassFreq,250,'Steepness',0.95);
                figure;
                plot(IN_SENSOR_SIM.IMU1.time.signals.values,IN_SENSOR_SIM.IMU1.accel_z.signals.values,'r');hold on;
                plot(IN_SENSOR_SIM.IMU1.time.signals.values,movavg(IN_SENSOR_SIM.IMU1.accel_z.signals.values,'linear',12),'b');hold on;
                grid on;
                %
                temp = zeros(size(IN_SENSOR_SIM.IMU1.time.signals.values));
                tempvalue = IN_SENSOR_SIM.IMU1.accel_y.signals.values;
                for i = 1:length(IN_SENSOR_SIM.IMU1.time.signals.values)
                    idx = max(1,i-1);
                    temp(i) = 2/3*temp(idx) + 1/3*tempvalue(i);
                end
                figure;
                plot(IN_SENSOR_SIM.IMU1.time.signals.values,tempvalue,'r');hold on;
                plot(IN_SENSOR_SIM.IMU1.time.signals.values,temp,'b');hold on;
                %                 plot(IN_SENSOR_SIM.IMU1.time.signals.values,movavg(IN_SENSOR_SIM.IMU1.accel_z.signals.values,'linear',12),'r-');hold on;
                %                 plot(IN_SENSOR_SIM.IMU1.time.signals.values,lowpass(IN_SENSOR_SIM.IMU1.accel_z.signals.values,lowpassFreq,250),'k-');hold on;
                %                 IN_SENSOR_SIM.IMU1.accel_x.signals.values = lowpass(IN_SENSOR_SIM.IMU1.accel_x.signals.values,lowpassFreq,250);
                %                 IN_SENSOR_SIM.IMU1.accel_y.signals.values = lowpass(IN_SENSOR_SIM.IMU1.accel_y.signals.values,lowpassFreq,250);
                %                 IN_SENSOR_SIM.IMU1.accel_z.signals.values = lowpass(IN_SENSOR_SIM.IMU1.accel_z.signals.values,lowpassFreq,250);
                %
                %                 IN_SENSOR_SIM.IMU1.gyro_x.signals.values = lowpass(IN_SENSOR_SIM.IMU1.gyro_x.signals.values,lowpassFreq,250);
                %                 IN_SENSOR_SIM.IMU1.gyro_y.signals.values = lowpass(IN_SENSOR_SIM.IMU1.gyro_y.signals.values,lowpassFreq,250);
                %                 IN_SENSOR_SIM.IMU1.gyro_z.signals.values = lowpass(IN_SENSOR_SIM.IMU1.gyro_z.signals.values,lowpassFreq,250);
            end
            sensors = sensors_SET(i);
            tspan = tspan_SET{i};
            % ����
            out(i) = sim(modelname);
            % ���ݺ���
            [navFilterMARGRes_SET(i),t_alignment(i)] = PostDataHandle_SimulinkModel(out(i),Ts_Compass.Ts_base);
            timeSpend = toc;
            fprintf('��%d�����ݵķ������, ��ʱ %.2f [s]\n',i,timeSpend);
        end
end
%% �����ͼ
nSim = nFlightDataFile;
plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    navFilterMARGRes = navFilterMARGRes_SET(1);
    sensors = sensors_SET(1);
    % ------------  ���������� ---------------
    fig = figure(102);
    GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2;IMU3','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR(1),2,2,fig)
    if 0
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
    end
    % ------------  ԭ�㷨���� ---------------
    if 0
        SinglePlot_New_Vs_Old
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
    % ------------  innvo��Ϣ ---------------
    if 0
        figure;
        time_m = navFilterMARGRes(1).Algo.time_algo;
        data = navFilterMARGRes(1).Algo.innov;
        for i_innov = 1:3
            subplot(3,3,i_innov)
            plot(time_m,data(:,i_innov));
        end
        for i_innov = 1:3
            subplot(3,3,3+i_innov)
            plot(time_m,data(:,3+i_innov));
        end
        for i_innov = 1:3
            subplot(3,3,6+i_innov)
            plot(time_m,data(:,6+i_innov));
        end
    end
    % ------------  MARG�˲��� ---------------
    plotOpt.hold = 'on';
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    for i_sim = 1:nSim
        navFilterMARGRes = navFilterMARGRes_SET(i_sim);
        sensors = sensors_SET(i_sim);
        idx_color = rem(i_sim,nColor)+1;
        idx_style = ceil(i_sim/nColor);
        idx_color = rem(idx_color,nColor) + 1;
        idx_style = rem(idx_style,nStyle) + 1;
        
        SinglePlot_MARG
        
        if isempty(t_alignment(i_sim))
            fprintf('δ�ܳɹ���ɳ���׼\n')
        else
            fprintf('����׼���ʱ��: %.2f \n',t_alignment(i_sim))
        end
        %
        if 1
            fig = figure(222);
            fig.Name = '�˲�ֵ vs ����ֵ';
            myplot_sensor_filter_compare(sensors,navFilterMARGRes,plotOpt,idx_color,idx_style,stepSpace);
        end
        %
        if 0 % ----------- ���ٶȲ������ -------------
            figure;
            time = IN_SENSOR.IMU1.time;
            gyro = [IN_SENSOR.IMU1.gyro_x,IN_SENSOR.IMU1.gyro_y,IN_SENSOR.IMU1.gyro_z];
            plot(time,gyro,'r');hold on;
            gyro_correct = [navFilterMARGRes.Algo.dWB_00,...
                navFilterMARGRes.Algo.dWB_11,...
                navFilterMARGRes.Algo.dWB_22]*pi/180;
            plot(time,gyro-gyro_correct(1:end-1,:),'k');
            legend('ԭʼֵ','ԭʼֵ','ԭʼֵ','����ֵ','����ֵ','����ֵ')
            ylabel('gyro (rad/s)')
            xlabel('time (s)')
            hold on;grid on
        end
        % --------------- �㷨�Ա� -----------------
        if 0
            figure(213)
            myplot_navfilter(navFilterMARGRes,plotOpt,1,idx_style,stepSpace); % ��ʾ��ϵ�������
            myplot_navfilter(sensors(1),plotOpt,3,2,stepSpace); % ��ʾ��ϵ�������
        end
        if 0
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 �Ĵ�\','px4_1_30065�̼������㷨��̬��΢�ζ��Լ����һζ�����.BIN-444041.mat'])
            PX4_Time0 = 178.5*1e6;%NKF1(1,2);
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 �Ĵ�\','px4_2_30066�̼������㷨��̬��΢�ζ��Լ����һζ�����.BIN-783439.mat'])
            PX4_Time0 = 156.8*1e6;%NKF1(1,2);
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 �Ĵ�\','px4_4_��4�ܴ�30066���һζ�.BIN-473335.mat'])
            PX4_Time0 = -14*1e6;%NKF1(1,2);
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 �Ĵ�\','px4_6_��6�ܴ�30065���ȡ����ߡ����Ȼζ����в���.BIN-698959.mat'])
            PX4_Time0 = 591.95*1e6;%NKF1(1,2);
            load(['20200214 �Ĵ�\','px4_11_30066����ģʽǰ�ɼ�����8m����.BIN-685169.mat'])
            PX4_Time0 = 40.23*1e6;%NKF1(1,2);
            load(['20200217 �Ĵ�\','PX4_1_30068�̼� �β����澲���Լ������ζ������һζ����ò���.BIN-803302.mat'])
            PX4_Time0 = 48.1*1e6;%NKF1(1,2);
            load(['20200217 �Ĵ�\','PX4_2_30069�̼� �β��㷨 ��̬ģʽ��ͣ�Լ�ǰ�ɼ�����8m����.BIN-558524.mat'])
            PX4_Time0 = 491.6*1e6;%NKF1(1,2);
            load(['20200228 ��ʤ\','PX4_1_30080�̼� ���ٶ���ģʽ���� Ч������.mat'])
            PX4_Time0 = 290.44*1e6;%NKF1(1,2);
            
            % PX4_2_30069�̼� �β��㷨 ��̬ģʽ��ͣ�Լ�ǰ�ɼ�����8m����.BIN-558524
            time_sl = sensors.IMU.time_imu(1:4:end);
            idx_sel = [1:length(time_sl)];
            figure(33)
            subplot(311)
            PX4yaw = NKF1(1:end-1,5);
            PX4yaw(PX4yaw>180) = PX4yaw(PX4yaw>180)-360;
            plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,PX4yaw,'r');hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_yaw,'k');hold on;
            plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_yaw(idx_sel),'b');hold on;
            legend('PX4','����','����')
            xlabel('t(s)')
            ylabel('yaw(deg)')
            subplot(312)
            plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,4),'r');hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_pitch,'k');hold on;
            plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_pitch(idx_sel),'b');hold on;
            legend('PX4','����','����')
            xlabel('t(s)')
            ylabel('pitch(deg)')
            %             plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_2,'k--');hold on;
            subplot(313)
            plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,3),'r');hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_roll,'k');hold on;
            plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_roll(idx_sel),'b');hold on;
            legend('PX4','����','����')
            xlabel('t(s)')
            ylabel('roll(deg)')
            if 0
                figure(121)
                subplot(131)
                plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,6),'r');hold on;
                plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_0,'k');hold on;
                plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velN,'b');hold on;
                legend('PX4','����','V1000 gps')
                xlabel('t(s)')
                ylabel('Vn (m/s)')
                subplot(132)
                plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,7),'r');hold on;
                plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_1,'k');hold on;
                plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velE,'b');hold on;
                xlabel('t(s)')
                ylabel('Ve (m/s)')
                subplot(133)
                plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,8),'r');hold on;
                plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_2,'k');hold on;
                plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velD,'b');hold on;
                xlabel('t(s)')
                ylabel('Vd (m/s)')
            end
            if 0
                fig = figure;
                fig.Name = 'IMU'
                plot(IN_SENSOR.IMU1.time,IN_SENSOR.IMU1.accel_z,'r');hold on;
                plot(IN_SENSOR.IMU1.time,lowpass( IN_SENSOR.IMU1.accel_z,2, 250),'k');hold on;
                plot((IMU(:,2)-PX4_Time0)*1e-6,-IMU(:,8),'b');hold on;
                legend('V1000','V1000�˲�','PX4')
                xlabel('t(s)')
                ylabel('acc_z(m/s^2)')
            end
            if 0
                figure;
                subplot(131)
                plot(ATT(:,2),ATT(:,8),'r');hold on;
                plot(NKF1(:,2),NKF1(:,5),'k');hold on;
                plot(NKF6(:,2),NKF6(:,5),'b');hold on;
                xlabel('t(s)')
                ylabel('yaw(deg)')
                subplot(132)
                plot(ATT(:,2),ATT(:,6),'r');hold on;
                plot(NKF1(:,2),NKF1(:,4),'k');hold on;
                plot(NKF6(:,2),NKF6(:,4),'b');hold on;
                xlabel('t(s)')
                ylabel('pitch(deg)')
                subplot(133)
                plot(ATT(:,2),ATT(:,4),'r');hold on;
                plot(NKF1(:,2),NKF1(:,3),'k');hold on;
                plot(NKF6(:,2),NKF6(:,3),'b');hold on;
                xlabel('t(s)')
                ylabel('roll(deg)')
            end
        end
        if 0
            figure
            subplot(311)
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_pos_2,'r');hold on;
            plot(sensors.GPS.time_ublox,sensors.GPS.ublox_height,'b--');hold on;
            ylabel('�߶�')
            subplot(312)
            plot(sensors.Baro.time_baro,sensors.Baro.altitue,'r');hold on;
            plot(sensors.GPS.time_ublox,sensors.GPS.ublox_height,'b--');hold on;
            ylabel('�߶�')
            %% �߶��ٶȶԱ�
            SinglePlot_Online_Vs_Offline
            %% �����ƾ���ֵ
            figure
            magNorm = vecnorm([sensors.Mag.mag2calib_x_magFrame,sensors.Mag.mag2calib_y_magFrame,sensors.Mag.mag2calib_z_magFrame],2,2);
            %             magNorm = vecnorm([sensors.Mag.mag2_x,sensors.Mag.mag2_y,sensors.Mag.mag2_z],2,2);
            plot(sensors.Mag.time_mag,magNorm);hold on;
            %% speed
            figure
            velNorm = vecnorm([sensors.GPS.ublox_velN,sensors.GPS.ublox_velE,sensors.GPS.ublox_velD],2,2);
            plot(sensors.GPS.time_ublox,velNorm);hold on;
        end
        if 1
            % ʱ���
            figure;
            plot(IN_SENSOR.IMU1.time(1:end-1),diff(IN_SENSOR.IMU1.time),'-');
            xlabel('time (sec)')
            ylabel('IMU1�����ݼ�¼���');
            grid on;
%             subplot(42)
%             plot(IN_SE1NSOR.ublox1.time,IN_SENSOR.ublox1.velD,'o');
%             ylabel('ublox')
%             grid on;
%             subplot(413)
%             plot(IN_SENSOR.mag2.time,IN_SENSOR.mag2.mag_x,'o');
%             ylabel('mag');
%             grid on;
%             subplot(414)
%             plot(IN_SENSOR.baro1.time,IN_SENSOR.baro1.alt_baro,'o');
%             ylabel('baro');
%             grid on;
        end
        if 0
            figure;
            subplot(411)
            plot(IN_SENSOR.IMU1.time,IN_SENSOR.IMU1.accel_x,'o');
            ylabel('IMU1');
            grid on;
            subplot(412)
            plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velD,'o');
            ylabel('ublox')
            grid on;
            subplot(413)
            plot(IN_SENSOR.mag2.time,IN_SENSOR.mag2.mag_x,'o');
            ylabel('mag');
            grid on;
            subplot(414)
            plot(IN_SENSOR.baro1.time,IN_SENSOR.baro1.alt_baro,'o');
            ylabel('baro');
            grid on;
        end
        if 1
            SinglePlot_Online_Vs_Offline
        end
        % ���Ʒ���
        if 0
            SinglePlot_Pcov
        end
    end
end