function SinglePlot_FlightPerformance(structData)
fprintf('----------------------------------------------\n')
try
    time = structData.time;
catch
    time = structData.time; 
end
children = fieldnames(structData);
% 去掉时间子项
idx = strcmp(children,'time'); 
children(idx) = [];
%
nChildren = length(children);
nrow = ceil(sqrt(nChildren+2));
ncol = ceil(nChildren/nrow);
fig = figure;
fig.Name = mfilename;
ylabelstr = {'isAbleToCompleteTask','flagGoHomeNow','remainDistToGo_m [m]','remainTimeToSpend_sec [sec]','remainPowerWhenFinish_per [%]'...
    ,'economicAirspeed [m/s]','remainPathPoint',...
    'batteryLifeToCompleteTask [%]','batterylifeNeededToHome [%]','batterylifeNeededToLand [%]','time [sec]'};
idx_nz = find(~isnan(time));
for i = 1:nChildren
    subplot(nrow,ncol,i)
    nData = length(structData.(children{i}));
    if nData < 2/3*length(idx_nz)
        try
            plot(time(idx_nz(1:2:end)),structData.(children{i}));
        end
    else
        try
            plot(time(idx_nz),structData.(children{i})(idx_nz));
        catch
            plot(structData.(children{i}));d
        end        
    end

    grid on;
    xlabel('time (sec)');
    ylabel(ylabelstr{i})
end
% 显示信息
% tmp = 14;
% tmpTime = max(time(structData.numSv<tmp));
% if isempty(tmpTime)
%     fprintf('ublox1:全程星数大于等于%d\n',tmp);
% else
%     fprintf('ublox1:%d秒后星数始终大于等于%d\n',round(tmpTime),tmp);
% end