if 0
    clear,clc
    clear global
    dataFileNames = {['20200417\仿真数据_log_4_V1000-24# V31131固件 全流程航线飞行调参']}; 
    dataFileNames = {['SubFolder_飞行数据\20200522\仿真数据_log_2_宝坻第2架次V1000-27# V31145固件 全流程飞行']};    
    dataFileNames = {['SubFolder_飞行数据\20200601\仿真数据_2020-06-01 16-47-50 航向异常']};    
    dataFileNames = {['SubFolder_飞行数据\20200910\仿真数据_2020年9月11日 宝坻 V1000-55# V31199固件 旋翼增稳低高度悬停  保持参数短时全流程 2020-09-11 18-04-08']};
else
    try
        dataFileNames = saveFileName;
        save lastFlightDataFileLoadedForNavi.mat dataFileNames
    catch
        load('lastFlightDataFileLoadedForNavi');
        fprintf('\n当前工作空间没有 dataFileNames, 读取最后一次载入的数据文件: %s\n\n',dataFileNames{1});
    end
end
%% 通用参数设置
SetGlobalParam();
%% 
Ts_Compass.Ts_base = 0.012;
%%
%% 载入飞行数据并生成仿真格式数据
tspan0 = [200,300]; % sec   [0,inf]
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR_SET(i),IN_SENSOR_SIM_SET(i),sensors_SET(i),tspan_SET{i},timeSpanValidflag] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    if ~timeSpanValidflag
        str = sprintf('时间设置错误: 中止时间(%d) < 起始时间(%d)',int64(tspan_SET{i}(2)),int64(tspan_SET{i}(1)));
        warndlg(str)
        return;
    else
        fprintf('仿真数据的IMU时间范围 [%.2f, %.2f]\n',tspan_SET{i}(1),tspan_SET{i}(2))
    end
end
%% 设置机型变量
PlaneMode.mode = selParamForPlaneMode();
%% 开始仿真
nStateMARG = 22; % 滤波器状态维数
%% 设置滤波参数
INIT_Navi;
%% 设置飞机参数
% INIT_UAV
%% 任务初始化
% INIT_TASK
%% 地面站指令
% INIT_GROUNDSTATION
%% 传感器故障参数
INIT_SensorFault
%% 传感器安装参数
INIT_SensorAlignment
%% 信号检测
INIT_SensorIntegrity
%% 视觉着陆
INIT_VisualLanding
%% 运行仿真
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
        fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
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
            % 仿真
            out(i) = sim(modelname);
            % 数据后处理
            [navFilterMARGRes_SET(i),t_alignment(i)] = PostDataHandle_SimulinkModel(out(i),Ts_Compass.Ts_base);
            timeSpend = toc;
            fprintf('第%d组数据的仿真完成, 耗时 %.2f [s]\n',i,timeSpend);
        end
end
%% 仿真绘图
Plot_NaviSimData();
Plot_NaviLogTable();