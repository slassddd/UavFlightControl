function [stateEst,stateCovarianceDiag] = navigation_errorstate17(i,accel,gyro,mag,Rmag,lla,Rpos,gpsvel,Rvel,...
    imuUpdateFs,magUpdateFs,gpsUpdateFs,baroUpdateFs,radarUpdateFs,...
    X0_errorstate17,P0_errorstate17,fs,refloc,std_acc,std_acc_bias,std_alt,std_gpsvel,...
    std_gyro,std_gyro_bias,std_mag,std_mag_bias)
global filter_errorstate
if isempty(filter_errorstate)
    filter_errorstate = insfilterErrorState;
    filter_errorstate.IMUSampleRate = fs;
    filter_errorstate.ReferenceLocation = refloc;
    filter_errorstate.State = X0_errorstate17;
    filter_errorstate.AccelerometerBiasNoise = std_acc_bias.^2;
    filter_errorstate.AccelerometerNoise = std_acc.^2;
    filter_errorstate.GyroscopeBiasNoise = std_gyro_bias.^2;
    filter_errorstate.GyroscopeNoise = std_gyro.^2;
    filter_errorstate.StateCovariance = P0_errorstate17;
end
filter_errorstate.predict(accel,gyro);  %
if rem(i,fs/gpsUpdateFs) == 0 && i ~= 1 % gps ¸üÐÂ
    filter_errorstate.fusegps(lla,Rpos,gpsvel,Rvel);
end
stateEst = filter_errorstate.State;
stateCovarianceDiag = diag(filter_errorstate.StateCovariance)';