function T = parserNaviLogData(logData,matchMessages)
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
if ~allBlockName
    idxMatch = [];
    for i = 1:length(matchMessages)
        idxMatch = [idxMatch;find(logDataAll.blockName == matchMessages(i))];
    end
    logDataAll.time_sec = logDataAll.time_sec(idxMatch);
    logDataAll.idx = logDataAll.idx(idxMatch);
    logDataAll.blockName = logDataAll.blockName(idxMatch);
    logDataAll.message = logDataAll.message(idxMatch);
    logDataAll.var1 = logDataAll.var1(idxMatch,:);
end
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
            varname(idxSameTime,:) = setVarName(message);
        end
    else
        if enableSetName
            message = logDataAll.message(idxSameTime);
            varname(idxSameTime,:) = setVarName(message);
        end        
    end
end
% 建立Table
if ~enableSetName
    T = table(logDataAll.time_sec, logDataAll.idx, logDataAll.blockName, logDataAll.message, logDataAll.var1);
    T.Properties.VariableNames = {'记录时间','同时刻序号','模块位置','message','var1'};
else
    T = table(logDataAll.time_sec, logDataAll.idx, logDataAll.blockName, logDataAll.message, ...
        varname(:,1),logDataAll.var1(:,1),...
        varname(:,2),logDataAll.var1(:,2),...
        varname(:,3),logDataAll.var1(:,3),...
        varname(:,4),logDataAll.var1(:,4),...
        varname(:,5),logDataAll.var1(:,5));
    T.Properties.VariableNames = {'记录时间','同时刻序号','模块位置','message',...
        'name1','var1',...
        'name2','var2',...
        'name3','var3',...
        'name4','var4',...
        'name5','var5'};    
end

%% 子函数
function varname = setVarName(message)
nMessage = length(message);
varname = cell(nMessage,5);
for i = 1:nMessage
    thisMessage = message(i);
    switch thisMessage
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Ublox
            varname(i,:) = {'更新周期','健康状态','pdop','星数','速度标准差'};
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Um482
            varname(i,:) = {'更新周期','健康状态','pdop','星数','BESTPOS'};
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Mag
            varname(i,:) = {'更新周期','设备号','健康1','健康2','地磁模值'};           
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Baro
            varname(i,:) = {'更新周期','健康状态','气压高','ublox高','um482高'};                
        otherwise
            varname(i,:) = {' ',' ',' ',' ',' '};
    end
end