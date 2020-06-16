function writeDataForNavSim(sensors,filterdata,fileName)
dotIdx = strfind(fileName,'.');
temp = fileName(1:dotIdx-1);
flagIdx = strfind(temp,'\');
tempName = '日志数据';
saveFileName = [temp(1:flagIdx),'仿真用的数据_',temp(flagIdx+1:end),'.mat'];
saveFileName = strrep(saveFileName,tempName,'');
navdata.time = sensors.Algo.time_algo;
navdata.ts = round(mean(navdata.time(100:200)-navdata.time(99:199)),3);
navdata.fs = round(1/navdata.ts,3);
navdata.eulerd = [sensors.Algo.algo_yaw,sensors.Algo.algo_pitch,sensors.Algo.algo_roll];
navdata.lla = [sensors.Algo.algo_curr_pos_0,sensors.Algo.algo_curr_pos_1,sensors.Algo.algo_curr_pos_2];
navdata.gpsvel = [sensors.Algo.algo_curr_vel_0,sensors.Algo.algo_curr_vel_1,sensors.Algo.algo_curr_vel_2];
navdata.dAB = [sensors.Algo.dAB_00,sensors.Algo.dAB_11,sensors.Algo.dAB_22];
navdata.dWB = [sensors.Algo.dWB_00,sensors.Algo.dWB_11,sensors.Algo.dWB_22];
% sensors.Mag.time_mag = sensors.Mag.time_mag - rem(sensors.Mag.time_mag,1/sensors.Mag.fs);
% sensors.Mag.time_mag = sensors.Mag.time_mag - rem(sensors.Mag.time_mag,1/sensors.Mag.fs);
% t_all0 = [imu_time(1),mag_time(1),gps_time(1),alt_time(1),radar_time(1),algo_time(1)];
% t_allf = [imu_time(end),mag_time(end),gps_time(end),alt_time(end),radar_time(end),algo_time(end)];
save(saveFileName,'sensors','filterdata','navdata')