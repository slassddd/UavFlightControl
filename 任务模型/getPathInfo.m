function [pathdata,pathtype] = getPathInfo(data)
for i = 1:size(data,1)
    if data.message(i) == ENUM_RTInfo_Task.PathFollow_PathPointInfo
        pathIdx = str2num(data.name1{i});
        pathdata(pathIdx,:) = [str2num(data.name3{i}),str2num(data.name4{i}),str2num(data.name5{i})];
        pathtype(pathIdx,1) = str2num(data.name2{i});
    end
end
