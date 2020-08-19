figure;
%% 姿态
subplot(331);
plot(SL.Filter.time_cal,SL.Filter.algo_NAV_yawd);hold on;grid on;
ylabel('yaw(deg)')
subplot(334);
plot(SL.Filter.time_cal,SL.Filter.algo_NAV_pitchd);hold on;grid on;
ylabel('pitch(deg)')
subplot(337);
plot(SL.Filter.time_cal,SL.Filter.algo_NAV_rolld);hold on;grid on;
ylabel('roll(deg)')
%% 位置
idx_nonzero = find(SL.Filter.algo_NAV_lond~=0);
subplot(332);
plot(SL.Filter.time_cal(idx_nonzero),SL.Filter.algo_NAV_lond(idx_nonzero));hold on;grid on;
ylabel('Lon(deg)')
subplot(335);
plot(SL.Filter.time_cal(idx_nonzero),SL.Filter.algo_NAV_latd(idx_nonzero));hold on;grid on;
ylabel('Lat(deg)')
subplot(338);
plot(SL.Filter.time_cal(idx_nonzero),SL.Filter.algo_NAV_alt(idx_nonzero));hold on;grid on;
ylabel('Alt(deg)')
%% 速度
idx_nonzero = find(~isnan(SL.Filter.algo_NAV_lond));
subplot(333);
plot(SL.Filter.time_cal(idx_nonzero),SL.Filter.algo_NAV_Vn(idx_nonzero));hold on;grid on;
ylabel('Vn(m/s)')
subplot(336);
plot(SL.Filter.time_cal(idx_nonzero),SL.Filter.algo_NAV_Ve(idx_nonzero));hold on;grid on;
ylabel('Ve(m/s)')
subplot(339);
plot(SL.Filter.time_cal(idx_nonzero),SL.Filter.algo_NAV_Vd(idx_nonzero));hold on;grid on;
ylabel('Vd(m/s)')