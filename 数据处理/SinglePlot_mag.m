mag1Time = IN_SENSOR.mag1.time;
mag2Time = IN_SENSOR.mag2.time;
mag1Data = [IN_SENSOR.mag1.mag_x,IN_SENSOR.mag1.mag_y,IN_SENSOR.mag1.mag_z];
mag2Data = [IN_SENSOR.mag2.mag_x,IN_SENSOR.mag2.mag_y,IN_SENSOR.mag2.mag_z];
figure(2011)
subplot(321)
plot(mag1Time,mag1Data(:,1));hold on;
plot(mag2Time,mag2Data(:,1));hold on;
ylabel('mag x [Gauss]')
grid on;
legend('mag1','mag2')
subplot(323)
plot(mag1Time,mag1Data(:,2));hold on;
plot(mag2Time,mag2Data(:,2));hold on;
ylabel('mag y [Gauss]')
grid on;
legend('mag1','mag2')
subplot(325)
plot(mag1Time,mag1Data(:,3));hold on;
plot(mag2Time,mag2Data(:,3));hold on;
ylabel('mag z [Gauss]')
grid on;
legend('mag1','mag2')
subplot(322)
absMag1 = vecnorm(mag1Data');
plot(IN_SENSOR.mag1.time,absMag1);hold on;
absMag2 = vecnorm(mag2Data');
plot(IN_SENSOR.mag2.time,absMag2);hold on;
try
    absMag3 = vecnorm([mag3_x,mag3_y,mag3_z]');
    plot(IN_SENSOR.mag3.time,absMag3);hold on;
end
legend('mag1','mag2')
xlabel('time(sec)')
ylabel('磁强度幅值(Guass)')
grid on;
subplot(324)
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range)