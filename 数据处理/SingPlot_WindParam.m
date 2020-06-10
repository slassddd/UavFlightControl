function SingPlot_WindParam(baseTime,structData)
fprintf('----------------------------------------------\n')
time = calTimeSeries(baseTime,structData.maxWindHeading);
fig = figure;
fig.Name = mfilename;
subplot(3,2,1)
plot(time,structData.sailWindSpeed);
grid on;
xlabel('time (sec)');
ylabel('出航风速[m/s]')
subplot(3,2,2)
plot(time,structData.sailWindHeading*180/pi);
grid on;
xlabel('time (sec)');
ylabel('出航航向[deg]')
subplot(3,2,3)
plot(time,structData.windSpeedMax);
grid on;
xlabel('time (sec)');
ylabel('最大风速[m/s]')
subplot(3,2,4)
plot(time,structData.windSpeedMin);
grid on;
xlabel('time (sec)');
ylabel('最小风速[m/s]')
subplot(3,2,5)
plot(time,structData.maxWindHeading*180/pi);
grid on;
xlabel('time (sec)');
ylabel('最大风速航向[deg]')
% 显示信息
fprintf('出航风速：%.1f [m/s]\n',structData.sailWindSpeed(end))
fprintf('出航航向：%.0f [deg], 最大风速航向: %.0f [deg]\n',...
    structData.sailWindHeading(end)*180/pi,structData.maxWindHeading(end)*180/pi)