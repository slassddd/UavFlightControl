hFig = figure;
hFig.Name = 'IMU1 IMU2 IMU3';
IMU1_idxsel = 1:4:length(IN_SENSOR.IMU1.time)-1;
data1 = IN_SENSOR.IMU1;
data2 = IN_SENSOR.IMU2;
data3 = IN_SENSOR.IMU3;
data4 = IN_SENSOR.IMU1_Control;
data5 = IN_SENSOR.IMU1_0;
enable_IMU0 = true;
% if length(IN_SENSOR.IMU1_0.accel_x) == length(data1.time)
%     data5.time = data1.time;
% elseif length(IN_SENSOR.IMU1_0.accel_x) == 2*length(data1.time)
%     data5.time = data1.time;
%     IN_SENSOR.IMU1_0.accel_x = IN_SENSOR.IMU1_0.accel_x(1:2:end);
%     IN_SENSOR.IMU1_0.accel_y = IN_SENSOR.IMU1_0.accel_y(1:2:end);
%     IN_SENSOR.IMU1_0.accel_z = IN_SENSOR.IMU1_0.accel_z(1:2:end);
%     IN_SENSOR.IMU1_0.gyro_x = IN_SENSOR.IMU1_0.gyro_x(1:2:end);
%     IN_SENSOR.IMU1_0.gyro_y = IN_SENSOR.IMU1_0.gyro_y(1:2:end);
%     IN_SENSOR.IMU1_0.gyro_z = IN_SENSOR.IMU1_0.gyro_z(1:2:end);
% else
%     enable_IMU0 = false;
% end
% ax
subplot(321)
if enable_IMU0
    plot(data5.time,IN_SENSOR.IMU1_0.accel_x,'c');hold on;
end
plot(data1.time(IMU1_idxsel),data1.accel_x(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.accel_x,'k');hold on;
plot(data3.time,data3.accel_x,'b');hold on;
plot(data4.time,data4.accel_x,'g');hold on;
xlabel('time(sec)')
ylabel('ax(m/s^2)')
grid on;
legend('IM1未滤波','IMU1','IMU2','IMU3','IMU_control')
% ay
subplot(323)
if enable_IMU0
    plot(data5.time,IN_SENSOR.IMU1_0.accel_y,'c');hold on;
end
plot(data1.time(IMU1_idxsel),data1.accel_y(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.accel_y,'k');hold on;
plot(data3.time,data3.accel_y,'b');hold on;
plot(data4.time,data4.accel_y,'g');hold on;
xlabel('time(sec)')
ylabel('ay(m/s^2)')
grid on;
% az
subplot(325)
if enable_IMU0
    plot(data5.time,IN_SENSOR.IMU1_0.accel_z,'c');hold on;
end
plot(data1.time(IMU1_idxsel),data1.accel_z(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.accel_z,'k');hold on;
plot(data3.time,data3.accel_z,'b');hold on;
plot(data4.time,data4.accel_z,'g');hold on;
xlabel('time(sec)')
ylabel('az(m/s^2)')
grid on;
% gx
subplot(322)
dataName = 'gyro_x';
if enable_IMU0
    plot(data5.time,IN_SENSOR.IMU1_0.gyro_x,'c');hold on;
end
plot(data1.time(IMU1_idxsel),data1.(dataName)(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.(dataName),'k');hold on;
plot(data3.time,data3.(dataName),'b');hold on;
plot(data4.time,data4.(dataName),'g');hold on;
xlabel('time(sec)')
ylabel('gx(rad/sec)')
grid on;
% gy
subplot(324)
dataName = 'gyro_y';
if enable_IMU0
    plot(data5.time,IN_SENSOR.IMU1_0.gyro_y,'c');hold on;
end
plot(data1.time(IMU1_idxsel),data1.(dataName)(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.(dataName),'k');hold on;
plot(data3.time,data3.(dataName),'b');hold on;
plot(data4.time,data4.(dataName),'g');hold on;
xlabel('time(sec)')
ylabel('gy(rad/sec)')
grid on;
% gz
subplot(326)
dataName = 'gyro_z';
if enable_IMU0
    plot(data5.time,IN_SENSOR.IMU1_0.gyro_z,'c');hold on;
end
plot(data1.time(IMU1_idxsel),data1.(dataName)(IMU1_idxsel),'r');hold on;
plot(data2.time,data2.(dataName),'k');hold on;
plot(data3.time,data3.(dataName),'b');hold on;
plot(data4.time,data4.(dataName),'g');hold on;
xlabel('time(sec)')
ylabel('gz(rad/sec)')
grid on;