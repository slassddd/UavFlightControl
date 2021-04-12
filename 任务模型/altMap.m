function out = altMap(homeLLA,LatLon_deg)
% 高程数据设置
if sum(homeLLA)==0 || sum(LatLon_deg)==0
    out = 0;
    return;
end
lon = LatLon_deg(2);
lonHome = homeLLA(2);
altHome = homeLLA(3);
k = 0.00; % m/m 
out = k*(lon-lonHome)*111e3 + altHome;
% 设置home周围的高程数据，模拟楼宇、树木
dist = distOfTwoLL(homeLLA(1:2),LatLon_deg);
if dist > 50 && dist < 100
    out = altHome + 30;
elseif dist > 30 && dist < 40
    out = altHome;
elseif dist > 20 && dist < 30
    out = altHome + 30;
elseif dist > 10 && dist < 20
    out = altHome + 20;
end