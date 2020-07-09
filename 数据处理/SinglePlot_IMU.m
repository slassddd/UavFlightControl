hFig = figure;
hFig.Name = 'IMU1 IMU2 IMU3';
IMU1_idxsel = 1:4:length(IN_SENSOR.IMU1.time)-1;
data1 = IN_SENSOR.IMU1;
data2 = IN_SENSOR.IMU2;
data3 = IN_SENSOR.IMU3;
% ax
subplot(321)
plot(data1.time(IMU1_idxsel),data1.accel_x(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.accel_x,'k');hold on;
plot(data3.time,data3.accel_x,'b');hold on;
xlabel('time(sec)')
ylabel('ax(m/s^2)')
grid on;
legend('IMU1','IMU2','IMU3')
% ay
subplot(323)
plot(data1.time(IMU1_idxsel),data1.accel_y(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.accel_y,'k');hold on;
plot(data3.time,data3.accel_y,'b');hold on;
xlabel('time(sec)')
ylabel('ay(m/s^2)')
grid on;
% az
subplot(325)
plot(data1.time(IMU1_idxsel),data1.accel_z(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.accel_z,'k');hold on;
plot(data3.time,data3.accel_z,'b');hold on;
xlabel('time(sec)')
ylabel('az(m/s^2)')
grid on;
% gx
subplot(322)
dataName = 'gyro_x';
plot(data1.time(IMU1_idxsel),data1.(dataName)(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.(dataName),'k');hold on;
plot(data3.time,data3.(dataName),'b');hold on;
xlabel('time(sec)')
ylabel('gx(rad/sec)')
grid on;
% gy
subplot(324)
dataName = 'gyro_y';
plot(data1.time(IMU1_idxsel),data1.(dataName)(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.(dataName),'k');hold on;
plot(data3.time,data3.(dataName),'b');hold on;
xlabel('time(sec)')
ylabel('gy(rad/sec)')
grid on;
% gz
subplot(326)
dataName = 'gyro_z';
plot(data1.time(IMU1_idxsel),data1.(dataName)(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.(dataName),'k');hold on;
plot(data3.time,data3.(dataName),'b');hold on;
xlabel('time(sec)')
ylabel('gz(rad/sec)')
grid on;