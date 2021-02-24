function SinglePlot_um482(structData)
fprintf('----------------------------------------------\n')
time = structData.time;
children = fieldnames(structData);
nChildren = length(children);
nrow = ceil(sqrt(nChildren));
ncol = ceil(nChildren/nrow);
fig = figure;
fig.Name = mfilename;
ylabelstr = {...
    'time','Lon [deg]','Lat [deg]','height [m]',...
    'velN [m/s]','velE [m/s]','velD [m/s]','delta_lon [m]',...
    'delta_lat [m]','delta_height [m]','pDop','bestpos',...
    'numSv','nChange'};
if nChildren ~= length(ylabelstr)
    error('维数错误');
else
    for i = 1:nChildren
        if ~contains(lower(ylabelstr{i}),lower(children{i}))
            error('变量对应错误') 
        end
    end
end
% idx_nz = (structData.Lon ~= 0);
idx_nz = [1:length(structData.Lon)];
for i = 1:nChildren
    subplot(nrow,ncol,i)
    plot(time(idx_nz),structData.(children{i})(idx_nz));
    grid on;
    xlabel('time (sec)');
    ylabel(ylabelstr{i})
end
i = i + 1;
subplot(nrow,ncol,i)
plot(structData.Lon(idx_nz),structData.Lat(idx_nz));
grid on;
xlabel('Lon [deg]');
ylabel('Lat [deg]');
axis equal
% 显示信息
% BESTPOS = ENUM_BESTPOS(structData.BESTPOS);
if all(structData.BESTPOS <= 16) 
    fprintf('um482:全程单点定位\n')
else
    fprintf('um482:全程出现过固定解定位\n')
end
tmp = 20;
tmpTime = max(time(structData.numSv<tmp));
if isempty(tmpTime)
    fprintf('um482:全程星数大于等于%d\n',tmp);
else
    fprintf('um482:%d秒后星数始终大于等于%d\n',round(tmpTime),tmp);
end