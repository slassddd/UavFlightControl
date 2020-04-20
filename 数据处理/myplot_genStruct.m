%% 生成结构图
% ------- IMU ---------
data = data_imu_txt; 
header = 'sensors(i_file).IMU';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
% ------- Baro ---------
data = data_baro_txt; 
header = 'sensors(i_file).Baro';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
% ------- Baro ---------
data = data_mag_txt; 
header = 'sensors(i_file).Mag';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
% ------- Radar ---------
data = data_radar_txt; 
header = 'sensors(i_file).Radar';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
% ------- GPS ---------
data = data_ublox_txt; 
header = 'sensors(i_file).GPS';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
data = [sensors(i_file).GPS.ublox_lat,sensors(i_file).GPS.ublox_lon,sensors(i_file).GPS.ublox_height];
data0 = data(1,:);
sensors(i_file).GPS.posmNED = lla2flat(data,data0(1:2),0,0);
% ------- 算法 ---------
data = data_ck_txt; 
header = 'sensors(i_file).Algo';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
data = [sensors(i_file).Algo.algo_curr_pos_0,sensors(i_file).Algo.algo_curr_pos_1,sensors(i_file).Algo.algo_curr_pos_2];
data0 = data(1,:);
sensors(i_file).Algo.posmNED = lla2flat(data,data0(1:2),0,0);
% ------- sl算法 ---------
data = data_slalgo_txt; 
header = 'sensors(i_file).Algo_sl';
for i_child = 1:length(data)
    childName = data{i_child};
    str = sprintf('%s.%s = %s;',header,childName,childName);
    eval(str);
end
data = [sensors(i_file).Algo_sl.algo_NAV_lat,sensors(i_file).Algo_sl.algo_NAV_lon,sensors(i_file).Algo_sl.algo_NAV_alt];
data0 = data(1,:);
sensors(i_file).Algo_sl.posmNED = lla2flat(data,data0(1:2),0,0);
%%
idx_start = 30;
sensors(i_file).IMU.ts = mean(time_imu(idx_start:end,:)-time_imu(idx_start-1:end-1,:));
sensors(i_file).GPS.ts = mean(time_ublox(idx_start:end,:)-time_ublox(idx_start-1:end-1,:));
sensors(i_file).Baro.ts = mean(time_baro(idx_start:end,:)-time_baro(idx_start-1:end-1,:));
sensors(i_file).Mag.ts = mean(time_mag(idx_start:end,:)-time_mag(idx_start-1:end-1,:));
sensors(i_file).Radar.ts = mean(time_radar(idx_start:end,:)-time_radar(idx_start-1:end-1,:));
sensors(i_file).IMU.fs = 1/sensors(i_file).IMU.ts;
sensors(i_file).GPS.fs = 1/sensors(i_file).GPS.ts;
sensors(i_file).Baro.fs = 1/sensors(i_file).Baro.ts;
sensors(i_file).Mag.fs = 1/sensors(i_file).Mag.ts;
sensors(i_file).Radar.fs = 1/sensors(i_file).Radar.ts;

sensors(i_file) = run_timeCut(sensors(i_file)); 
if 0
    plot(sensors(i_file).Algo.time_algo,sensors(i_file).Algo.posmNED(:,1));hold on;plot(sensors(i_file).GPS.time_ublox,sensors(i_file).GPS.posmNED(:,1));hold on;
    plot(sensors(i_file).Algo.time_algo,sensors(i_file).Algo.algo_curr_pos_0,'r');hold on;plot(sensors(i_file).GPS.time_ublox,sensors(i_file).GPS.ublox_lat,'k');hold on;
end


 