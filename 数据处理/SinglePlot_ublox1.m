function SinglePlot_ublox1(structData)
fprintf('----------------------------------------------\n')
time = structData.time;
children = fieldnames(structData);
nChildren = length(children);
nrow = ceil(sqrt(nChildren+2));
ncol = ceil(nChildren/nrow);
fig = figure;
fig.Name = mfilename;
ylabelstr = {'time','velE [m/s]','velN [m/s]','velD [m/s]','Lon [deg]','Lat [deg]','height [m]',...
    'pDop','numSv','hAcc','vAcc','headAcc','sAcc','nChange'};
idx_nz = (structData.Lon ~= 0);
for i = 1:nChildren
    subplot(nrow,ncol,i)
    try
    plot(time(idx_nz),structData.(children{i})(idx_nz));
    end
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
try
plot(structData.Lon(idx_nz),structData.Lat(idx_nz));
end
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