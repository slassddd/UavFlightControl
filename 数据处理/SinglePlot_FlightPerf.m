% 飞行性能数据
data = SL.OUT_FLIGHTPERF;
nrow = 3;
ncol = 3;
figure;
subplot(nrow,ncol,1)
plot(data.time_cal,data.isAbleToCompleteTask);
ylabel