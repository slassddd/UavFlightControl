function SingPlot_gpsCompare(um482_structData_IN,ublox_structData_IN)
fprintf('----------------------------------------------\n')
um482_structData.time = um482_structData_IN.time;
um482_structData.Lat = um482_structData_IN.Lat;
um482_structData.Lon = um482_structData_IN.Lon;
um482_structData.height = um482_structData_IN.height;
um482_structData.velN = um482_structData_IN.velN;
um482_structData.velE = um482_structData_IN.velE;
um482_structData.velD = um482_structData_IN.velD;
um482_structData.pDop = um482_structData_IN.pDop;
um482_structData.numSv = um482_structData_IN.numSv;
%% um482 
structData = um482_structData;
time = structData.time;
children = fieldnames(structData);
nChildren = length(children);
nrow = ceil(sqrt(nChildren+2));
ncol = ceil(nChildren/nrow);
fig = figure;
fig.Name = mfilename;
ylabelstr = {'time','velE [m/s]','velN [m/s]','velD [m/s]','Lon [deg]','Lat [deg]','height [m]',...
    'pDop','numSv'};
idx_nz = (structData.Lon ~= 0);
for i = 1:nChildren
    subplot(nrow,ncol,i)
    plot(time(idx_nz),structData.(children{i})(idx_nz));
    hold on;
    grid on;
    xlabel('time (sec)');
    ylabel(ylabelstr{i})
end
% 速度图
i = i + 1;
speed = vecnorm([structData.velN(idx_nz),structData.velE(idx_nz)],2,2);
subplot(nrow,ncol,i)
plot(time(idx_nz),speed);
grid on;
    xlabel('time (sec)');
    ylabel('speed [m/s]')
% 经纬图
i = i + 1;
subplot(nrow,ncol,i)
plot(structData.Lon(idx_nz),structData.Lat(idx_nz));
grid on;
xlabel('Lon [deg]');
ylabel('Lat [deg]');
axis equal
% 显示信息
tmp = 14;
tmpTime = max(time(structData.numSv<tmp));
if isempty(tmpTime)
    fprintf('um482:全程星数大于等于%d\n',tmp);
else
    fprintf('um482:%d秒后星数始终大于等于%d\n',round(tmpTime),tmp);
end

%% ublox
ublox_structData.time = ublox_structData_IN.time;
ublox_structData.Lat = ublox_structData_IN.Lat;
ublox_structData.Lon = ublox_structData_IN.Lon;
ublox_structData.height = ublox_structData_IN.height;
ublox_structData.velN = ublox_structData_IN.velN;
ublox_structData.velE = ublox_structData_IN.velE;
ublox_structData.velD = ublox_structData_IN.velD;
ublox_structData.pDop = ublox_structData_IN.pDop;
ublox_structData.numSv = ublox_structData_IN.numSv;
structData = ublox_structData;
time = structData.time;
children = fieldnames(structData);
nChildren = length(children);
nrow = ceil(sqrt(nChildren+2));
ncol = ceil(nChildren/nrow);
% fig = figure();
fig.Name = mfilename;
ylabelstr = {'time','Lat [deg]','Lon [deg]','height [m]','velE [m/s]','velN [m/s]','velD [m/s]',...
    'pDop','numSv'};
idx_nz = (structData.Lon ~= 0);
for i = 1:nChildren
    subplot(nrow,ncol,i)
    plot(time(idx_nz),structData.(children{i})(idx_nz));
    grid on;
    xlabel('time (sec)');
    ylabel(ylabelstr{i})
end
% 速度图
i = i + 1;
speed = vecnorm([structData.velN(idx_nz),structData.velE(idx_nz)],2,2);
subplot(nrow,ncol,i)
plot(time(idx_nz),speed);hold on;
grid on;
    xlabel('time (sec)');
    ylabel('speed [m/s]')
% 经纬图
i = i + 1;
subplot(nrow,ncol,i)
plot(structData.Lon(idx_nz),structData.Lat(idx_nz));hold on;
grid on;
xlabel('Lon [deg]');
ylabel('Lat [deg]');
axis equal
% 显示信息
tmp = 14;
tmpTime = max(time(structData.numSv<tmp));
if isempty(tmpTime)
    fprintf('ublox1:全程星数大于等于%d\n',tmp);
else
    fprintf('ublox1:%d秒后星数始终大于等于%d\n',round(tmpTime),tmp);
end