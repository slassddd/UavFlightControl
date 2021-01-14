% 从飞行log中解析航点
[mavPathPoints,homeLLA] = getPathFromFlightData(FlightLog_Original.mavlink_mission_item_def);
% 绘制航点
figure;
subplot(121)
plot(mavPathPoints(:,2),mavPathPoints(:,1));hold on;
plot(homeLLA(:,2),homeLLA(:,1),'ro');hold on;
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