function SinglePlot_IMU(IN_SENSOR)
%% 绘制IMU数据
%% 数据准备
marker = {'r','k','b','g','c','y','r--'};
IMUmode = 'manual';
switch IMUmode
    case 'auto'
        childnames = fieldnames(IN_SENSOR);
        IMUnames = childnames(contains(childnames,'IMU'));
        nIMU = length(IMUnames);
        for i = 1:nIMU
            data{i} = IN_SENSOR.(IMUnames{i});
        end
    case 'manual'
        data{1} = IN_SENSOR.IMU1;
        data{2} = IN_SENSOR.IMU2;
        data{3} = IN_SENSOR.IMU3;
        data{4} = IN_SENSOR.IMU4;
        data{5} = IN_SENSOR.IMU1_Control;
        data{6} = IN_SENSOR.IMU1_0;
        nIMU = length(data);
end
%% 绘图
hFig = figure;
hFig.Name = 'IMU数据';
% ax
subplot(321)
dataName = 'accel_x';
for i = 1:nIMU
    plot(data{i}.time,data{i}.(dataName),marker{i});
    hold on;
    grid on;
    xlabel('time(sec)')
end
ylabel('ax(m/s^2)')
legend('IM1_0','IMU1','IMU2','IMU3','IMU4','IMU_control')
% ay
subplot(323)
dataName = 'accel_y';
for i = 1:nIMU
    plot(data{i}.time,data{i}.(dataName),marker{i});
    hold on;
    grid on;
    xlabel('time(sec)')
end
ylabel('ay(m/s^2)')
% az
subplot(325)
dataName = 'accel_z';
for i = 1:nIMU
    plot(data{i}.time,data{i}.(dataName),marker{i});
    hold on;
    grid on;
    xlabel('time(sec)')
end
ylabel('az(m/s^2)')
% gx
subplot(322)
dataName = 'gyro_x';
for i = 1:nIMU
    plot(data{i}.time,data{i}.(dataName),marker{i});
    hold on;
    grid on;
    xlabel('time(sec)')
end
ylabel('gx(m/s^2)')
% gy
subplot(324)
dataName = 'gyro_y';
for i = 1:nIMU
    plot(data{i}.time,data{i}.(dataName),marker{i});
    hold on;
    grid on;
    xlabel('time(sec)')
end
ylabel('gy(m/s^2)')
% gz
subplot(326)
dataName = 'gyro_z';
for i = 1:nIMU
    plot(data{i}.time,data{i}.(dataName),marker{i});
    hold on;
    grid on;
    xlabel('time(sec)')
end
ylabel('gz(m/s^2)')