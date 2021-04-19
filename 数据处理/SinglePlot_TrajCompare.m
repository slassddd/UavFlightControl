t = IN_SENSOR.ublox1.time;tmin = t(1);tmax = t(end); % ublox
timesel0 = 0;
timesel0 = max(0,timesel0);
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
data_nav = [FlightLog_Original.Filter.algo_NAV_latd,FlightLog_Original.Filter.algo_NAV_lond,FlightLog_Original.Filter.algo_NAV_alt,...
    FlightLog_Original.Filter.algo_NAV_yawd,FlightLog_Original.Filter.algo_NAV_pitchd,FlightLog_Original.Filter.algo_NAV_rolld];
data_nav = data_nav(idx0:idxf,:);
plot3(data_nav(:,1),data_nav(:,2),data_nav(:,3),'marker',lineType);hold on;grid on;
%
if ~exist('rtkdata')
    % 载入、处理sbet数据
    %     sbet0 = importfile_sbet('D:\work\V1000_firmware\SubFolder_飞行数据\V10 数据\20210411 航迹对比\sbet0.txt');
    clear rtkdata idxsel
    tempDir = 'D:\work\V1000_firmware\SubFolder_飞行数据\V10 数据\20210411 航迹对比\';
%     sbetfilename = {...
%         'SBET.dat',...
%         'SBET.OUT_-0.0005.dat',...
%         'SBET.OUT_-1.dat',...
%         'SBET.OUT_+0.005.dat',...
%         'SBET.OUT_+0.0005.dat',...
%         'SBET.OUT_+1.dat'
%         };
    sbetfilename = {...
        'SBET.dat',...
        'SBET.OUT_+0.005.dat',...
        'SBET.OUT_+0.0005.dat'
        };
    dTs = [0,5e-2,5e-4];
    nSbet = numel(sbetfilename);
    for i = 1:numel(sbetfilename)
        rtkdata{i} = importfile_sbet( sbetfilename{i} );
        rtkdata{i}(:,1) = round(rtkdata{i}(:,1),4);
    end
    stepShareTime = round(size(rtkdata{1},1)/200);
    idxsel{1} = 1:stepShareTime:size(rtkdata{1},1)-1000;
    timesel{1} = rtkdata{1}(idxsel{1});
    for i = 2:numel(rtkdata)
        tempSbetTime{i} = rtkdata{i}(:,1)-dTs(i);
        for j = 1:numel(timesel{1})
            thisTimeStamp = timesel{1}(j);
            tempIdx = find( tempSbetTime{i}>thisTimeStamp-1e-4 );
            tempIdx = tempIdx(1);
            idxsel{i}(j) = tempIdx;
            sl = 1;
        end
    end
end
if exist('rtkdata')
    for idx_sbet = 1:nSbet
        % 手动载入后处理轨迹数据
        poststep = 10;
        postp.time = rtkdata{idx_sbet}(1:poststep:end,1) - rtkdata{idx_sbet}(1,1);
        postp.lat = rtkdata{idx_sbet}(1:poststep:end,2);
        postp.lon = rtkdata{idx_sbet}(1:poststep:end,3);
        postp.alt = rtkdata{idx_sbet}(1:poststep:end,4);
        postp.roll = rtkdata{idx_sbet}(1:poststep:end,5);
        postp.pitch = rtkdata{idx_sbet}(1:poststep:end,6);
        postp.heading = rtkdata{idx_sbet}(1:poststep:end,7);
        postp.px = rtkdata{idx_sbet}(1:poststep:end,8);
        postp.py = rtkdata{idx_sbet}(1:poststep:end,9);
        postp.pz = rtkdata{idx_sbet}(1:poststep:end,10);
        
        postp.dtime = diff(postp.time);
        % gps_time   latitude   longtitude    altitude    roll    pitch    heading    x velocity    y velocity    z velocity
        % (seconds)  (degree)    (degree)       (m)     (degree) (degree)  (degree)     (m/s)         (m/s)          (m/s)
        t_post = postp.time;tmin = t_post(1);tmax = t_post(end); % 载荷数据
        fprintf('数据时间范围:payload [%.0f,%.0f]\n',tmin,tmax)
        idx0 = min(find(t_post > timesel0));
        idxf = max(find(t_post <= timeself));
        t_post = t_post(idx0:idxf);
        data_post = [postp.lat,postp.lon,postp.alt,postp.heading,postp.pitch,postp.roll];
        data_post = data_post(idx0:idxf,:);
        if idx_sbet == 1
            data_post_base = data_post;
            postp_base = postp;
            %
        end
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
        fig_ts = figure(10000);
        fig_ts.Name = '时间间隔稳定性';
        dtime = diff(t_post);
        plot(t_post(1:end-1),dtime,'.');
        ylabel('dt(sec)')
        % 位置对比
        fig_lla = figure(10001);
        fig_lla.Name = '位置对比';
        idx = 1;
        subplot(3,1,idx)
        if idx_sbet == 1
        plot(t_ublox,data_ublox(:,idx));hold on;grid on;
        plot(t_um482,data_um482(:,idx));hold on;grid on;
        plot(t_nav,data_nav(:,idx));hold on;grid on;
        end
        plot(t_post,data_post(:,idx));hold on;grid on;
        legend('ublox','um482','nav','载荷');
        idx = 2;
        subplot(3,1,idx)
        if idx_sbet == 1
        plot(t_ublox,data_ublox(:,idx));hold on;grid on;
        plot(t_um482,data_um482(:,idx));hold on;grid on;
        plot(t_nav,data_nav(:,idx));hold on;grid on;
        end
        plot(t_post,data_post(:,idx));hold on;grid on;
        legend('ublox','um482','nav','载荷');
        idx = 3;
        subplot(3,1,idx)
        if idx_sbet == 1
        plot(t_ublox,data_ublox(:,idx));hold on;grid on;
        plot(t_um482,data_um482(:,idx));hold on;grid on;
        plot(t_nav,data_nav(:,idx));hold on;grid on;
        end
        plot(t_post,data_post(:,idx));hold on;grid on;
        legend('ublox','um482','nav','载荷');
        % 姿态对比
        fig_att = figure(10002);
        fig_att.Name = '姿态对比';
        idx = 4;
        subplot(3,1,idx-3)
        if idx_sbet == 1
        plot(t_nav,data_nav(:,idx));hold on;grid on;
        end
        plot(t_post,data_post(:,idx));hold on;grid on;
        idx = 5;
        subplot(3,1,idx-3)
        if idx_sbet == 1
        plot(t_nav,data_nav(:,idx));hold on;grid on;
        end
        plot(t_post,data_post(:,idx));hold on;grid on;
        idx = 6;
        subplot(3,1,idx-3)
        if idx_sbet == 1
        plot(t_nav,data_nav(:,idx));hold on;grid on;
        end
        plot(t_post,data_post(:,idx));hold on;grid on;
        % 误差曲线
%         if idx_sbet >= 2
%             % 位置
%             fig_att = figure(10003);
%             fig_att.Name = '位置对比 误差';
%             idx = 1;
%             subplot(3,1,idx)
%             plot(t_post,data_post_base(idxsel{1},idx)-data_post(idxsel{idx_sbet},idx));hold on;grid on;
%             idx = 2;
%             subplot(3,1,idx)
%             plot(t_post,data_post_base(idxsel{1},idx)-data_post(idxsel{idx_sbet},idx));hold on;grid on;
%             idx = 3;
%             subplot(3,1,idx)
%             plot(t_post,data_post_base(idxsel{1},idx)-data_post(idxsel{idx_sbet},idx));hold on;grid on;
%             % 姿态
%             fig_att = figure(10004);
%             fig_att.Name = '姿态对比 误差';
%             idx = 4;
%             subplot(3,1,idx-3)
%             plot(t_post,data_post_base(idxsel{1},idx)-data_post(idxsel{idx_sbet},idx));hold on;grid on;
%             idx = 5;
%             subplot(3,1,idx-3)
%             plot(t_post,data_post_base(idxsel{1},idx)-data_post(idxsel{idx_sbet},idx));hold on;grid on;
%             idx = 6;
%             subplot(3,1,idx-3)
%             plot(t_post,data_post_base(idxsel{1},idx)-data_post(idxsel{idx_sbet},idx));hold on;grid on;
%         end
    end
    figure(10001)
    str = '''ublox'',''um482'',''nav''';
    for idx = 1:nSbet
        str = [str,',''',sbetfilename{idx},''''];
    end
    eval(['legend(',str,')'])
    
    figure(10002)
    str = '''nav''';
    for idx = 1:nSbet
        str = [str,',''',sbetfilename{idx},''''];
    end
    eval(['legend(',str,')'])    
end