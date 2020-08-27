maxTime = IN_SENSOR.mag1.time(end);
nData = size(RM3100.mag,1);
t0_base = -0;
Ts_RM3100 = 0.67;
mag1Time = linspace(0,Ts_RM3100*nData,nData) + t0_base;
% mag1Time = linspace(0,maxTime,nData);
mag1Data = RM3100.mag/100;
figure(2012)
subplot(321)
plot(mag1Time,mag1Data(:,1));hold on;
ylabel('mag x [Gauss]')
grid on;
subplot(323)
plot(mag1Time,mag1Data(:,2));hold on;
ylabel('mag y [Gauss]')
grid on;
subplot(325)
plot(mag1Time,mag1Data(:,3));hold on;
ylabel('mag z [Gauss]')
grid on;
subplot(322)
absMag1 = vecnorm(mag1Data');
plot(mag1Time,absMag1);hold on;
xlabel('time(sec)')
ylabel('磁强度幅值(Guass)')
grid on;

if true
    mag1Time = IN_SENSOR.mag1.time;
    mag2Time = IN_SENSOR.mag2.time;
    mag1Data = [IN_SENSOR.mag1.mag_x,IN_SENSOR.mag1.mag_y,IN_SENSOR.mag1.mag_z];
    mag2Data = [IN_SENSOR.mag2.mag_x,IN_SENSOR.mag2.mag_y,IN_SENSOR.mag2.mag_z];
    figure(2012)
    subplot(321)
    plot(mag1Time,mag1Data(:,1));hold on;
    plot(mag2Time,mag2Data(:,1));hold on;
    ylabel('mag x [Gauss]')
    grid on;
    legend('RM3100','mag1','mag2')
    subplot(323)
    plot(mag1Time,mag1Data(:,2));hold on;
    plot(mag2Time,mag2Data(:,2));hold on;
    ylabel('mag y [Gauss]')
    grid on;
    legend('RM3100','mag1','mag2')
    subplot(325)
    plot(mag1Time,mag1Data(:,3));hold on;
    plot(mag2Time,mag2Data(:,3));hold on;
    ylabel('mag z [Gauss]')
    grid on;
    legend('RM3100','mag1','mag2')
    subplot(322)
    absMag1 = vecnorm(mag1Data');
    plot(IN_SENSOR.mag1.time,absMag1);hold on;
    absMag2 = vecnorm(mag2Data');
    plot(IN_SENSOR.mag2.time,absMag2);hold on;
    try
        absMag3 = vecnorm([mag3_x,mag3_y,mag3_z]');
        plot(IN_SENSOR.mag3.time,absMag3);hold on;
    end
    legend('RM3100','mag1','mag2')
    xlabel('time(sec)')
    ylabel('磁强度幅值(Guass)')
    grid on;
end