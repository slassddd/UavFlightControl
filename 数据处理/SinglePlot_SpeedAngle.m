velHeading = atan2(IN_SENSOR.ublox1.velE,IN_SENSOR.ublox1.velN)*180/pi;
velvector = [IN_SENSOR.ublox1.velN,IN_SENSOR.ublox1.velE,IN_SENSOR.ublox1.velD];
speedvector = vecnorm(velvector,2,2);
velElv = -asin(IN_SENSOR.ublox1.velD./speedvector)*180/pi;
figure('Name','速度角');
subplot(221)
plot(IN_SENSOR.ublox1.time,velElv);hold on;
plot(FlightLog_Original.Filter.time_cal,FlightLog_Original.Filter.algo_NAV_pitchd);hold on;
legend('速度倾角[deg]','俯仰角[deg]')
grid on;
try
    subplot(223)
    alphavector = FlightLog_Original.Filter.algo_NAV_pitchd - velElv;
    plot(IN_SENSOR.ublox1.time,alphavector);hold on;grid on;
    ylabel('攻角[deg]')
end
subplot(122)
plot(IN_SENSOR.ublox1.time, velHeading,'r');hold on;
plot(IN_SENSOR.ublox1.time, algo_NAV_yaw,'b');hold on;
legend('速度偏角[deg]','偏航角[deg]')