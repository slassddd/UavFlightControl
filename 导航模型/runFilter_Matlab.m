clear global
fs = sensorFs.imuUpdateFs;

filterOpt.enable.marg = 1;
filterOpt.enable.ahrs10 = 0;
filterOpt.enable.errorstate = 0;
filterOpt.enable.ecompass = 0;

filterRes.IMU.q = zeros(N,1,'like',quaternion());
filterRes.IMU.gyro = zeros(N,3);
q_ecompass = zeros(N,1,'like',quaternion());

filterRes.MARG.q = zeros(N,1,'like',quaternion());
filterRes.MARG.pos = zeros(N,3);
filterRes.MARG.vel = zeros(N,3);
filterRes.MARG.dangle = zeros(N,3);
filterRes.MARG.dvel = zeros(N,3);
filterRes.MARG.mag = zeros(N,3);
filterRes.MARG.dmag = zeros(N,3);
filterRes.MARG.innov = zeros(N,9);
filterRes.MARG.RMAG_diag = zeros(N,3); 
filterRes.MARG.RGPS_diag = zeros(N,6);

filterRes.AHRS10.q = zeros(N,1,'like',quaternion());
filterRes.AHRS10.alt = zeros(N,1);
filterRes.AHRS10.altvel = zeros(N,1);
filterRes.AHRS10.dangle = zeros(N,3);
filterRes.AHRS10.dvel = zeros(N,3);
filterRes.AHRS10.mag = zeros(N,3);
filterRes.AHRS10.dmag = zeros(N,3);

q_errstate = zeros(N,1,'like',quaternion());
pos_errstate = zeros(N,3);
vel_errstate = zeros(N,3);
dw_errstate = zeros(N,3);
da_errstate = zeros(N,3);
vos_errstate = zeros(N,3);

filterRes.MARG.P = zeros(N,22);
P_errstate = zeros(N,17);
filterRes.AHRS10.P = zeros(N,18);

dpos = zeros(N,1);
%% 仿真
disp('开始进行仿真')
idx_gps = 1;
idx_baro = 1;
idx_radar = 1;
idx_mag = 1;
lla = [0,0,0];
gpsvel = [0,0,0];
alt = 0;
mag = 0;
range = 0;
alignmentComplete = 0; % 0: 激活初始对准——实际情况   1：直接滤波——调试算法
for i = 1:N
    accel = - [IN_SENSOR.IMU1.accel_x(i),IN_SENSOR.IMU1.accel_y(i),IN_SENSOR.IMU1.accel_z(i)];
    gyro = [IN_SENSOR.IMU1.gyro_x(i),IN_SENSOR.IMU1.gyro_y(i),IN_SENSOR.IMU1.gyro_z(i)];
    if rem(i,fs/sensorFs.gpsUpdateFs) == 0
        if size(IN_SENSOR.ublox1.time,1) < idx_gps
            return;
        end
        lla = [IN_SENSOR.ublox1.Lat(idx_gps),IN_SENSOR.ublox1.Lon(idx_gps),IN_SENSOR.ublox1.height(idx_gps)];
        gpsvel = [IN_SENSOR.ublox1.velN(idx_gps),IN_SENSOR.ublox1.velE(idx_gps),IN_SENSOR.ublox1.velD(idx_gps)];
        idx_gps = idx_gps + 1;
    end
    if rem(i,fs/sensorFs.baroUpdateFs) == 0
        if size(IN_SENSOR.baro1.alt_baro,1) < idx_baro
            return;
        end
        alt = IN_SENSOR.baro1.alt_baro(idx_baro);
        idx_baro = idx_baro + 1;
    end
    if rem(i,fs/sensorFs.magUpdateFs) == 0
        if size(IN_SENSOR.mag2.mag_x,1) < idx_mag
            return;
        end
        mag = 1e2*[IN_SENSOR.mag2.mag_x(idx_mag),IN_SENSOR.mag2.mag_y(idx_mag),IN_SENSOR.mag2.mag_z(idx_mag)];
        tmp = -mag(1);
        mag(1) = -mag(2);
        mag(2) = tmp;
        mag(3) = -mag(3);
        idx_mag = idx_mag + 1;
    end  
    if rem(i,fs/sensorFs.radarUpdateFs) == 0
        if size(IN_SENSOR.radar1.Range,1) < idx_radar
            return;
        end
        range = IN_SENSOR.radar1.Range(idx_radar);
        idx_radar = idx_radar + 1;
    end                   
    % ------------- 初始对准 -------------------
    if alignmentComplete ~= 1
        [alignmentComplete,refloc,eulerd0,quat0,acc_bias0,dw0,mag0,pos0,alt0,range0] = ...
                    coarseAlignment(i,accel,gyro,mag,lla,gpsvel,alt,range,...
                    sensorFs.imuUpdateFs,sensorFs.magUpdateFs,sensorFs.gpsUpdateFs,sensorFs.baroUpdateFs,sensorFs.radarUpdateFs);
        if alignmentComplete
            X0_errstate17 = [quat0,[0,0,0],[0,0,0],dw0,[0,0,0],1];
            X0_ahrs10 = [quat0,pos0(3),0,dw0/fs,[0,0,0],mag0,zeros(1,3)];
            X0_marg22 = [quat0,pos0,[0,0,0],dw0/fs,[0,0,0],mag0,zeros(1,3)];
            t_alignment(idx) = IN_SENSOR.time(i);
            disp('初始对准完成!')
        end
    end
    if alignmentComplete        
        % ------------- error state ----------------
        if filterOpt.enable.errorstate            
            [stateEst,stateCovarianceDiag] = navigation_errorstate17(i,accel,gyro,mag,ALGO_SET.Rmag,lla,ALGO_SET.Rpos,gpsvel,ALGO_SET.Rvel,...
                sensorFs.imuUpdateFs,sensorFs.magUpdateFs,sensorFs.gpsUpdateFs,sensorFs.baroUpdateFs,sensorFs.radarUpdateFs,...
                X0_errstate17,ALGO_SET.P0_errorstate17,fs,refloc,ALGO_SET.std_acc,ALGO_SET.std_acc_bias,ALGO_SET.std_alt,ALGO_SET.std_gpsvel,...
                ALGO_SET.std_gyro,ALGO_SET.std_gyro_bias,ALGO_SET.std_magNED,ALGO_SET.std_mag_bias);
            filterRes.ErrorState.q(i,:) = quaternion(stateEst(1:4)');
            filterRes.ErrorState.pos(i,:) = stateEst(5:7);
            filterRes.ErrorState.vel(i,:) = stateEst(8:10);
            filterRes.ErrorState.dw(i,:) = stateEst(11:13);
            filterRes.ErrorState.da(i,:) = stateEst(14:16);
            filterRes.ErrorState.vos(i,:) = stateEst(17);
            filterRes.ErrorState.P(i,:) = [0, stateCovarianceDiag];
        end
        % -------------   AHRS10    ----------------
        if filterOpt.enable.ahrs10            
            [stateEst,stateCovarianceDiag] = navigation_ahrs10(i,accel,gyro,mag,ALGO_SET.Rmag,lla,ALGO_SET.Rpos,gpsvel,ALGO_SET.Rvel,...
                sensorFs.imuUpdateFs,sensorFs.magUpdateFs,sensorFs.gpsUpdateFs,sensorFs.baroUpdateFs,sensorFs.radarUpdateFs,...
                X0_ahrs10,ALGO_SET.P0_ahrs10,fs,refloc,ALGO_SET.std_acc,ALGO_SET.std_acc_bias,ALGO_SET.std_alt,ALGO_SET.std_gpsvel,...
                ALGO_SET.std_gyro,ALGO_SET.std_gyro_bias,ALGO_SET.std_magNED,ALGO_SET.std_mag_bias);
            filterRes.AHRS10.q(i,:) = quaternion(stateEst(1:4)');
            filterRes.AHRS10.alt(i,:) = stateEst(5);
            filterRes.AHRS10.altvel(i,:) = stateEst(6);
            filterRes.AHRS10.dangle(i,:) = stateEst(7:9);
            filterRes.AHRS10.dvel(i,:) = stateEst(10:12);
            filterRes.AHRS10.mag(i,:) = stateEst(13:15);
            filterRes.AHRS10.dmag(i,:) = stateEst(16:18);
            filterRes.AHRS10.P(i,:) = stateCovarianceDiag;
        end    
        % -------------   MARG    ----------------
        if filterOpt.enable.marg            
            [stateEst,stateCovarianceDiag,innov,Rmag_online,Rgps_online] = navigation_marg22(i,accel,gyro,mag,ALGO_SET.Rmag,lla,ALGO_SET.Rpos,gpsvel,ALGO_SET.Rvel,alt,ALGO_SET.Ralt,...
                sensorFs.imuUpdateFs,sensorFs.magUpdateFs,sensorFs.gpsUpdateFs,sensorFs.baroUpdateFs,sensorFs.radarUpdateFs,...
                X0_marg22,ALGO_SET.P0_marg22,fs,refloc,ALGO_SET.noise_std.std_acc,ALGO_SET.noise_std.std_acc_bias,ALGO_SET.noise_std.std_alt,ALGO_SET.noise_std.std_gpsvel,...
                ALGO_SET.noise_std.std_gyro,ALGO_SET.noise_std.std_gyro_bias,ALGO_SET.noise_std.std_mag,ALGO_SET.noise_std.std_mag_bias);
            filterRes.MARG.q(i,:) = quaternion(stateEst(1:4)');
            filterRes.MARG.pos(i,:) = stateEst(5:7);
            filterRes.MARG.vel(i,:) = stateEst(8:10);
            filterRes.MARG.dangle(i,:) = stateEst(11:13);
            filterRes.MARG.dvel(i,:) = stateEst(14:16);
            filterRes.MARG.mag(i,:) = stateEst(17:19);
            filterRes.MARG.dmag(i,:) = stateEst(20:22);
            filterRes.MARG.P(i,:) = stateCovarianceDiag;
            filterRes.MARG.innov(i,:) = innov;
            filterRes.MARG.RMAG_diag(i,:) = diag(Rmag_online);
            filterRes.MARG.RGPS_diag(i,:) = diag(Rgps_online);
        end
    end
    %
    if rem(i,floor(0.1*N)) == 0
        fprintf('\ttime: %.2f (s)\t\t%.0f%%\n',IN_SENSOR.IMU1.time(i),i/N*100);
    end
end

filterRes.MARG.euler = eulerd(filterRes.MARG.q,'ZYX','frame');
filterRes.AHRS10.euler = eulerd(filterRes.AHRS10.q,'ZYX','frame');
euler_errstate = eulerd(q_errstate,'ZYX','frame');
filterRes.IMU.euler = eulerd(filterRes.IMU.q,'ZYX','frame');
timeVector = (0:(N-1))/fs;
% 作图
plotOpt = setPlotOpt; % 设置plot属性
stepSpace = 1;
if filterOpt.enable.marg
    filterTemp = filterRes.MARG;
    filterTemp.eulerd = eulerd(filterTemp.q,'ZYX','frame');
    filterTemp.lla = flat2lla(filterTemp.pos,refloc(1:2),0,-refloc(3));
    navFilterMARGRes(idx).Algo.time_algo = IN_SENSOR.IMU1.time;
    navFilterMARGRes(idx).Algo.algo_yaw = filterTemp.eulerd(:,1);
    navFilterMARGRes(idx).Algo.algo_pitch = filterTemp.eulerd(:,2);
    navFilterMARGRes(idx).Algo.algo_roll = filterTemp.eulerd(:,3);
    navFilterMARGRes(idx).Algo.algo_curr_pos_0 = filterTemp.lla(:,1);
    navFilterMARGRes(idx).Algo.algo_curr_pos_1 = filterTemp.lla(:,2);
    navFilterMARGRes(idx).Algo.algo_curr_pos_2 = filterTemp.lla(:,3);
    navFilterMARGRes(idx).Algo.algo_curr_vel_0 = filterTemp.vel(:,1);
    navFilterMARGRes(idx).Algo.algo_curr_vel_1 = filterTemp.vel(:,2);
    navFilterMARGRes(idx).Algo.algo_curr_vel_2 = filterTemp.vel(:,3);
    navFilterMARGRes(idx).Algo.dAB_00 = filterTemp.dvel(:,1)*fs;
    navFilterMARGRes(idx).Algo.dAB_11 = filterTemp.dvel(:,2)*fs;
    navFilterMARGRes(idx).Algo.dAB_22 = filterTemp.dvel(:,3)*fs;
    navFilterMARGRes(idx).Algo.dWB_00 = filterTemp.dangle(:,1)*fs*180/pi;
    navFilterMARGRes(idx).Algo.dWB_11 = filterTemp.dangle(:,2)*fs*180/pi;
    navFilterMARGRes(idx).Algo.dWB_22 = filterTemp.dangle(:,3)*fs*180/pi;
    navFilterMARGRes(idx).Algo.magB_x = filterTemp.mag(:,1);
    navFilterMARGRes(idx).Algo.magB_y = filterTemp.mag(:,2);
    navFilterMARGRes(idx).Algo.magB_z = filterTemp.mag(:,3);
    navFilterMARGRes(idx).Algo.dmagB_x = filterTemp.dmag(:,1);
    navFilterMARGRes(idx).Algo.dmagB_y = filterTemp.dmag(:,2);
    navFilterMARGRes(idx).Algo.dmagB_z = filterTemp.dmag(:,3);    
    navFilterMARGRes(idx).Algo.innov = filterTemp.innov;    
end
if filterOpt.enable.errorstate
    filterTemp = filterRes.ErrorState;
    filterTemp.eulerd = eulerd(filterTemp.q,'ZYX','frame');
    filterTemp.lla = flat2lla(filterTemp.pos,refloc(1:2),0,-refloc(3));
    navFilterErrorStateRes(idx).Algo.time_algo = measureData.imu_time;
    navFilterErrorStateRes(idx).Algo.algo_yaw = filterTemp.eulerd(:,1);
    navFilterErrorStateRes(idx).Algo.algo_pitch = filterTemp.eulerd(:,2);
    navFilterErrorStateRes(idx).Algo.algo_roll = filterTemp.eulerd(:,3);
    navFilterErrorStateRes(idx).Algo.algo_curr_pos_0 = filterTemp.lla(:,1);
    navFilterErrorStateRes(idx).Algo.algo_curr_pos_1 = filterTemp.lla(:,2);
    navFilterErrorStateRes(idx).Algo.algo_curr_pos_2 = filterTemp.lla(:,3);
    navFilterErrorStateRes(idx).Algo.algo_curr_vel_0 = filterTemp.vel(:,1);
    navFilterErrorStateRes(idx).Algo.algo_curr_vel_1 = filterTemp.vel(:,2);
    navFilterErrorStateRes(idx).Algo.algo_curr_vel_2 = filterTemp.vel(:,3);
    navFilterErrorStateRes(idx).Algo.dAB_00 = filterTemp.da(:,1);
    navFilterErrorStateRes(idx).Algo.dAB_11 = filterTemp.da(:,2);
    navFilterErrorStateRes(idx).Algo.dAB_22 = filterTemp.da(:,3);
    navFilterErrorStateRes(idx).Algo.dWB_00 = filterTemp.dw(:,1)*180/pi;
    navFilterErrorStateRes(idx).Algo.dWB_11 = filterTemp.dw(:,2)*180/pi;
    navFilterErrorStateRes(idx).Algo.dWB_22 = filterTemp.dw(:,3)*180/pi;
end
if filterOpt.enable.ahrs10
    filterTemp = filterRes.AHRS10;
    filterTemp.eulerd = eulerd(filterTemp.q,'ZYX','frame');
    navFilterAHRS10Res(idx).Algo.time_algo = measureData.imu_time;
    navFilterAHRS10Res(idx).Algo.algo_yaw = filterTemp.eulerd(:,1);
    navFilterAHRS10Res(idx).Algo.algo_pitch = filterTemp.eulerd(:,2);
    navFilterAHRS10Res(idx).Algo.algo_roll = filterTemp.eulerd(:,3);
    navFilterAHRS10Res(idx).Algo.dAB_00 = filterTemp.dvel(:,1)*fs;
    navFilterAHRS10Res(idx).Algo.dAB_11 = filterTemp.dvel(:,2)*fs;
    navFilterAHRS10Res(idx).Algo.dAB_22 = filterTemp.dvel(:,3)*fs;
    navFilterAHRS10Res(idx).Algo.dWB_00 = filterTemp.dangle(:,1)*fs*180/pi;
    navFilterAHRS10Res(idx).Algo.dWB_11 = filterTemp.dangle(:,2)*fs*180/pi;
    navFilterAHRS10Res(idx).Algo.dWB_22 = filterTemp.dangle(:,3)*fs*180/pi;
end