figure('Name','高度对比');
subplot(121)
plot(FlightLog_Original.OUT_TASKFLIGHTPARAM.time_cal,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
plot(FlightLog_Original.OUT_TASKMODE.time_cal,FlightLog_Original.OUT_TASKMODE.heightCmd);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);
grid on;
legend('task综合高','高度指令','雷达高')
subplot(122)
idx0_curLLA = round(0.5*length(FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2));
idx0_NAV_alt = round(0.5*length(FlightLog_Original.Filter.algo_NAV_alt));
err = mean(FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2(idx0_curLLA:end)) - mean(FlightLog_Original.Filter.algo_NAV_alt(idx0_NAV_alt:end));
plot(FlightLog_Original.OUT_TASKFLIGHTPARAM.time_cal,FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2);hold on;
plot(IN_SENSOR.radar1.time,IN_SENSOR.radar1.Range);hold on;
plot(FlightLog_Original.Filter.time_cal,FlightLog_Original.Filter.algo_NAV_alt+err);hold on;
grid on;
legend('任务高度','雷达高','滤波高')