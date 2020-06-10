function [data_time,data,idx] = timeCut(base_time,data_time,data)
idx = data_time<base_time(1);
data_time(idx) = [];
data(idx,:) = [];
out = data;