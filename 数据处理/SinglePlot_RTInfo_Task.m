function SinglePlot_RTInfo_Task(baseTime,structData)
fprintf('----------------------------------------------\n')
time = calTimeSeries(baseTime,structData.BatteryStatus);
children = fieldnames(structData);
nChildren = length(children);
nrow = ceil(sqrt(nChildren));
ncol = ceil(nChildren/nrow);
fig = figure;
fig.Name = mfilename;
ylabelstr = children;
typeCells = {
    'ENUM_RTInfo_Task','ENUM_RTInfo_PayLoad','ENUM_RTInfo_GSCmd','ENUM_RTInfo_Warn',...
    'ENUM_ComStatus','ENUM_RTInfo_Fense','ENUM_RTInfo_Stall','ENUM_RTInfo_SensorHealth',...
    'ENUM_BatteryStatus','ENUM_RTInfo_FixHeight','ENUM_FindWind','boolean','boolean','boolean','double','double','double'};
if length(typeCells) ~= nChildren
    warning('维数错误');
end
for i = 1:nChildren
    subplot(nrow,ncol,i)
    if length(time)>length(structData.(children{i}))
        data = [structData.(children{i});structData.(children{i})(end)];
    elseif length(time)<length(structData.(children{i}))
        data = structData.(children{i})(1:end-1);
    else
        data = structData.(children{i});
    end
    str = sprintf('%s(data)',typeCells{i});    
    if strcmp(typeCells{i},'ENUM_RTInfo_Task')
        continue;
    end
    try
        data = eval(str);
        plotEnum(time,data)
    catch ME
        ME
    end 
    grid on;
    xlabel('time (sec)');
    title(children{i})
end

