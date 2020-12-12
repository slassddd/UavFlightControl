% 仿真数据绘制
nSim = nFlightDataFile;
plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    navFilterMARGRes = navFilterMARGRes_SET(1);
    sensors = sensors_SET(1);
    % ------------  传感器数据 ---------------
    fig = figure(102);
    GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2;IMU3','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR(1),2,2,fig)
    if 0
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
    end
    % ------------  原算法数据 ---------------
    if 0
        SinglePlot_New_Vs_Old
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
    % ------------  innvo新息 ---------------
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
    % ------------  MARG滤波器 ---------------
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
            fprintf('未能成功完成初对准\n')
        else
            fprintf('初对准完成时间: %.2f \n',t_alignment(i_sim))
        end
        %
        if 1
            fig = figure(222);
            fig.Name = '滤波值 vs 测量值';
            myplot_sensor_filter_compare(sensors,navFilterMARGRes,plotOpt,idx_color,idx_style,stepSpace);
        end
        %
        if 0 % ----------- 角速度补偿结果 -------------
            figure;
            time = IN_SENSOR.IMU1.time;
            gyro = [IN_SENSOR.IMU1.gyro_x,IN_SENSOR.IMU1.gyro_y,IN_SENSOR.IMU1.gyro_z];
            plot(time,gyro,'r');hold on;
            gyro_correct = [navFilterMARGRes.Algo.dWB_00,...
                navFilterMARGRes.Algo.dWB_11,...
                navFilterMARGRes.Algo.dWB_22]*pi/180;
            plot(time,gyro-gyro_correct(1:end-1,:),'k');
            legend('原始值','原始值','原始值','矫正值','矫正值','矫正值')
            ylabel('gyro (rad/s)')
            xlabel('time (s)')
            hold on;grid on
        end
        % --------------- 算法对比 -----------------
        if 0
            figure(213)
            myplot_navfilter(navFilterMARGRes,plotOpt,1,idx_style,stepSpace); % 显示组合导航数据
            myplot_navfilter(sensors(1),plotOpt,3,2,stepSpace); % 显示组合导航数据
        end
        if 0
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 四川\','px4_1_30065固件王博算法静态轻微晃动以及猛烈晃动测试.BIN-444041.mat'])
            PX4_Time0 = 178.5*1e6;%NKF1(1,2);
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 四川\','px4_2_30066固件王博算法静态轻微晃动以及猛烈晃动测试.BIN-783439.mat'])
            PX4_Time0 = 156.8*1e6;%NKF1(1,2);
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 四川\','px4_4_第4架次30066剧烈晃动.BIN-473335.mat'])
            PX4_Time0 = -14*1e6;%NKF1(1,2);
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\20200214 四川\','px4_6_第6架次30065增稳、定高、增稳晃动飞行测试.BIN-698959.mat'])
            PX4_Time0 = 591.95*1e6;%NKF1(1,2);
            load(['20200214 四川\','px4_11_30066定高模式前飞加速至8m左右.BIN-685169.mat'])
            PX4_Time0 = 40.23*1e6;%NKF1(1,2);
            load(['20200217 四川\','PX4_1_30068固件 宋博地面静置以及缓慢晃动、剧烈晃动静置测试.BIN-803302.mat'])
            PX4_Time0 = 48.1*1e6;%NKF1(1,2);
            load(['20200217 四川\','PX4_2_30069固件 宋博算法 姿态模式悬停以及前飞加速至8m左右.BIN-558524.mat'])
            PX4_Time0 = 491.6*1e6;%NKF1(1,2);
            load(['20200228 宝胜\','PX4_1_30080固件 定速定高模式飞行 效果不错.mat'])
            PX4_Time0 = 290.44*1e6;%NKF1(1,2);
            
            % PX4_2_30069固件 宋博算法 姿态模式悬停以及前飞加速至8m左右.BIN-558524
            time_sl = sensors.IMU.time_imu(1:4:end);
            idx_sel = [1:length(time_sl)];
            figure(33)
            subplot(311)
            PX4yaw = NKF1(1:end-1,5);
            PX4yaw(PX4yaw>180) = PX4yaw(PX4yaw>180)-360;
            plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,PX4yaw,'r');hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_yaw,'k');hold on;
            plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_yaw(idx_sel),'b');hold on;
            legend('PX4','离线','在线')
            xlabel('t(s)')
            ylabel('yaw(deg)')
            subplot(312)
            plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,4),'r');hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_pitch,'k');hold on;
            plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_pitch(idx_sel),'b');hold on;
            legend('PX4','离线','在线')
            xlabel('t(s)')
            ylabel('pitch(deg)')
            %             plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_2,'k--');hold on;
            subplot(313)
            plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,3),'r');hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_roll,'k');hold on;
            plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_roll(idx_sel),'b');hold on;
            legend('PX4','离线','在线')
            xlabel('t(s)')
            ylabel('roll(deg)')
            if 0
                figure(121)
                subplot(131)
                plot((NKF1(1:end-1,2)-PX4_Time0)*1e-6,NKF1(1:end-1,6),'r');hold on;
                plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_0,'k');hold on;
                plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velN,'b');hold on;
                legend('PX4','离线','V1000 gps')
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
                legend('V1000','V1000滤波','PX4')
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
            ylabel('高度')
            subplot(312)
            plot(sensors.Baro.time_baro,sensors.Baro.altitue,'r');hold on;
            plot(sensors.GPS.time_ublox,sensors.GPS.ublox_height,'b--');hold on;
            ylabel('高度')
            %% 高度速度对比
            SinglePlot_Online_Vs_Offline
            %% 磁力计绝对值
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
            % 时间戳
            figure;
            plot(IN_SENSOR.IMU1.time(1:end-1),diff(IN_SENSOR.IMU1.time),'-');
            xlabel('time (sec)')
            ylabel('IMU1的数据记录间隔');
            grid on;
        end
        if 1
            SinglePlot_Online_Vs_Offline
        end
        % 绘制方差
        if 0
            SinglePlot_Pcov
        end
    end
end