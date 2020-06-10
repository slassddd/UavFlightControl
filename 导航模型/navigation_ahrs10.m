function [stateEst,stateCovarianceDiag] = navigation_ahrs10(i,accel,gyro,mag,Rmag,lla,Rpos,gpsvel,Rvel,...
    imuUpdateFs,magUpdateFs,gpsUpdateFs,baroUpdateFs,radarUpdateFs,...
    X0_ahrs10,P0_ahrs10,fs,refloc,std_acc,std_acc_bias,std_alt,std_gpsvel,...
    std_gyro,std_gyro_bias,std_magNED,std_mag_bias)
global filter_ahrs10
if isempty(filter_ahrs10)
    filter_ahrs10 = ahrs10filter;
    filter_ahrs10.IMUSampleRate = fs;
    filter_ahrs10.State = X0_ahrs10;
    filter_ahrs10.AccelerometerBiasNoise = std_acc_bias.^2;
    filter_ahrs10.AccelerometerNoise = std_acc.^2;
    filter_ahrs10.GyroscopeBiasNoise = std_gyro_bias.^2;
    filter_ahrs10.GyroscopeNoise = std_gyro.^2;
    filter_ahrs10.MagnetometerBiasNoise = std_mag_bias.^2;
    filter_ahrs10.GeomagneticVectorNoise = std_magNED.^2;
    filter_ahrs10.StateCovariance = P0_ahrs10;
end
filter_ahrs10.predict(accel,gyro);  %
if rem(i,fs/magUpdateFs) == 0 && i ~= 1
    filter_ahrs10.fusemag(mag,Rmag);
end
if rem(i,fs/baroUpdateFs) == 0 && i ~= 1 % 更新
    %     filter_ahrs10.fusealtimeter(alt,Ralt); % 高度输入是向下为正，输出是向上为正
end
stateEst = filter_ahrs10.State;
stateCovarianceDiag = diag(filter_ahrs10.StateCovariance)';
