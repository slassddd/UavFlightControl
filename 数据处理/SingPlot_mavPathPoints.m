data = SL.mavlink_mission_item_def;
nData = length(data.seq);
lat_pathpoint = data.x;
lon_pathpoint = data.y;
height_pathpoint = data.z;
num_pathpoint = data.seq;

idx_pathpoint = 0;
idx_home = 0;
for i = 1:nData
    thisSeq = num_pathpoint(i);
    thisLLH = [lat_pathpoint(i),lon_pathpoint(i),height_pathpoint(i)];
    if thisSeq ~= 0 || ...
            (thisSeq == 0 && ~all(thisLLH==0))
        mavPathPoints(thisSeq+1,:) = thisLLH;
    end
    if thisSeq == 0 && norm(thisLLH) ~= 0
        idx_home = idx_home + 1;
        homeLLA(idx_home,:) = thisLLH;
    end
end
homeLLA = unique(homeLLA,'rows');
figure;
plot(homeLLA(:,2),homeLLA(:,1),'ro');hold on;
xlabel('lon');
ylabel('lat');
grid on;
axis equal

%% 绘制航点
figure;
subplot(121)
plot(mavPathPoints(:,2),mavPathPoints(:,1));
grid on;
xlabel('lon')
ylabel('lat')
axis equal
subplot(122)
plot3(mavPathPoints(:,2),mavPathPoints(:,1),mavPathPoints(:,3));
grid on;
xlabel('lon')
ylabel('lat')
zlabel('height')