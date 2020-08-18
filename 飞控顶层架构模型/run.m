clear,clc
clear global
%%
Ts_SimBigModel.Ts_base = 0.004;
Ts_BigModel.Ts_base = 0.012;
%% 通用参数设置
GLOBAL_PARAM.ModeSel.simMode = 'simulink_flightdata'; % 'matlab_flightdata'  'simulink_flightdata'  'simulink_simdata'
SetGlobalParam();
%%
if strcmp( GLOBAL_PARAM.ModeSel.simMode,'matlab_flightdata') || strcmp( GLOBAL_PARAM.ModeSel.simMode,'simulink_flightdata') % 飞行数据仿真
    %% 载入飞行数据并生成仿真格式数据
    tspan = [0,1500]; % sec
    dataFileNames = {['20200418\仿真数据_log_1_V1000-24#V31132固件管家点击起飞后飞机快速向右后方移动']};    
    dataFileNames = {['SubFolder_飞行数据\20200506\仿真数据_90dae1f08ccd46efba27d5c1121debf6']};    
    dataFileNames = {['SubFolder_飞行数据\20200522\仿真数据_log_2_宝坻第2架次V1000-27# V31145固件 全流程飞行']};    
    dataFileNames = {['SubFolder_飞行数据\20200720\仿真数据_5bd11c4543e747c29c5f9fe535b14e98']};
    dataFileNames = {['SubFolder_飞行数据\20200731\仿真数据_2020-07-31 18-37-01 风速跳变得比较频繁']};
    dataFileNames = {['SubFolder_飞行数据\20200818\仿真数据_log 地面仿真 空速']};
%     dataFileNames = {['SubFolder_飞行数据\V1000 客户飞行数据\20200811 长江空间信息技术工程有限公司（武汉） 西藏\仿真数据_2020-08-09 11-59-55 风速显示异常']};
    nFlightDataFile = length(dataFileNames);
    for i = 1:nFlightDataFile
        [IN_SENSOR(i),IN_SENSOR_SIM(i),sensors(i),tspan_set{i}] = step1_loadFlightData(tspan,dataFileNames{i},BUS_SENSOR);
    end
    tspan = tspan_set{1};
    % 传感器曲线
    if 1
        fig = figure(102);
        GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR(1),2,2,fig)
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
        figure(104)
        subplot(2,2,1)
        plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.numSv);
        ylabel('星数')
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
%% 开始仿真
nSim = 1;
PARALLEL_PARAM_SET(1).std_gyro = pi/180*0.1*[1,1,1];  % rad/s 标准差（非平方）
PARALLEL_PARAM_SET(2).std_gyro = pi/180*0.05*[1,1,1];
PARALLEL_PARAM_SET(3).std_gyro = pi/180*0.01*[1,1,1];
PARALLEL_PARAM_SET(1).ALGO_SET.SensorSelect.Mag = 2;
PARALLEL_PARAM_SET(2).ALGO_SET.SensorSelect.Mag = 2;
nStateMARG = 22; % 滤波器状态维数
%% 执行仿真
switch GLOBAL_PARAM.ModeSel.simMode
    case 'matlab_flightdata'
        for i_mat = 1:nFlightDataFile
            for i_sim = 1:nSim
                tic
                % 数据摘取
                %                 measureData = MeasureDatas(i_mat);
                %                 simdata = SimDatas(i_mat);
                %                 sensors = Sensors(i_mat);
                %                 filterdata = FilterDatas(i_mat);
                % 滤波参数设置
                N = size(IN_SENSOR.IMU1.time,1);
                %                 [ALGO_SET,sensorFs] = step2_setALGOparam_flightData(PARALLEL_PARAM_SET(i_sim));
                %% 组合导航初始化
                INIT_Navi
                % 运行滤波实例
                idx = (i_mat-1)*nFlightDataFile + i_sim;
                runFilter_Matlab
                timeSpend = toc;
                fprintf('模型<%d>仿真完成, 耗时 %.2f [s]\n',idx,timeSpend);
            end
        end
    case 'simulink_flightdata'
        tic
        %%
        SimulinkRunMode = 1;
        % [ALGO_SET,sensorFs] = step2_setALGOparam_flightData();
        %% 控制率初始化
        Ts_Control.Ts_base = 0.012;
        Ts_Compass.Ts_base = 0.012;
        INIT_Control
        %% 框架模型
        Ts_Architechure.Ts_base = 0.012;
        %% 控制模块初始化
        % INIT_CONTROL
        %% 组合导航初始化
        INIT_Navi
        %%
        INIT_UAV
        %% 任务初始化
        INIT_TASK
        % 简化的运动模型
        INIT_SIMPLEUAVMOTION
        %% 地面站指令
        INIT_GROUNDSTATION
        %% 传感器故障参数
        INIT_SensorFault
        %% 传感器安装参数
        INIT_SensorAlignment
        %% 信号检测
        INIT_SensorIntegrity
        %% 飞行性能
        INIT_FlightPerformance
        %% 运行仿真
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
        %% 数据后处理
        [navFilterMARGRes,t_alignment] = PostDataHandle_SimulinkModel(out,Ts_Navi.Ts_Base);
        %%  
        timeSpend = toc;
        fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
    case 'simulink_simdata'
        tic
        runFilter_Simulink_SimData
        timeSpend = toc;
        fprintf('模型<%d>仿真完成, 耗时 %.2f [s]\n',i_sim,timeSpend);
        return
    otherwise
        error('错误的仿真模式')
end
%% 仿真绘图
plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    % ------------  原算法数据 ---------------
    if 0
        figure(103)
        myplot_navfilter(sensors,plotOpt,1,1,stepSpace); % 显示组合导航数据
        myplot_navfilter(navFilterMARGRes(1),plotOpt,2,2,stepSpace); % 显示组合导航数据
    end
    % ------------  mag反算 ---------------
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
    % ------------  MARG滤波器 ---------------
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
        postplot_marg_flightdata(navFilterMARGRes(i_sim),plotOpt,idx_color,idx_style,stepSpace) %显示组合导航数据
        
        if isempty(t_alignment(i_sim))
            fprintf('未能成功完成初对准\n')
        else
            fprintf('初对准完成时间: %.2f \n',t_alignment(i_sim))
        end
        %
        if 1
            fig = figure(222);
            fig.Name = '滤波值 vs 测量值';
            myplot_sensor_filter_compare(sensors,navFilterMARGRes(i_sim),plotOpt,idx_color,idx_style,stepSpace);
        end
        if 0
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\','仿真数据_log0_0107_PX4'])
            % 姿态
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
            % 位置
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
            % 算法对比： 离线 vs 在线
            SinglePlot_Online_Vs_Offline
        end
        % 绘制方差
        if 0
            SinglePlot_Pcov
        end        
    end
end