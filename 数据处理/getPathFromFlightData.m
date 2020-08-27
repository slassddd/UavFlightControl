function [path,home] = getPathFromFlightData(data)
%% 从飞行log中解析航点
% [path,home] = getPathFromFlightData(SL.mavlink_mission_item_def)
nData = length(data.seq);
lat_pathpoint = data.x;
lon_pathpoint = data.y;
height_pathpoint = data.z;
num_pathpoint = data.seq;

idx_home = 0;
for i = 1:nData
    thisSeq = num_pathpoint(i);
    thisLLH = [lat_pathpoint(i),lon_pathpoint(i),height_pathpoint(i)];
    if thisSeq ~= 0 || ...
            (thisSeq == 0 && ~all(thisLLH==0))
        path(thisSeq+1,:) = thisLLH;
    end
    if thisSeq == 0 && norm(thisLLH) ~= 0
        idx_home = idx_home + 1;
        home(idx_home,:) = thisLLH;
    end
end
home = unique(home,'rows');