if 0
    clear,clc
    clear global
    dataFileNames = {['20200417\��������_log_4_V1000-24# V31131�̼� ȫ���̺��߷��е���']}; 
    dataFileNames = {['SubFolder_��������\20200522\��������_log_2_�����2�ܴ�V1000-27# V31145�̼� ȫ���̷���']};    
    dataFileNames = {['SubFolder_��������\20200601\��������_2020-06-01 16-47-50 �����쳣']};    
    dataFileNames = {['SubFolder_��������\20200910\��������_2020��9��11�� ���� V1000-55# V31199�̼� �������ȵ͸߶���ͣ  ���ֲ�����ʱȫ���� 2020-09-11 18-04-08']};
else
    try
        dataFileNames = saveFileName;
        save lastFlightDataFileLoadedForNavi.mat dataFileNames
    catch
        load('lastFlightDataFileLoadedForNavi');
        fprintf('\n��ǰ�����ռ�û�� dataFileNames, ��ȡ���һ������������ļ�: %s\n\n',dataFileNames{1});
    end
end
%% ͨ�ò�������
SetGlobalParam();
%% 
Ts_Compass.Ts_base = 0.012;
%%
%% ����������ݲ����ɷ����ʽ����
tspan0 = [200,300]; % sec   [0,inf]
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
Plot_NaviSimData();
Plot_NaviLogTable();