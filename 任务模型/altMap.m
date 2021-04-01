function out = altMap(homeLLA,LatLon_deg)
% 高程数据设置
if sum(homeLLA)==0 || sum(LatLon_deg)==0
    out = 0;
    return;
end
lon = LatLon_deg(2);
lonHome = homeLLA(2);
altHome = homeLLA(3);
k = 0.1; % m/m 
out = k*(lon-lonHome)*111e3 + altHome;