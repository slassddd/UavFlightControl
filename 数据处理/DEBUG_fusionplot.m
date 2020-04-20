
data0 = IN_SENSOR;
data1 = Out_Sensors;
figure(1)
subplot(3,3,1)
plot(IN_SENSOR.mag2.time,-1e2*data0.mag2.mag_y,'r');hold on;
plot(IN_SENSOR.mag2.time,data1.mag2.mag_x(1:4:end),'k--');hold on;
ylabel('mag2_y')
grid on;
subplot(3,3,2)
plot(IN_SENSOR.IMU1.time,-data0.IMU1.accel_x,'r');hold on;
plot(IN_SENSOR.IMU1.time,data1.IMU1.accel_x(1:end),'k--');hold on;
ylabel('IMU1 acc_x')
grid on;
subplot(3,3,3)
plot(IN_SENSOR.ublox1.time,data0.ublox1.Lat,'r');hold on;
plot(IN_SENSOR.ublox1.time,data1.ublox1.Lat(1:4:end),'k--');hold on;
ylabel('ublox1 lat')
grid on;
subplot(3,3,4)
plot(IN_SENSOR.ublox1.time,data0.ublox1.height,'r');hold on;
plot(IN_SENSOR.ublox1.time,data1.ublox1.height(1:4:end),'k--');hold on;
ylabel('ublox1 height')
grid on;
subplot(3,3,5)
plot(IN_SENSOR.ublox1.time,data0.ublox1.velN,'r');hold on;
plot(IN_SENSOR.ublox1.time,data1.ublox1.velN(1:4:end),'k--');hold on;
ylabel('ublox1 velN')
grid on;
subplot(3,3,6)
plot(IN_SENSOR.ublox1.time,data0.ublox1.pDop,'r');hold on;
plot(IN_SENSOR.ublox1.time,data1.ublox1.pDop(1:4:end),'k--');hold on;
ylabel('ublox1 pDop')
grid on;
%%
fprintf('gyro_bias0: %f, %f, %f\n',[Out_initValue.gyro_bias0_0(end),Out_initValue.gyro_bias0_1(end),Out_initValue.gyro_bias0_2(end)]);
fprintf('acc_bias0: %f, %f, %f\n',[Out_initValue.acc_bias0_0(end),Out_initValue.acc_bias0_1(end),Out_initValue.acc_bias0_2(end)]);
fprintf('LLA: %f, %f, %f\n',[Out_initValue.lla0_0(end),Out_initValue.lla0_1(end),Out_initValue.lla0_2(end)]);
fprintf('gpsvel: %f, %f, %f\n',[Out_initValue.gpsvel0_0(end),Out_initValue.gpsvel0_1(end),Out_initValue.gpsvel0_2(end)]);
fprintf('eulerd: %f, %f, %f\n',[Out_initValue.eulerd0_0(end),Out_initValue.eulerd0_1(end),Out_initValue.eulerd0_2(end)]);
fprintf('range: %f\n',[Out_initValue.range0(end)]);

%%
figure(2)
subplot(3,2,1);
plot(diff(stepInfo.step));
ylabel('step')
grid on;
subplot(3,2,2);
plot(diff(stepInfo.step_imu));
ylabel('step_imu')
grid on;
subplot(3,2,3);
plot(diff(stepInfo.step_mag));
ylabel('step_mag')
grid on;
subplot(3,2,4);
plot(diff(stepInfo.step_ublox));
ylabel('step_ublox')
grid on;
subplot(3,2,5);
plot(diff(stepInfo.step_alt));
ylabel('step_alt')
grid on;