tempFilter = FlightLog_Original.Filter;
%
figure;
% 姿态
subplot(331);
plot(tempFilter.time,tempFilter.algo_NAV_yawd);hold on;grid on;
ylabel('yaw(deg)')
subplot(334);
plot(tempFilter.time,tempFilter.algo_NAV_pitchd);hold on;grid on;
ylabel('pitch(deg)')
subplot(337);
plot(tempFilter.time,tempFilter.algo_NAV_rolld);hold on;grid on;
ylabel('roll(deg)')
% 位置
idx_nonzero = find(tempFilter.algo_NAV_lond~=0);
subplot(332);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_lond(idx_nonzero));hold on;grid on;
ylabel('Lon(deg)')
subplot(335);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_latd(idx_nonzero));hold on;grid on;
ylabel('Lat(deg)')
subplot(338);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_alt(idx_nonzero));hold on;grid on;
ylabel('Alt(deg)')
% 速度
idx_nonzero = find(~isnan(tempFilter.algo_NAV_lond));
subplot(333);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_Vn(idx_nonzero));hold on;grid on;
ylabel('Vn(m/s)')
subplot(336);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_Ve(idx_nonzero));hold on;grid on;
ylabel('Ve(m/s)')
subplot(339);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_Vd(idx_nonzero));hold on;grid on;
ylabel('Vd(m/s)')
%% ----------------------------------------------------------------------------------------
tempFilter.time = FlightLog_Original.OUT_TASKFLIGHTPARAM.time;
tempFilter.algo_NAV_lond = FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA1;
tempFilter.algo_NAV_latd = FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA0;
tempFilter.algo_NAV_alt = FlightLog_Original.OUT_TASKFLIGHTPARAM.curLLA2;
tempFilter.algo_NAV_yawd = FlightLog_Original.OUT_TASKFLIGHTPARAM.curEuler0*180/pi;
tempFilter.algo_NAV_pitchd = FlightLog_Original.OUT_TASKFLIGHTPARAM.curEuler1*180/pi;
tempFilter.algo_NAV_rolld = FlightLog_Original.OUT_TASKFLIGHTPARAM.curEuler2*180/pi;
tempFilter.algo_NAV_Vn = FlightLog_Original.OUT_TASKFLIGHTPARAM.curVelNED0;
tempFilter.algo_NAV_Ve = FlightLog_Original.OUT_TASKFLIGHTPARAM.curVelNED1;
tempFilter.algo_NAV_Vd = FlightLog_Original.OUT_TASKFLIGHTPARAM.curVelNED2;
% figure;
% 姿态
subplot(331);
plot(tempFilter.time,tempFilter.algo_NAV_yawd);hold on;grid on;
ylabel('yaw(deg)')
subplot(334);
plot(tempFilter.time,tempFilter.algo_NAV_pitchd);hold on;grid on;
ylabel('pitch(deg)')
subplot(337);
plot(tempFilter.time,tempFilter.algo_NAV_rolld);hold on;grid on;
ylabel('roll(deg)')
% 位置
idx_nonzero = find(tempFilter.algo_NAV_lond~=0);
subplot(332);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_lond(idx_nonzero));hold on;grid on;
ylabel('Lon(deg)')
subplot(335);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_latd(idx_nonzero));hold on;grid on;
ylabel('Lat(deg)')
subplot(338);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_alt(idx_nonzero));hold on;grid on;
ylabel('Alt(deg)')
% 速度
idx_nonzero = find(~isnan(tempFilter.algo_NAV_lond));
subplot(333);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_Vn(idx_nonzero));hold on;grid on;
ylabel('Vn(m/s)')
subplot(336);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_Ve(idx_nonzero));hold on;grid on;
ylabel('Ve(m/s)')
subplot(339);
plot(tempFilter.time(idx_nonzero),tempFilter.algo_NAV_Vd(idx_nonzero));hold on;grid on;
ylabel('Vd(m/s)')
%% ublox
tempData = IN_SENSOR.ublox1;
idx_ublox_nonzero = find(tempData.Lon~=0);
subplot(332);
plot(tempData.time(idx_ublox_nonzero),tempData.Lon(idx_ublox_nonzero));hold on;grid on;
ylabel('Lon(deg)')
subplot(335);
plot(tempData.time(idx_ublox_nonzero),tempData.Lat(idx_ublox_nonzero));hold on;grid on;
ylabel('Lat(deg)')
subplot(338);
plot(tempData.time(idx_ublox_nonzero),tempData.height(idx_ublox_nonzero));hold on;grid on;
ylabel('Alt(deg)')
%% um482
tempData = IN_SENSOR.um482;
idx_ublox_nonzero = find(tempData.Lon~=0);
subplot(332);
plot(tempData.time(idx_ublox_nonzero),tempData.Lon(idx_ublox_nonzero));hold on;grid on;
ylabel('Lon(deg)')
legend('nav','task','ublox','um482')
subplot(335);
plot(tempData.time(idx_ublox_nonzero),tempData.Lat(idx_ublox_nonzero));hold on;grid on;
ylabel('Lat(deg)')
subplot(338);
plot(tempData.time(idx_ublox_nonzero),tempData.height(idx_ublox_nonzero));hold on;grid on;
ylabel('Alt(deg)')