function [stateEst,stateCovarianceDiag,innov,Rmag_online,Rgps_online] = navigation_marg22(i,accel,gyro,mag,Rmag,lla,Rpos,gpsvel,Rvel,alt,Ralt,...
    imuUpdateFs,magUpdateFs,gpsUpdateFs,baroUpdateFs,radarUpdateFs,...
    X0_marg22,P0_marg22,fs,refloc,std_acc,std_acc_bias,std_alt,std_gpsvel,...
    std_gyro,std_gyro_bias,std_magNED,std_mag_bias)
global filter_marg 
if isempty(filter_marg)
    filter_marg = insfilterMARG;
    filter_marg.IMUSampleRate = fs;
    filter_marg.ReferenceLocation = refloc;
    filter_marg.State = X0_marg22;
    filter_marg.AccelerometerBiasNoise = std_acc_bias.^2;
    filter_marg.AccelerometerNoise = std_acc.^2;
    filter_marg.GyroscopeBiasNoise = std_gyro_bias.^2;
    filter_marg.GyroscopeNoise = std_gyro.^2;   
    filter_marg.MagnetometerBiasNoise = std_mag_bias.^2;
    filter_marg.GeomagneticVectorNoise = std_magNED.^2;
    filter_marg.StateCovariance = P0_marg22;    
end
filter_marg.predict(accel,gyro);  %
if rem(i,fs/magUpdateFs) == 0 && i ~= 1 % 磁力计更新
     filter_marg.fusemag(mag,Rmag);
end
if rem(i,fs/gpsUpdateFs) == 0 && i ~= 1 % gps 更新
    filter_marg.fusegps(lla,Rpos,gpsvel,Rvel);
end
if rem(i,fs/baroUpdateFs) == 0 && i ~= 1 % 气压高 更新
    idx_alt = 7; % 高度的状态序号
    posd = -alt;
    Rposd = Ralt;
    filter_marg.correct(idx_alt,posd,Rposd);
end
stateEst = filter_marg.State;
stateCovarianceDiag = diag(filter_marg.StateCovariance)';

innov_gps = zeros(1,6);
innov_mag = zeros(1,3);
if ~isempty(filter_marg.hGPSInnov)
    innov_gps = filter_marg.hGPSInnov';
end
if ~isempty(filter_marg.hMagInnov)
    innov_mag = filter_marg.hMagInnov';
end
innov = [innov_mag,innov_gps];
Rmag_online = filter_marg.RMag_online;
Rgps_online = filter_marg.RGPS_online;

