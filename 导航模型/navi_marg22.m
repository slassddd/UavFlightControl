function [stateEst,stateCovarianceDiagEst,eulerd,lla_out,innov,stepInfo,OUT_ECAS] = navi_marg22(...
    Ts,X0_marg22,refloc,clock_sec,Sensors, SensorSignalIntegrity,IN_ECAS, MARGParam, um482_BESTPOS,isBadAttitude,TaskMode)
persistent filter_marg accel_pre gyro_pre mag_pre lla_pre gpsvel_pre alt_pre range_pre meanAcc meanGyro meanMag timeUpdate_ublox timeUpdate_um482
persistent step step_imu step_mag step_ublox step_alt step_radar step_baro step_board
persistent dHeight_GPS_sub_Baro
persistent ublox1_resReject_num um482_resReject_num mag_resReject_num
persistent staticTime
persistent magRejectForEver
persistent pDTime
persistent preTaskMode
%%
OUT_ECAS = IN_ECAS;
%% 传感器数据构造
IMU1_accel = double([Sensors.IMU1.accel_x, Sensors.IMU1.accel_y, Sensors.IMU1.accel_z]);
IMU2_accel = double([Sensors.IMU2.accel_x, Sensors.IMU2.accel_y, Sensors.IMU2.accel_z]);
IMU3_accel = double([Sensors.IMU3.accel_x, Sensors.IMU3.accel_y, Sensors.IMU3.accel_z]);
IMU1_gyro = double([Sensors.IMU1.gyro_x, Sensors.IMU1.gyro_y, Sensors.IMU1.gyro_z]);
IMU2_gyro = double([Sensors.IMU2.gyro_x, Sensors.IMU2.gyro_y, Sensors.IMU2.gyro_z]);
IMU3_gyro = double([Sensors.IMU3.gyro_x, Sensors.IMU3.gyro_y, Sensors.IMU3.gyro_z]);
mag1 = double([Sensors.mag1.mag_x, Sensors.mag1.mag_y, Sensors.mag1.mag_z]);
mag2 = double([Sensors.mag2.mag_x, Sensors.mag2.mag_y, Sensors.mag2.mag_z]);
ublox1_lla = double([Sensors.ublox1.Lat, Sensors.ublox1.Lon, Sensors.ublox1.height]);
ublox1_gpsvel = double([Sensors.ublox1.velN, Sensors.ublox1.velE, Sensors.ublox1.velD]);
um482_lla = double([Sensors.um482.Lat, Sensors.um482.Lon, Sensors.um482.height]);
um482_gpsvel = double([Sensors.um482.velN, Sensors.um482.velE, Sensors.um482.velD]);
baro1_alt = double(Sensors.baro1.alt_baro);
radar1_range = double(Sensors.radar1.Range);
% IMU更新
if SensorSignalIntegrity.SensorSelect.IMU == 1
    imuUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.IMU1;
    accel = IMU1_accel;
    gyro = IMU1_gyro;
elseif SensorSignalIntegrity.SensorSelect.IMU == 2
    imuUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.IMU2;
    accel = IMU2_accel;
    gyro = IMU2_gyro;
elseif SensorSignalIntegrity.SensorSelect.IMU == 3
    imuUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.IMU3;
    accel = IMU3_accel;
    gyro = IMU3_gyro;
elseif SensorSignalIntegrity.SensorSelect.IMU == 0
    imuUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.IMU1 & SensorSignalIntegrity.SensorUpdateFlag.IMU2 & SensorSignalIntegrity.SensorUpdateFlag.IMU3;
    accel = (IMU1_accel+IMU2_accel+IMU3_accel)/3;
    gyro = (IMU1_gyro+IMU2_gyro+IMU3_gyro)/3;
else
    imuUpdateFlag = true;
    accelTemp = single([0,0,0]);
    gyroTemp = single([0,0,0]);
    error('IMU config error')
end
% Mag更新
if SensorSignalIntegrity.SensorSelect.Mag == 1
    magUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.mag1;
    mag = mag1;
elseif SensorSignalIntegrity.SensorSelect.Mag == 2
    magUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.mag2;
    mag = mag2;
elseif SensorSignalIntegrity.SensorSelect.Mag == 0
    magUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.mag1 & SensorSignalIntegrity.SensorUpdateFlag.mag2;
    mag = (mag1+mag2)/2;
else % 随便预置一个地磁矢量
    magUpdateFlag = false;
    mag = [1,0,0];
end
% GPS更新
ublox1UpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.ublox1;
um482UpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.um482;
% 气压高度计更新
alt = baro1_alt;
baroUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.baro1;
airspeedUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.airspeed1;
% 雷达高度计更新
range = radar1_range;
radarUpdateFlag = SensorSignalIntegrity.SensorUpdateFlag.radar1;
% 滤波更新频率：n表示测量数据变化n次后进行一次相应的滤波更新
kScale_imu = 1;
kScale_mag = 3;
kScale_baro = 3;
kScale_radar = 1;
kScale_ublox = 1;

baseFs = 1/Ts/kScale_imu;
%
if isempty(filter_marg)
    step = 1;
    step_imu = 1;
    step_mag = 1;
    step_ublox = 1;
    step_alt = 1;
    step_radar = 1;
    step_baro = 1;
    step_board = 1;
    filter_marg = NAV_MARG22;%insfilterMARG
    filter_marg.IMUSampleRate = double(baseFs);
    filter_marg.ReferenceLocation = refloc;filter_marg.ReferenceLocation(3) = 0;
    filter_marg.State = double(X0_marg22);
    filter_marg.AccelerometerBiasNoise = double(MARGParam.std_acc_bias.^2);
    filter_marg.AccelerometerNoise = double(MARGParam.std_acc.^2);
    filter_marg.GyroscopeBiasNoise = double(MARGParam.std_gyro_bias.^2);
    filter_marg.GyroscopeNoise = double(MARGParam.std_gyro.^2);
    filter_marg.MagnetometerBiasNoise = double(MARGParam.std_mag_bias.^2);
    filter_marg.GeomagneticVectorNoise = double(MARGParam.std_magNED.^2);
    %     if isBadAttitude
    MARGParam.P0_MARG(1:4) = [1,0.2,0.2,1];
    %     end
    filter_marg.StateCovariance = double(diag(MARGParam.P0_MARG));
    accel_pre = accel;
    gyro_pre = gyro;
    mag_pre = mag;
    lla_pre = ublox1_lla;
    gpsvel_pre = ublox1_gpsvel;
    alt_pre = alt;
    range_pre = range;
    meanAcc = single([0,0,0]);
    meanGyro = single([0,0,0]);
    meanMag = single([0,0,0]);
    
    dHeight_GPS_sub_Baro = ublox1_lla(3) - baro1_alt;
    
    ublox1_resReject_num = 0;
    um482_resReject_num = 0;
    mag_resReject_num = 0;
    
    staticTime = 0;
    magRejectForEver = false;
    timeUpdate_ublox = clock_sec;
    timeUpdate_um482 = clock_sec;
    
    pDTime = 0;
    
    preTaskMode = TaskMode;
end
%% 测量协方差
Rmag = double(diag(MARGParam.std_mag.^2));
Rpos = double(diag(MARGParam.std_lla.^2));
Rvel = double(diag(MARGParam.std_gpsvel.^2));
Rpos_um482 = double(diag(MARGParam.std_lla_um482.^2));
Rvel_um482 = double(diag(MARGParam.std_gpsvel_um482.^2));
Ralt = double(MARGParam.std_alt^2);
Rrange = double(MARGParam.std_range^2);
%% ublox测量精度
posVec = [Sensors.ublox1.hAcc,Sensors.ublox1.hAcc,Sensors.ublox1.vAcc];
velVec = Sensors.ublox1.sAcc*ones(1,3);
for i = 1:3
    if posVec(i) < MARGParam.std_lla(i)
        posVec(i) = MARGParam.std_lla(i);
    end
    if velVec(i) < MARGParam.std_gpsvel(i)
        velVec(i) = MARGParam.std_gpsvel(i);
    end
end
Rpos = diag(posVec.^2);
Rvel = double(diag(velVec.^2));
%% 测量值拒绝 （注意：判断上限值应该 包容最大运动能力，下限值应该小于噪声影响）
maxSpeed = 30;%30*dt_base;
% GPS位置跳变拒绝——判断是否异常跳变
posJumpThreshold = maxSpeed; % m
m2deg = 1e-5; % 1m vs 1e-5deg
measureReject.lla_notJump = ...
    abs(norm(lla_pre(1)-ublox1_lla(1))) < posJumpThreshold*m2deg || ...
    abs(norm(lla_pre(2)-ublox1_lla(2))) < posJumpThreshold*m2deg || ...
    abs(norm(lla_pre(3)-ublox1_lla(3))) < posJumpThreshold;
% 气压高度位置跳变拒绝——判断是否异常跳变
measureReject.baroAlt_notJump = ...
    abs(norm(alt_pre-alt)) < posJumpThreshold;
% 气压高度位置跳变拒绝——判断是否异常跳变
measureReject.range_notJump = ...
    abs(norm(range_pre-range)) < posJumpThreshold;
%% 残差拒绝
% ublox1
[res_ublox1, resCov_ublox1] = residualgps(filter_marg, double(ublox1_lla), ...
    double(Rpos), double(ublox1_gpsvel), double(Rvel));
normalizedRes_ublox1 = res_ublox1 ./ sqrt( diag(resCov_ublox1).' );
residual_ublox1 = any(abs(normalizedRes_ublox1(1:3))<6);
if ~residual_ublox1
    ublox1_resReject_num = ublox1_resReject_num + 1;
end
% um482
switch um482_BESTPOS
    case ENUM_BESTPOS.POS_SOLUTION_NARROW_INT % 高精度解
        sigmaLat = max(0.3,Sensors.um482.delta_lat);
        sigmaLon = max(0.3,Sensors.um482.delta_lon);
        sigmaAlt = max(0.3,Sensors.um482.delta_height);
    case ENUM_BESTPOS.POS_SOLUTION_NARROW_FLOATE
        sigmaLat = 1e1*max(0.8,Sensors.um482.delta_lat);
        sigmaLon = 1e1*max(0.8,Sensors.um482.delta_lon);
        sigmaAlt = 1e1*max(0.6,Sensors.um482.delta_height);
    otherwise % 其他可用解
        sigmaLat = max(0.6,Sensors.um482.delta_lat);
        sigmaLon = max(0.6,Sensors.um482.delta_lon);
        sigmaAlt = max(0.6,Sensors.um482.delta_height);
end
Rpos_um482 = double(diag([sigmaLat,sigmaLon,sigmaAlt]).^2);
if Sensors.um482.pDop > 1.4
    Rvel_um482 = double(Sensors.um482.pDop^1.5*Rvel_um482);
end
[res_um482, resCov_um482] = residualgps(filter_marg, double(um482_lla), ...
    double(Rpos_um482), double(um482_gpsvel), double(Rvel_um482));
normalizedRes_um482 = res_um482 ./ sqrt( diag(resCov_um482).' );
switch um482_BESTPOS
    case ENUM_BESTPOS.POS_SOLUTION_NARROW_INT % 高精度解
        residual_um482 = any(abs(normalizedRes_um482(1:3))<100);
    case ENUM_BESTPOS.POS_SOLUTION_SINGLE
        residual_um482 = any(abs(normalizedRes_um482(1:3))<10);
    case ENUM_BESTPOS.POS_SOLUTION_NONE
        residual_um482 = false;
    otherwise
        residual_um482 = any(abs(normalizedRes_um482(1:3))<100);
end
if ~residual_um482
    um482_resReject_num = um482_resReject_num + 1;
end
% mag
[res_mag, resCov_mag] = residualmag(filter_marg, double(mag), double(Rmag));
normalizedRes_mag = res_mag./ sqrt( diag(resCov_mag).' );
residual_mag = all( abs(normalizedRes_mag)<10 );
if ~residual_mag
    kScale_mag = 12;
else
    kScale_mag = 3;
    mag_resReject_num = mag_resReject_num + 1;
    if mag_resReject_num > 1e6 % 如果拒绝次数过多，则认定传感器失效，永久拒绝
        %         magRejectForEver = true;
    end
end
OUT_ECAS.nUbloxRejectByResidual = ublox1_resReject_num;
OUT_ECAS.nUm482RejectByResidual = um482_resReject_num;
OUT_ECAS.nMagRejectByResidual = mag_resReject_num;
%% 瞬时静止判定
stayStillCondition.acc = 1; % max(abs(accel(1:2)))<0.15; % m/s^2
stayStillCondition.gyro = max(gyro)<0.05; % rad
stayStillCondition.gpsvel = max(abs(ublox1_gpsvel))<0.2; % m/s
stayStillCondition.isStatic = false;
stayStillCondition.isStatic = stayStillCondition.acc && ...
    stayStillCondition.gyro && ...
    stayStillCondition.gpsvel;
ZVCenable = false;
if stayStillCondition.isStatic && MARGParam.enableZeroVelCorrect
    staticTime = staticTime + Ts;
    if staticTime > 2
        ZVCenable = true; % 零速校正使能
    end
else
    staticTime = 0;
end
%%
% persistent du_test
% if isempty(du_test)
%     du_test = 0;
% end
% if clock_sec > 1126
%     du_test = du_test + Ts;
%     MARGParam.fuse_enable.mag = 1;
%     MARGParam.fuse_enable.gps = 1;
%     MARGParam.fuse_enable.um482 = 1;
%     if du_test > 1
%         fprintf("disable mag/gps/um482 fusion\n");
%         du_test = 0;
%     end
% end
%% 滤波
disenable_time = clock_sec < 270 || clock_sec > inf;
disenable_time = true;

ublox1_is_available = ...
    SensorSignalIntegrity.SensorStatus.ublox1 == ENUM_SensorHealthStatus.Health || ...
    SensorSignalIntegrity.SensorStatus.ublox1 == ENUM_SensorHealthStatus.Degrade;
um482_is_available = ...
    SensorSignalIntegrity.SensorStatus.um482 == ENUM_SensorHealthStatus.Health || ...
    SensorSignalIntegrity.SensorStatus.um482 == ENUM_SensorHealthStatus.Degrade;
airspeed1_is_available = SensorSignalIntegrity.SensorStatus.airspeed1 == ENUM_SensorHealthStatus.Health;
% SensorUpdateFlag
% if imuUpdateFlag
step_imu = step_imu + 1;
temp_gyro = 3;
temp_acc = 3;
meanAcc = (temp_acc-1)/temp_acc*meanAcc+1/temp_acc*accel;
meanGyro = (temp_gyro-1)/temp_gyro*meanGyro+1/temp_gyro*gyro;
if rem(step_imu,kScale_imu) == 0
    if MARGParam.enableAccDegrade_Rotor2Fix && ...
            TaskMode == ENUM_FlightTaskMode.Rotor2Fix_Mode
        filter_marg.AccelerometerBiasNoise = 2e2*double(MARGParam.std_acc_bias.^2);
        filter_marg.AccelerometerNoise = 5*double(MARGParam.std_acc.^2);
    else
        filter_marg.AccelerometerBiasNoise = double(MARGParam.std_acc_bias.^2);
        filter_marg.AccelerometerNoise = double(MARGParam.std_acc.^2);
        if preTaskMode == ENUM_FlightTaskMode.Rotor2Fix_Mode && TaskMode ~= ENUM_FlightTaskMode.Rotor2Fix_Mode 
            fprintf('Rotor2Fix Complete!\n');
            filter_marg.State(14:16) = 0.1*filter_marg.State(14:16); % 加计零偏重置
        end
    end
    filter_marg.GyroscopeBiasNoise = double(MARGParam.std_gyro_bias.^2);
    filter_marg.GyroscopeNoise = double(MARGParam.std_gyro.^2);
    %     if ublox1_is_available
    %         tmpK_residual = abs(normalizedRes_ublox1(4:6)).^1.5;
    %         tmpK_residual(tmpK_residual<1) = 1;
    %     else
    %         tmpK_residual = [1,1,1];
    %     end
    tmpK_residual = [1,1,1];
    for ii = 3
        if ii == 3
            tmpK_bias = max(1,(abs(abs(meanAcc(ii))-9.8)/1)^1.5);
            tmpK = max(1,(abs(abs(meanAcc(ii))-9.8)/1)^3);
        else
            tmpK_bias = max(1,abs(meanAcc(ii))^1.5);
            tmpK = max(1,abs(meanAcc(ii))^3);
        end
%         fprintf('tmpK_bias: %f\ttmpK: %f\n',tmpK_bias,tmpK);
        filter_marg.AccelerometerBiasNoise(ii) = tmpK_residual(ii)*tmpK_bias*filter_marg.AccelerometerBiasNoise(ii);
        filter_marg.AccelerometerNoise(ii) = tmpK_residual(ii)*tmpK*filter_marg.AccelerometerNoise(ii);
    end
    for ii = 1:3
        tmpK = (1+abs(meanGyro(ii)))^2;
        filter_marg.GyroscopeBiasNoise = tmpK*double(MARGParam.std_gyro_bias.^2);
        filter_marg.GyroscopeNoise = tmpK*double(MARGParam.std_gyro.^2);
    end
    fuseAcc = meanAcc;
    fuseGyro = meanGyro;
    filter_marg.predict(double(fuseAcc),double(fuseGyro));  %
end
% 磁力计融合
if disenable_time && residual_mag && ~magRejectForEver && magUpdateFlag && MARGParam.fuse_enable.mag % mag 更新
    % if ~magRejectForEver && magUpdateFlag && MARGParam.fuse_enable.mag % mag 更新
    step_mag = step_mag + 1;
    if rem(step_mag,kScale_mag) == 0 % && alt < 5
        filter_marg.fusemag(double(mag),double(Rmag));
    end
    %% 利用磁力计/加计计算粗姿态辅助更新姿态四元数，防止初始化过程造成的一些问题
    enableMagQuatFuse = false;
    if enableMagQuatFuse && ... % 使能
            stayStillCondition.isStatic && ... % 静态
            SensorSignalIntegrity.SensorStatus.ublox1 == ENUM_SensorHealthStatus.Health % && ...% 磁力计健康
        %             (~ublox1_is_available && ~um482_is_available) % gps都是小
        quat = compact(ecompass(double(meanAcc),double(mag)));
        for i_q = 1:4
            Rq = 0.05^2;
            filter_marg.correct(i_q,quat(i_q),Rq);
        end
    end
end
% ublox1融合
if disenable_time && ublox1_is_available && measureReject.lla_notJump && ...
        ublox1UpdateFlag && MARGParam.fuse_enable.gps
    step_ublox = step_ublox + 1;
    if ~ZVCenable
        if rem(step_ublox,kScale_ublox) == 0
            filter_marg.fusegps(double(ublox1_lla),double(Rpos),double(ublox1_gpsvel),double(Rvel));
        end
    else
        %         Rvel = 1e-1*double(Sensors.ublox1.pDop*Rvel);
        %         Rpos = 1e0*double(Sensors.ublox1.pDop*Rpos);
        if rem(step_ublox,kScale_ublox) == 0
            filter_marg.fusegps(double(ublox1_lla),double(Rpos),[0,0,0],double(Rvel));
        end
    end
end
% um482融合
%  && residual_um482
if disenable_time && MARGParam.fuse_enable.um482 && um482_is_available && ...
        um482UpdateFlag && ...% gps 更新
        um482_BESTPOS ~= ENUM_BESTPOS.POS_SOLUTION_NONE && ...% 无解
        Sensors.um482.pDop ~= 0 % um482在受强干扰时pDop会置0
    filter_marg.fusegps(double(um482_lla),double(Rpos_um482),double(um482_gpsvel),double(Rvel_um482));
end
% 雷达高融合
if false && radarUpdateFlag && measureReject.range_notJump  %
    step_radar = step_radar + 1;
    if rem(step_radar,kScale_radar) == 0
        idx_alt = 7; % 高度的状态序号
        posd = -range-dHeight_GPS_sub_Baro;
        Rposd = Rrange;
        filter_marg.correct(idx_alt,double(posd),double(Rposd));
    end
end
% 气压高融合
isFuseBaroAlt = baroUpdateFlag && measureReject.baroAlt_notJump && MARGParam.fuse_enable.alt && ...% 当ublox失效且baro正常时执行
    MARGParam.fuse_enable.gps && ...
    ~ublox1_is_available && ...
    ~um482_is_available;
if isFuseBaroAlt
    step_baro = step_baro + 1;
    step_alt = step_alt + 1;
    if rem(step_baro,kScale_baro) == 0
        idx_alt = 7; % 高度的状态序号
        posd = -alt-dHeight_GPS_sub_Baro;
        Rposd = Ralt;
        filter_marg.correct(idx_alt,double(posd),double(Rposd));
    end
end
% 空速融合
if true && airspeedUpdateFlag && ...
        airspeed1_is_available && ...
        ~ublox1_is_available && ...
        ~um482_is_available % || clock_sec >= 700% || clock_sec >= 700
    % 当GPS失效时，引入空速，抑制融合速度的漂移
    tempLLA = filter_marg.ReferenceLocation;
    Rvel_airspeed = diag([7,7,25]).^2;
    stateEst = filter_marg.State;
    euler_rad = double (euler(stateEst(1:4)));
    yaw = euler_rad(1) + 5*randn/3/57.3;
    pitch = euler_rad(2);
    DCMbe = [cos(pitch) 0 -sin(pitch);0 1 0;sin(pitch) 0 cos(pitch)]*[cos(yaw) sin(yaw) 0;-sin(yaw) cos(yaw) 0;0 0 1]; % NED到Body的坐标转换矩阵
    DCMeb = DCMbe'; % Body到NED的坐标转换矩阵
    airspeed = Sensors.airspeed1.airspeed;
    vel_airspeed = (DCMeb*[airspeed;0;0])';
    filter_marg.fusegps(double(tempLLA),double(1e10),double(vel_airspeed),double(Rvel_airspeed));
end
%%
stateEst = [filter_marg.State;0;0];
if ~isFuseBaroAlt
    % 补偿平面坐标系造成的高度偏差
    distFromOri = norm(stateEst(5:6));
    R0 = 6378e3;
    H0 = norm([R0,distFromOri]);
    dH = H0 - R0;
    stateEst(7) = stateEst(7) - dH; % 高度处理
end
stateCovarianceDiagEst = [abs(diag(filter_marg.StateCovariance)).^0.5;0;0];
eulerd = double(euler(stateEst(1:4))*180/pi);
posNED = stateEst(5:7)';
% lla_out = flat2lla_codegen(posNED, refloc(1:2), 0, refloc(3));
lla_out = flat2lla_codegen(posNED, refloc(1:2), 0, 0); % href: flat的高度基准，向下为正
fuseVdWithEKFandGPS = MARGParam.enableVdFuser;

% if clock_sec > 1500
%     sl = 1;
% end
if true && fuseVdWithEKFandGPS && ...
        (SensorSignalIntegrity.SensorStatus.ublox1 == ENUM_SensorHealthStatus.Health && range > 8)
    k = max(1,abs(accel(3)-9.8));
    temp = min(0.2,1/k^0.8);
    if SensorSignalIntegrity.SensorStatus.ublox1 == ENUM_SensorHealthStatus.Health
        if ublox1UpdateFlag
            thisTime = clock_sec;
            dTime = thisTime - timeUpdate_ublox;
            timeUpdate_ublox = thisTime;
            kDTime = 0.9;
            pDTime = kDTime*pDTime + (1-kDTime)*dTime;
            %             [pDTime,dTime]
        end
        if pDTime < 0.25 % 更新率低时不进行平滑
            fuseVd = temp*stateEst(10) + (1-temp)*ublox1_gpsvel(3);
            stateEst(10) = fuseVd;
        end
        %     elseif SensorSignalIntegrity.SensorStatus.um482 == ENUM_SensorHealthStatus.Health
        %         if um482UpdateFlag
        %             fuseVd = temp*stateEst(10) + (1-temp)*um482_gpsvel(3);
        %             stateEst(10) = fuseVd;
        %         end
    end
end
accel_pre = accel;
gyro_pre = gyro;
mag_pre = mag;
lla_pre = ublox1_lla;
gpsvel_pre = ublox1_gpsvel;
alt_pre = alt;
range_pre = range;
innov.ublox1 = normalizedRes_ublox1;
innov.um482 = normalizedRes_um482;
innov.mag = normalizedRes_mag;
innov.baro = 0;
innov.radar = 0;
step = step + 1;
stepInfo.step = step;
stepInfo.step_imu = step_imu;
stepInfo.step_mag = step_mag;
stepInfo.step_ublox = step_ublox;
stepInfo.step_alt = step_alt;
stepInfo.step_radar = step_radar;
stepInfo.step_baro = step_baro;
stepInfo.step_board = step_board;

preTaskMode = TaskMode;
end
%% 子函数
function eout = euler(quat)
% rotate 'ZYX'
qa = quat(1);
qb = quat(2);
qc = quat(3);
qd = quat(4);
the1 = single(1);
the2 = single(2);

tmp = qb.*qd.*the2 - qa.*qc.*the2;
if tmp > the1
    tmp = the1;
elseif tmp < -the1
    tmp = -the1;
end
% tmp(tmp > the1) = the1;
% tmp(tmp < -the1) = -the1;
b = -asin(tmp);
a = atan2((qa.*qd.*the2 + qb.*qc.*the2),(qa.^2.*the2 - the1 + qb.^2.*the2));
c = atan2((qa.*qb.*the2 + qc.*qd.*the2),(qa.^2.*the2 - the1 + qd.^2.*the2));
eout = [a b c];
end

function lla = flat2lla_codegen(p, ll0, psi0, href)
lla = zeros(1,3);
R = 6378.137e3;
f = 0.003352810664747;
%     % wrap latitude and longitude if needed
%     [~, ll0(1), ll0(2)] = wraplatitude( ll0(1), ll0(2), 'deg' );
%
%     % check and fix angle wrapping in longitude
%     [~, ll0(2)] = wraplongitude( ll0(2), 'deg', '180' );

rll0 = ll0*pi/180;
rpsi0 = psi0*pi/180;

dNorth = cos(rpsi0)*p(:,1) - sin(rpsi0)*p(:,2);
dEast  = sin(rpsi0)*p(:,1) + cos(rpsi0)*p(:,2);
lla(:,3) = -p(:,3) - href;

Rn = R/sqrt(1-(2*f-f*f)*sin(rll0(1))*sin(rll0(1)));
Rm = Rn*((1-(2*f-f*f))/(1-(2*f-f*f)*sin(rll0(1))*sin(rll0(1))));

dLat = dNorth.*atan2(1,Rm);
dLon = dEast.*atan2(1,Rn*cos(rll0(1)));

lla(:,1) = dLat*180/pi + ll0(1);
lla(:,2) = dLon*180/pi + ll0(2);

%     % wrap latitude and longitude if needed
%     [~, lla(:,1), lla(:,2)] = wraplatitude( lla(:,1)', lla(:,2)', 'deg' );
%
%     % check and fix angle wrapping in longitude
%     [~, lla(:,2)] = wraplongitude( lla(:,2), 'deg', '180' );
end