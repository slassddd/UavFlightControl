function out = addStructDataTime(in,baseTime)
nBaseTime = length(baseTime);
childNames = fieldnames(in);
nChild = length(childNames);
fprintf('-----为结构体成员增加时间戳( %s.m )-----\n',mfilename)
for i = 1:nChild    
    thisChildName = childNames{i};
    fprintf('\t\t正在处理子成员\t%s\n',thisChildName)
    thisVar = in.(thisChildName);
    if isstruct(thisVar)
        child2Name = fieldnames(thisVar);
        tempLen0 = length(thisVar.(child2Name{1}));
        for j = 2:length(child2Name)
            tempLen = length(thisVar.(child2Name{j}));
            if tempLen < tempLen0
                thisVar.(child2Name{j})(end+1) = thisVar.(child2Name{j})(end);
            elseif tempLen > tempLen0
                thisVar.(child2Name{j})(end) = [];
            end
            errLen = abs(tempLen-tempLen0);
            if errLen > 2
                fprintf('\t\t同一结构体中不同成员间length差大于2（%d）,请检查\n',errLen);
            end
        end
        childchild1st = child2Name{1};
        childchild1st = thisVar.(childchild1st);
        nChildchild1st = length(childchild1st);
        ratio = round(nBaseTime/nChildchild1st);
        thisVar.time_cal = baseTime(1:ratio:end);
        if length(thisVar.time_cal) > length(childchild1st)
            thisVar.time_cal(end) = [];
        elseif length(thisVar.time_cal) < length(childchild1st)
            thisVar.time_cal(end+1) = thisVar.time_cal(end) + thisVar.time_cal(end)-thisVar.time_cal(end-1);
        end
        in.(thisChildName) = thisVar;
    else
        nChild = length(thisVar);
        ratio = round(nBaseTime/nChild);
        in.time_cal = baseTime(1:ratio:end);
    end
end
out = in;
fprintf('-----      END      -----\n')