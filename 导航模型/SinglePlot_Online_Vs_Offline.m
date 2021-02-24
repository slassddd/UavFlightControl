% 算法对比： 离线 vs 在线
% 数据源：
try
    dataSim = navFilterMARGRes;  % 离线仿真数据
    dataOnLine = navFilterMARGRes_OnLine; % 在线飞行数据
catch
    i_sim = 1;
    dataSim = SimRes.Navi.MARG(i_sim);  % 离线仿真数据
    dataOnLine = SimDataSet.FlightLog_Original(i_sim).Filter; % 在线飞行数据
end
%
onlineFlag = 1;
offlineFlag = 1;
ubloxFlag = 1;
um482Flag = 1;
tmpStartIdx = 1;
tmpStartIdx1 = 	1;
t0_cor = 0.4;%1*-9.62;
fig = figure(200+i_sim);
try
fig.Name = dataFileNames{1};
end
subplot(331)
if onlineFlag
    plot(dataOnLine.time,dataOnLine.algo_NAV_yawd);hold on;
end
if offlineFlag
    plot(dataSim.time(tmpStartIdx1:end),dataSim.yawd(tmpStartIdx1:end));hold on;
end
xlabel('time (s)')
ylabel('yaw [deg]')
grid on;
legend('在线','离线')
subplot(334)
if onlineFlag
    plot(dataOnLine.time,dataOnLine.algo_NAV_pitchd);hold on;
end
if offlineFlag
    plot(dataSim.time(tmpStartIdx1:end),dataSim.pitchd(tmpStartIdx1:end));hold on;
end
xlabel('time (s)')
ylabel('pitch [deg]')
grid on;
legend('在线','离线')
subplot(337)
if onlineFlag
    plot(dataOnLine.time,dataOnLine.algo_NAV_rolld);hold on;
end
if offlineFlag
    plot(dataSim.time(tmpStartIdx1:end),dataSim.rolld(tmpStartIdx1:end));hold on;
end
xlabel('time (s)')
ylabel('roll [deg]')
grid on;
legend('在线','离线')
%% 位置
tempLLA = [dataOnLine.algo_NAV_latd,dataOnLine.algo_NAV_lond,dataOnLine.algo_NAV_alt];
[tempLLA,LL0] = calValidLLA(tempLLA);
posNED_Online = tempLLA;
tempLLA = [IN_SENSOR.ublox1.Lat,IN_SENSOR.ublox1.Lon,IN_SENSOR.ublox1.height];
tempLLA = calValidLLA(tempLLA,LL0(1:2));
tempUbloxLLA = tempLLA;
tempLLA = [IN_SENSOR.um482.Lat,IN_SENSOR.um482.Lon,IN_SENSOR.um482.height];
idxUm482 = find(tempLLA(:,1) ~= 0 & tempLLA(:,2) ~= 0);
tempLLA = calValidLLA(tempLLA(idxUm482,:),LL0(1:2));
tempUm482LLA = tempLLA;
tempLLA = [dataSim.lat,dataSim.lon,dataSim.alt];
tempLLA = calValidLLA(tempLLA,LL0(1:2));
tempOfflineAlgoLLA = tempLLA;
subplot(332)
if onlineFlag
    try
        plot(dataOnLine.time,posNED_Online(:,1));hold on;
    catch
        fprintf('%s.m :posmNED没有绘制\n',mfilename);
    end
end
if offlineFlag
    plot(dataSim.time,tempOfflineAlgoLLA(:,1));hold on;
end
if ubloxFlag % ublox
    plot(IN_SENSOR.ublox1.time,tempUbloxLLA(:,1));hold on;
end
if um482Flag % um482
    plot(IN_SENSOR.um482.time(idxUm482),tempUm482LLA(:,1));hold on;
end
xlabel('time (s)')
ylabel('Pn [m]')
grid on;
legend('在线','离线','ublox','um482')
subplot(335)
if onlineFlag
    try
        plot(dataOnLine.time,posNED_Online(:,2));hold on;
    catch
        fprintf('%s.m :posmNED没有绘制\n',mfilename);
    end
end
if offlineFlag
    plot(dataSim.time,tempOfflineAlgoLLA(:,2));hold on;
end
if ubloxFlag % ublox
    plot(IN_SENSOR.ublox1.time,tempUbloxLLA(:,2));hold on;
end
if um482Flag % um482
    plot(IN_SENSOR.um482.time(idxUm482),tempUm482LLA(:,2));hold on;
end
xlabel('time (s)')
ylabel('Pe [m]')
grid on;
legend('在线','离线','ublox','um482')
subplot(338)
data = dataOnLine.algo_NAV_alt;
tempZeroData = data(data(:,1)==0,:);
data(data(:,1)==0,:) = nan*tempZeroData;
if onlineFlag
    plot(dataOnLine.time,data);hold on;
end
if offlineFlag
    tempheight = -dataSim.posmNED(:,3);
    tempheight(tempheight == 0) = nan;
    plot(dataSim.time,tempheight);hold on;
end
if ubloxFlag % ublox
    plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.height);hold on;
end
if um482Flag % um482
    plot(IN_SENSOR.um482.time,IN_SENSOR.um482.height);hold on;
end
xlabel('time (s)')
ylabel('海拔高度 [m]')
grid on;
legend('在线','离线','ublox','um482')
%% 速度
subplot(333)
if onlineFlag
    plot(dataOnLine.time,dataOnLine.algo_NAV_Vn);hold on;
end
if offlineFlag
    plot(dataSim.time(tmpStartIdx1:end),dataSim.velN(tmpStartIdx1:end));hold on;
end
if ubloxFlag % ublox
    plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velN);hold on;
end
if um482Flag % um482
    plot(IN_SENSOR.um482.time,IN_SENSOR.um482.velN);hold on;
end
xlabel('time (s)')
ylabel('Vn [m/s]')
grid on;
legend('在线','离线','ublox','um482')
subplot(336)
if onlineFlag
    plot(dataOnLine.time,dataOnLine.algo_NAV_Ve);hold on;
end
if offlineFlag
    plot(dataSim.time(tmpStartIdx1:end),dataSim.velE(tmpStartIdx1:end));hold on;
end
if ubloxFlag % ublox
    plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velE);hold on;
end
if um482Flag % um482
    plot(IN_SENSOR.um482.time,IN_SENSOR.um482.velE);hold on;
end
xlabel('time (s)')
ylabel('Ve [m/s]')
grid on;
legend('在线','离线','ublox','um482')
subplot(339)
if onlineFlag
    plot(dataOnLine.time,dataOnLine.algo_NAV_Vd);hold on;
end
if offlineFlag % 离线
    plot(dataSim.time(tmpStartIdx1:end),dataSim.velD(tmpStartIdx1:end));hold on;
end
if ubloxFlag % ublox
    plot(IN_SENSOR.ublox1.time,IN_SENSOR.ublox1.velD);hold on;
end
if um482Flag % um482
    plot(IN_SENSOR.um482.time,IN_SENSOR.um482.velD);hold on;
end
xlabel('time (s)')
ylabel('Vd [m/s]')
grid on;
legend('在线','离线','ublox','um482')

%%
function [tempLLA,LL0] = calValidLLA(tempLLA,LL0)
tempZeroData = tempLLA(tempLLA(:,1)==0,:);
tempLLA(tempLLA(:,1)==0,:) = nan*tempZeroData;
tempZeroNum = size(tempZeroData,1);
try
    LL0 = LL0;
catch
    if tempZeroNum <= size(tempLLA,1) - 1
        LL0 = tempLLA(tempZeroNum+1,1:2);
    else
        LL0 = [0,0,0];
        tempLLA = [0,0,0];
        return;
    end
end
tempLLA(tempZeroNum+1:end,:) = lla2flat(tempLLA(tempZeroNum+1:end,:),LL0,0,0);
end