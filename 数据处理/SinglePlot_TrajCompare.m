t = IN_SENSOR.ublox1.time;tmin = t(1);tmax = t(end); % ublox
timesel0 = 0;
timesel0 = max(50,timesel0);
timeself = inf;
timeself = min(timeself,tmax);
% 画图配置
lineType = 'o';
%
figure;
t_ublox = IN_SENSOR.ublox1.time;tmin = t_ublox(1);tmax = t_ublox(end); % ublox
fprintf('数据时间范围:ublox [%.0f,%.0f]\n',tmin,tmax)
idx0 = min(find(t_ublox > timesel0));
idxf = max(find(t_ublox <= timeself));
t_ublox = t_ublox(idx0:idxf);
data_ublox = [IN_SENSOR.ublox1.Lat,IN_SENSOR.ublox1.Lon,IN_SENSOR.ublox1.height];data_ublox = data_ublox(idx0:idxf,:);
plot3(data_ublox(:,1),data_ublox(:,2),data_ublox(:,3),'marker',lineType);hold on;grid on;
t_um482 = IN_SENSOR.um482.time;tmin = t_um482(1);tmax = t_um482(end); % um482
fprintf('数据时间范围:um482 [%.0f,%.0f]\n',tmin,tmax)
idx0 = min(find(t_um482 > timesel0));
idxf = max(find(t_um482 <= timeself));
t_um482 = t_um482(idx0:idxf);
data_um482 = [IN_SENSOR.um482.Lat,IN_SENSOR.um482.Lon,IN_SENSOR.um482.height];
data_um482 = data_um482(idx0:idxf,:);
plot3(data_um482(:,1),data_um482(:,2),data_um482(:,3),'marker',lineType);hold on;grid on;
t_nav = FlightLog_Original.Filter.time;tmin = t_nav(1);tmax = t_nav(end); % navi
fprintf('数据时间范围:nav [%.0f,%.0f]\n',tmin,tmax)
idx0 = min(find(t_nav > timesel0));
idxf = max(find(t_nav <= timeself));
t_nav = t_nav(idx0:idxf);
data_nav = [FlightLog_Original.Filter.algo_NAV_latd,FlightLog_Original.Filter.algo_NAV_lond,FlightLog_Original.Filter.algo_NAV_alt];
data_nav = data_nav(idx0:idxf,:);
plot3(data_nav(:,1),data_nav(:,2),data_nav(:,3),'marker',lineType);hold on;grid on;
%
if 1
    % 手动载入后处理轨迹数据
    poststep = 10;
    postp.time = sbet(1:poststep:end,1) - sbet(1,1);
    postp.lat = sbet(1:poststep:end,2);
    postp.lon = sbet(1:poststep:end,3);
    postp.alt = sbet(1:poststep:end,4);
    postp.roll = sbet(1:poststep:end,5);
    postp.pitch = sbet(1:poststep:end,6);
    postp.heading = sbet(1:poststep:end,7);
    postp.px = sbet(1:poststep:end,8);
    postp.py = sbet(1:poststep:end,9);
    postp.pz = sbet(1:poststep:end,10);
    
    postp.dtime = diff(postp.time);
    % gps_time   latitude   longtitude    altitude    roll    pitch    heading    x velocity    y velocity    z velocity
    % (seconds)  (degree)    (degree)       (m)     (degree) (degree)  (degree)     (m/s)         (m/s)          (m/s)
    t_post = postp.time;tmin = t_post(1);tmax = t_post(end); % 载荷数据
    fprintf('数据时间范围:payload [%.0f,%.0f]\n',tmin,tmax)
    idx0 = min(find(t_post > timesel0));
    idxf = max(find(t_post <= timeself));
    t_post = t_post(idx0:idxf);
    data_post = [postp.lat,postp.lon,postp.alt];
    data_post = data_post(idx0:idxf,:);
    % 时间对齐
    [value_um482_max_lat,idx_um482_max_lat] = max(data_um482(:,1));
    t_um482_max_lat = t_um482(idx_um482_max_lat);
    [value_ublox_max_lat,idx_ublox_max_lat] = max(data_ublox(:,1));
    t_ublox_max_lat = t_ublox(idx_ublox_max_lat);
    [value_post_max_lat,idx_post_max_lat] = max(data_post(:,1));
    t_post_max_lat = t_post(idx_post_max_lat);
    fprintf('时间对齐: post时间应减 %.3f[sec]\n',t_post_max_lat-t_um482_max_lat);
    t_post = t_post - (t_post_max_lat-t_um482_max_lat);
    %
    plot3(data_post(:,1),data_post(:,2),data_post(:,3),'marker',lineType);hold on;grid on;
    legend('ublox','um482','nav','载荷');
    %% 分项数据
    % 时间间隔稳定性
    figure;
    dtime = diff(t_post);
    plot(t_post(1:end-1),dtime,'.');
    ylabel('dt(sec)')
    % 位置对比
    figure;
    idx = 1;
    subplot(3,1,idx)
    plot(t_ublox,data_ublox(:,idx));hold on;grid on;
    plot(t_um482,data_um482(:,idx));hold on;grid on;
    plot(t_nav,data_nav(:,idx));hold on;grid on;
    plot(t_post,data_post(:,idx));hold on;grid on;
    legend('ublox','um482','nav','载荷');
    idx = 2;
    subplot(3,1,idx)
    plot(t_ublox,data_ublox(:,idx));hold on;grid on;
    plot(t_um482,data_um482(:,idx));hold on;grid on;
    plot(t_nav,data_nav(:,idx));hold on;grid on;
    plot(t_post,data_post(:,idx));hold on;grid on;
    legend('ublox','um482','nav','载荷');
    idx = 3;
    subplot(3,1,idx)
    plot(t_ublox,data_ublox(:,idx));hold on;grid on;
    plot(t_um482,data_um482(:,idx));hold on;grid on;
    plot(t_nav,data_nav(:,idx));hold on;grid on;
    plot(t_post,data_post(:,idx));hold on;grid on;
    legend('ublox','um482','nav','载荷');
end