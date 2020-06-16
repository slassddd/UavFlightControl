function [time] = calTimeSeries(tempTime,tempData)
tempTs = tempTime(2:end)-tempTime(1:end-1);
tempTs = round(tempTs,3);
tempTsClass = unique(tempTs);
for i = 1:length(tempTsClass)
    tempN(i) = length(tempTs(tempTs==tempTsClass(i)));
end
[~,maxIdx] = max(tempN);
tempTs = tempTsClass(maxIdx);
%
nData = length(tempData);
kk = round(length(tempTime)/nData);
Ts = kk*tempTs;
time = linspace(0,nData*Ts,nData)+round(tempTime(1),3);