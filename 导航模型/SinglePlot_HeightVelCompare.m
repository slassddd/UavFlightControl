time_sl = sensors.IMU.time_imu(1:4:end);
idx_sel = [1:length(time_sl)];
% 高度
fig = figure;
fig.Name = '高度、速度对比';
subplot(121)
altHome0 = -243;
plot(IN_SENSOR.um482.time,IN_SENSOR.um482.height,'r');hold on;
plot(IN_SENSOR.baro1.time,IN_SENSOR.baro1.alt_baro,'k');hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range,'b');hold on;
plot(navFilterMARGRes.Algo.time_algo,-out(i_sim).NavFilterRes.state.Data(:,7),'--');hold on;
plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_alt(idx_sel),'r--');hold on;
%             ylim([-15,100])
legend('gps','气压','雷达','融合（离线）','融合（在线）')
grid on;
xlabel('time(s)')
ylabel('高度(m)')
% 速度
subplot(122)
plot(sensors.GPS.time_ublox,sensors.GPS.ublox_velD,'r');hold on;
plot(navFilterMARGRes.Algo.time_algo,out(i_sim).NavFilterRes.state.Data(:,10),'k-');hold on;
plot(sensors.IMU.time_imu(1:4:end),sensors.Algo_sl.algo_NAV_Vd(idx_sel),'b-');hold on;
% plot(sensors.Algo.time_algo,-sensors.Algo.algo_curr_vel_2,'c');hold on;
legend('gps','融合（离线）','融合（在线）','王博')
grid on;
xlabel('time(s)')
ylabel('速度(m)')