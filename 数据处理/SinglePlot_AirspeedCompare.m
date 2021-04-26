figure;
plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed);hold on;
plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed_indicate);hold on;
plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed2.airspeed_indicate,'r-.');hold on;
plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed_true,'--');hold on;

try
    plot(IN_SENSOR.airspeed1.time,arspeed(1:2:end));hold on;
end
if 1
    groundspeed = vecnorm([IN_SENSOR.ublox1.velN,IN_SENSOR.ublox1.velE,IN_SENSOR.ublox1.velD],2,2);
    plot(IN_SENSOR.ublox1.time,groundspeed);hold on;
end
legend('airspeed1','airspeed1 indicate','airspeed2 indicate','airspeed1 true','airspeed indicate task','groundspeed');
xlabel('time(s)')
ylabel('vel(m/s)')
grid on;