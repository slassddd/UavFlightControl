function T = parserLogData(logData,varargin)
enableBlockSel = false;
enableMessageSel = false;
enableExcludeMessage = false;
decimation = 1;
for i = 1:length(varargin)/2
    switch lower(varargin{2*i-1})
        case 'blockname'
            matchBlock = varargin{2*i};
            enableBlockSel = true;
        case 'messagename'
            matchMessage = varargin{2*i};
            enableMessageSel = true;
        case 'decimation'
            decimation = varargin{2*i};
        case 'exclude'
            enableExcludeMessage = true;
            excludeMessage = varargin{2*i};
    end
end

enableSetName = true;
blockNames = enumeration('ENUM_NaviLogBlockName');
if nargin == 1
    allBlockName = true;
else
    allBlockName = false;
end
nLogData = length(logData);
for i = 1:nLogData
    % 剔除空值
    idxExclude = find(logData(i).idx==0 | logData(i).time_sec==0 );
    idxExclude = find(logData(i).idx==0);
    logData(i).time_sec(idxExclude) = [];
    logData(i).idx(idxExclude) = [];
    logData(i).blockName(idxExclude) = [];
    logData(i).message(idxExclude) = [];
    logData(i).var1(idxExclude,:) = [];
end

logDataAll = logData(1);
for i = 2:nLogData
    logDataAll.time_sec = [logDataAll.time_sec;logData(i).time_sec];
    logDataAll.idx = [logDataAll.idx;logData(i).idx];
    logDataAll.blockName = [logDataAll.blockName;logData(i).blockName];
    logDataAll.message = [logDataAll.message;logData(i).message];
    logDataAll.var1 = [logDataAll.var1;logData(i).var1];
end
% 筛选blockName
if enableBlockSel
    idxMatch = [];
    for i = 1:length(matchBlock)
        idxMatch = [idxMatch;find(logDataAll.blockName == matchBlock(i))];
    end
    logDataAll.time_sec = logDataAll.time_sec(idxMatch);
    logDataAll.idx = logDataAll.idx(idxMatch);
    logDataAll.blockName = logDataAll.blockName(idxMatch);
    logDataAll.message = logDataAll.message(idxMatch);
    logDataAll.var1 = logDataAll.var1(idxMatch,:);
end
% 排除messageName
if enableExcludeMessage
    idxExclude = [];
    for i = 1:length(excludeMessage)
        idxExclude = [idxExclude;find(logDataAll.message == excludeMessage(i))];
    end
    logDataAll.time_sec(idxExclude) = [];
    logDataAll.idx(idxExclude) = [];
    logDataAll.blockName(idxExclude) = [];
    logDataAll.message(idxExclude) = [];
    logDataAll.var1(idxExclude,:) = [];
end
% 筛选messageName
if enableMessageSel
    idxMatch = [];
    for i = 1:length(matchMessage)
        idxMatch = [idxMatch;find(logDataAll.message == matchMessage(i))];
    end
    
    logDataAll.time_sec = logDataAll.time_sec(idxMatch);
    logDataAll.idx = logDataAll.idx(idxMatch);
    logDataAll.blockName = logDataAll.blockName(idxMatch);
    logDataAll.message = logDataAll.message(idxMatch);
    logDataAll.var1 = logDataAll.var1(idxMatch,:);
end
% 抽样
logDataAll.time_sec = logDataAll.time_sec(1:decimation:end);
logDataAll.idx = logDataAll.idx(1:decimation:end);
logDataAll.blockName = logDataAll.blockName(1:decimation:end);
logDataAll.message = logDataAll.message(1:decimation:end);
logDataAll.var1 = logDataAll.var1(1:decimation:end,:);
% 按时间升序
[~,idxSort] = sort(logDataAll.time_sec);
logDataAll.time_sec = logDataAll.time_sec(idxSort);
logDataAll.idx = logDataAll.idx(idxSort);
logDataAll.blockName = logDataAll.blockName(idxSort);
logDataAll.message = logDataAll.message(idxSort);
logDataAll.var1 = logDataAll.var1(idxSort,:);
% 同时刻按idx升序
timeUnique = unique(logDataAll.time_sec);
varname = cell(length(timeUnique),5);
for i = 1:length(timeUnique)
    thisTime = timeUnique(i);
    idxSameTime = find(logDataAll.time_sec == thisTime);
    if length(idxSameTime) > 1
        idxVals = logDataAll.idx(idxSameTime);
        [~,tempIdx] = sort(idxVals);
        [idxSameTimeNew] = idxSameTime(tempIdx);
        %
        logDataAll.time_sec(idxSameTime) = logDataAll.time_sec(idxSameTimeNew);
        logDataAll.idx(idxSameTime) = logDataAll.idx(idxSameTimeNew);
        logDataAll.blockName(idxSameTime) = logDataAll.blockName(idxSameTimeNew);
        logDataAll.message(idxSameTime) = logDataAll.message(idxSameTimeNew);
        logDataAll.var1(idxSameTime,:) = logDataAll.var1(idxSameTimeNew,:);
        if enableSetName
            message = logDataAll.message(idxSameTime);
            varname(idxSameTime,:) = decodeLog(message,logDataAll.var1(idxSameTime,:));
        end
    else
        if enableSetName
            message = logDataAll.message(idxSameTime);
            varname(idxSameTime,:) = decodeLog(message,logDataAll.var1(idxSameTime,:));
        end
    end
end
% 去掉重复项
for i = length(logDataAll.time_sec):-1:2
    if logDataAll.time_sec(i-1) == logDataAll.time_sec(i) && ...
            logDataAll.idx(i-1) == logDataAll.idx(i) && ...
            logDataAll.blockName(i-1) == logDataAll.blockName(i) && ...
            logDataAll.message(i-1) == logDataAll.message(i) && ...
            sum(logDataAll.var1(i-1,:)) == sum(logDataAll.var1(i,:))
        logDataAll.time_sec(i) = [];
        logDataAll.idx(i) = [];
        logDataAll.blockName(i) = [];
        logDataAll.message(i) = [];
        logDataAll.var1(i,:) = [];
        varname(i,:) = [];
    end
end
% 建立Table
if ~enableSetName
    T = table(logDataAll.time_sec, logDataAll.idx, logDataAll.blockName, logDataAll.message, logDataAll.var1);
    T.Properties.VariableNames = {'记录时间','同时刻序号','模块位置','message','var1'};
else
    T = table(logDataAll.time_sec, logDataAll.idx, logDataAll.blockName, logDataAll.message, ...
        varname(:,1),varname(:,2),varname(:,3),varname(:,4),varname(:,5),logDataAll.var1);
    T.Properties.VariableNames = {'记录时间','同时刻序号','模块位置','message',...
        'name1','name2','name3','name4','name5','var1'};
end

%% 子函数
function varname = decodeLog(message,vars)
[varname,isFind] = decodeLog_Navi(message,vars);
if ~isFind
    varname = decodeLog_Task(message,vars);
end