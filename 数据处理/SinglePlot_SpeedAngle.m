time = FlightLog_Original.Filter.time_cal;
velHeading = atan2(FlightLog_Original.Filter.algo_NAV_Ve,FlightLog_Original.Filter.algo_NAV_Vn)*180/pi;
% velvector = [IN_SENSOR.ublox1.velN,IN_SENSOR.ublox1.velE,IN_SENSOR.ublox1.velD];
velvector = [FlightLog_Original.Filter.algo_NAV_Vn,FlightLog_Original.Filter.algo_NAV_Ve,FlightLog_Original.Filter.algo_NAV_Vd];
speedvector = vecnorm(velvector,2,2);
velElv = -asin(FlightLog_Original.Filter.algo_NAV_Vd./speedvector)*180/pi;
figure('Name','速度角');
subplot(221)
plot(time,velElv);hold on;
plot(time,FlightLog_Original.Filter.algo_NAV_pitchd);hold on;
legend('速度倾角[deg]','俯仰角[deg]')
grid on;
subplot(223)
alphavector = FlightLog_Original.Filter.algo_NAV_pitchd - velElv;
plot(time,alphavector);hold on;grid on;
ylabel('攻角[deg]')
subplot(122)
plot(time, velHeading,'r');hold on;
plot(time, FlightLog_Original.Filter.algo_NAV_yawd,'b');hold on;grid on;
legend('速度偏角[deg]','偏航角[deg]')