function sensors = run_timeCut(sensors)
imu_time = sensors.IMU.time_imu;

base_time = imu_time;
% mag
[sensors.Mag.time_mag,sensors.Mag.mag3_x,idx] = timeCut(base_time,sensors.Mag.time_mag,sensors.Mag.mag3_x);
sensors.Mag.mag3_y(idx) = [];
sensors.Mag.mag3_z(idx) = [];
sensors.Mag.mag1_x(idx) = [];
sensors.Mag.mag1_y(idx) = [];
sensors.Mag.mag1_z(idx) = [];
sensors.Mag.mag2_x(idx) = [];
sensors.Mag.mag2_y(idx) = [];
sensors.Mag.mag2_z(idx) = [];
sensors.Mag.mag1calib_x_magFrame(idx) = [];
sensors.Mag.mag1calib_y_magFrame(idx) = [];
sensors.Mag.mag1calib_z_magFrame(idx) = [];
sensors.Mag.mag2calib_x_magFrame(idx) = [];
sensors.Mag.mag2calib_y_magFrame(idx) = [];
sensors.Mag.mag2calib_z_magFrame(idx) = [];
% gps
[sensors.GPS.time_ublox,sensors.GPS.posmNED,idx] = timeCut(base_time,sensors.GPS.time_ublox,sensors.GPS.posmNED);
sensors.GPS.ublox_lat(idx) = [];
sensors.GPS.ublox_lon(idx) = [];
sensors.GPS.ublox_height(idx) = [];
sensors.GPS.ublox_velN(idx) = [];
sensors.GPS.ublox_velE(idx) = [];
sensors.GPS.ublox_velD(idx) = [];
sensors.GPS.ublox_iTOW(idx) = [];
sensors.GPS.ublox_numSV(idx) = [];
sensors.GPS.ublox_pDOP(idx) = [];
% baro
[sensors.Baro.time_baro,sensors.Baro.altitue,idx] = timeCut(base_time,sensors.Baro.time_baro,sensors.Baro.altitue);
sensors.Baro.pressure(idx) = [];
sensors.Baro.pressure_gs(idx) = [];
sensors.Baro.temperature(idx) = [];
sensors.Baro.temperature_gs(idx) = [];
% radar
[sensors.Radar.time_radar,sensors.Radar.radar_Range,idx] = timeCut(base_time,sensors.Radar.time_radar,sensors.Radar.radar_Range);
sensors.Radar.radar_Flag(idx) = [];
sensors.Radar.radar_SNR(idx) = [];
% alg
[sensors.Algo.time_algo,sensors.Algo.algo_yaw,idx] = timeCut(base_time,sensors.Algo.time_algo,sensors.Algo.algo_yaw);
sensors.Algo.algo_pitch(idx) = [];
sensors.Algo.algo_roll(idx) = [];
sensors.Algo.algo_curr_pos_0(idx) = [];
sensors.Algo.algo_curr_pos_1(idx) = [];
sensors.Algo.algo_curr_pos_2(idx) = [];
sensors.Algo.algo_curr_alt(idx) = [];
sensors.Algo.algo_curr_vel_0(idx) = [];
sensors.Algo.algo_curr_vel_1(idx) = [];
sensors.Algo.algo_curr_vel_2(idx) = [];
sensors.Algo.dAB_00(idx) = [];
sensors.Algo.dAB_11(idx) = [];
sensors.Algo.dAB_22(idx) = [];
sensors.Algo.dWB_00(idx) = [];
sensors.Algo.dWB_11(idx) = [];
sensors.Algo.dWB_22(idx) = [];