figure;
time = FlightLog_Original.OUT_TASKFLIGHTPARAM.time_cal;
data = [FlightLog_Original.OUT_TASKFLIGHTPARAM.curHomeLLA0,FlightLog_Original.OUT_TASKFLIGHTPARAM.curHomeLLA1];
time1 = FlightLog_Original.OUT_TASKMODE.time_cal;
data1 = [FlightLog_Original.OUT_TASKMODE.turnCenterLL0,FlightLog_Original.OUT_TASKMODE.turnCenterLL1];
idxSel = find(data(:,1).*data(:,2) == 0);
idxSel1 = find(data1(:,1).*data1(:,2) == 0);
data(idxSel,:) = [];
time(idxSel,:) = [];
data1(idxSel1,:) = [];
time1(idxSel1,:) = [];
% unique(data)
subplot(121)
plot(data(:,2),data(:,1),'ro');hold on;
plot(data1(:,2),data1(:,1),'b*');hold on;
grid on;
xlabel('lon(deg)');
ylabel('lat(deg)');
legend('home','turnCenter')
subplot(222)
plot(time,data(:,1));
hold on;
grid on;
xlabel('time(sec)');
ylabel('lat(deg)');
subplot(224)
plot(time,data(:,2));
hold on;
grid on;
xlabel('time(sec)');
ylabel('lon(deg)');