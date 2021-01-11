% 高度
fig = figure;
fig.Name = '高度、速度对比';
subplot(121)
altHome0 = -243;
plot(IN_SENSOR.um482.time,IN_SENSOR.um482.height,'r');hold on;
plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.height,'c');hold on;
plot(IN_SENSOR.baro1.time,IN_SENSOR.baro1.alt_baro,'k');hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range,'b');hold on;
plot(navFilterMARGRes.Algo.time_algo,-out(i_sim).NavFilterRes.state.Data(:,7),'--');hold on;
plot(FlightLog_Original.Filter.time_cal,SL.Filter.algo_NAV_alt,'r--');hold on;
%             ylim([-15,100])
legend('um482','ublox','气压','雷达','融合（离线）','融合（在线）')
grid on;
xlabel('time(s)')
ylabel('高度(m)')
% 速度
subplot(122)
plot(IN_SENSOR.um482.time,IN_SENSOR.um482.velD,'r');hold on;
plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velD,'r--');hold on;
plot(navFilterMARGRes.Algo.time_algo,out(i_sim).NavFilterRes.state.Data(:,10),'k-');hold on;
plot(FlightLog_Original.Filter.time_cal,SL.Filter.algo_NAV_Vd,'b-');hold on;
legend('um482','ublox1','融合（离线）','融合（在线）')
grid on;
xlabel('time(s)')
ylabel('速度(m)')