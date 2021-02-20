function SinglePlot_GlobalWindEst(GlobalWindStruct)
try
    time = GlobalWindStruct.time_cal;
catch
    time = GlobalWindStruct.time;
end
windHeading_deg = GlobalWindStruct.windHeading_rad*57.3;
windSpeed_ms = GlobalWindStruct.windSpeed_ms;
figure;
subplot(211)
plot(time,windSpeed_ms);hold on;
grid on;
ylabel('风速(m/s)')
subplot(212)
plot(time,windHeading_deg);hold on;
grid on;
xlabel('时间 (s)')
ylabel('风向 (m/s)')