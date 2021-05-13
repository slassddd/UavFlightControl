figure('Name','高度对比');
subplot(221)
plot(FlightLog_Original.OUT_TASKFLIGHTPARAM.time,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
plot(FlightLog_Original.OUT_TASKMODE.time,FlightLog_Original.OUT_TASKMODE.heightCmd);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);
xlabel('time(sec)')
ylabel('高度(m)')
grid on;
legend('task综合高','高度指令','雷达高')
subplot(222)
idx0_curLLA = round(0.5*length(FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2));
idx0_NAV_alt = round(0.5*length(FlightLog_Original.Filter.algo_NAV_alt));
err = mean(FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2(idx0_curLLA:end)) - mean(FlightLog_Original.Filter.algo_NAV_alt(idx0_NAV_alt:end));
plot(FlightLog_Original.OUT_TASKFLIGHTPARAM.time,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(FlightLog_Original.Filter.time,FlightLog_Original.Filter.algo_NAV_alt+err);hold on;
xlabel('time(sec)')
ylabel('高度(m)')
grid on;
legend('任务高度','雷达高','滤波高')
subplot(223)
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(IN_SENSOR.laserDown1.time,IN_SENSOR.laserDown1.range);hold on;
plot(IN_SENSOR.laserDown2.time,IN_SENSOR.laserDown2.range);hold on;
plot(FlightLog_Original.OUT_TASKFLIGHTPARAM.time,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
xlabel('time(sec)')
ylabel('高度(m)')
grid on;
legend('radar1','laserDown1','laserDown2','Task')