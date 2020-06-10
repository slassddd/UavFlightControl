function [filterdata,calibParam] = calSensorFilterData(sensors,filterName)
%% ??2：
filterdata = sensors;
% matlabo．┷y??2：
%% IMU
fs = sensors.IMU.fs;
fpass = 10;
data = [sensors.IMU.gx,sensors.IMU.gy,sensors.IMU.gz];
filterdata.IMU.time_imu = sensors.IMU.time_imu;
temp = datafilter(filterName,data,fpass,fs);
filterdata.IMU.gx = temp(:,1);
filterdata.IMU.gy = temp(:,2);
filterdata.IMU.gz = temp(:,3);
 
calibParam.IMU.g_bias = mean(temp);
calibParam.IMU.g_std = std(temp);
[calibParam.IMU.g_allanvar,calibParam.IMU.g_tau] = allanvar(temp,'octave',fs);
 
data_Acc = [sensors.IMU.ax,sensors.IMU.ay,sensors.IMU.az];
temp = datafilter(filterName,data_Acc,fpass,fs);
filterdata.IMU.ax = temp(:,1);
filterdata.IMU.ay = temp(:,2);
filterdata.IMU.az = temp(:,3);
 
calibParam.IMU.a_bias = mean(temp);
calibParam.IMU.a_std = std(temp);
[calibParam.IMU.a_allanvar,calibParam.IMU.a_tau] = allanvar(temp,'octave',fs);
%     % simulink??2：
%     Ts = 1/fs;
%     simGyro.signals.values = data_Gyro;
%     simGyro.time = time;
%     simGyro.signals.dimensions = 3;
%% Mag1 Mag2 Mag3
fs = sensors.Mag.fs;
fpass = 10;
data = [sensors.Mag.mag1_x,sensors.Mag.mag1_y,sensors.Mag.mag1_z];
filterdata.Mag.time_mag = sensors.Mag.time_mag;
dataFilterd = datafilter(filterName,data,fpass,fs);
filterdata.Mag.mag1_x = dataFilterd(:,1);
filterdata.Mag.mag1_y = dataFilterd(:,2);
filterdata.Mag.mag1_z = dataFilterd(:,3);
data = [sensors.Mag.mag2_x,sensors.Mag.mag2_y,sensors.Mag.mag2_z];
filterdata.Mag.time_mag = sensors.Mag.time_mag;
dataFilterd = datafilter(filterName,data,fpass,fs);
filterdata.Mag.mag2_x = dataFilterd(:,1);
filterdata.Mag.mag2_y = dataFilterd(:,2);
filterdata.Mag.mag2_z = dataFilterd(:,3);
data = [sensors.Mag.mag3_x,sensors.Mag.mag3_y,sensors.Mag.mag3_z];
filterdata.Mag.time_mag = sensors.Mag.time_mag;
dataFilterd = datafilter(filterName,data,fpass,fs);
filterdata.Mag.mag3_x = dataFilterd(:,1);
filterdata.Mag.mag3_y = dataFilterd(:,2);
filterdata.Mag.mag3_z = dataFilterd(:,3);
 
calibParam.Mag.mag1_bias = mean(dataFilterd);
calibParam.Mag.mag1_std = std(dataFilterd);
[calibParam.Mag.mag1_allanvar,calibParam.Mag.mag1_tau] = allanvar(dataFilterd,'octave',fs);
 
%% GPS
% pos
fs = sensors.GPS.fs;
fpass = 10;
data = [sensors.GPS.posmNED];
sensors.GPS.time_ublox = sensors.GPS.time_ublox;
dataFilterd = datafilter(filterName,data,fpass,fs);
sensors.GPS.posmNED = dataFilterd;
 
calibParam.GPS.pos_bias = mean(dataFilterd);
calibParam.GPS.pos_std = std(dataFilterd);
% GPS LLA
data = [sensors.GPS.ublox_lat,sensors.GPS.ublox_lon,sensors.GPS.ublox_height];
sensors.GPS.time_ublox = sensors.GPS.time_ublox;
dataFilterd = datafilter(filterName,data,fpass,fs);
sensors.GPS.ublox_lat = dataFilterd(:,1);
sensors.GPS.ublox_lon = dataFilterd(:,2);
sensors.GPS.ublox_height = dataFilterd(:,3);
 
calibParam.GPS.lla_bias = mean(dataFilterd);
calibParam.GPS.lla_std = std(dataFilterd);
% GPS vel
data = [sensors.GPS.ublox_velN,sensors.GPS.ublox_velE,sensors.GPS.ublox_velD];
sensors.GPS.time_ublox = sensors.GPS.time_ublox;
dataFilterd = datafilter(filterName,data,fpass,fs);
sensors.GPS.ublox_velN = dataFilterd(:,1);
sensors.GPS.ublox_velE = dataFilterd(:,2);
sensors.GPS.ublox_velD = dataFilterd(:,3);
 
calibParam.GPS.vel_bias = mean(dataFilterd);
calibParam.GPS.vel_std = std(dataFilterd);
%% Baro
fs = sensors.Baro.fs;
fpass = 10;
data = [sensors.Baro.altitue];
sensors.Baro.time_baro = sensors.Baro.time_baro;
dataFilterd = datafilter(filterName,data,fpass,fs);
sensors.Baro.altitue = dataFilterd(:,1);
 
calibParam.Baro.alt_bias = mean(dataFilterd);
calibParam.Baro.alt_std = std(dataFilterd);
%% Radar
fs = sensors.Radar.fs;
fpass = 10;
data = [sensors.Radar.radar_Range];
sensors.Radar.time_radar = sensors.Radar.time_radar;
dataFilterd = datafilter(filterName,data,fpass,fs);
sensors.Radar.radar_Range = dataFilterd(:,1);
 
calibParam.Radar.range_bias = mean(dataFilterd);
calibParam.Radar.range_std = std(dataFilterd);
