% 绘制地图信息

uif = uifigure;
g = geoglobe(uif);
lat_geo = sensors.Algo_sl.algo_NAV_lat;
lon_geo = sensors.Algo_sl.algo_NAV_lon;
alt_geo = sensors.Algo_sl.algo_NAV_alt;
idxNoZero = lat_geo==0;
lat_geo(idxNoZero) = [];
lon_geo(idxNoZero) = [];
alt_geo(idxNoZero) = [];
geoplot3(g,lat_geo,lon_geo,alt_geo,'y','HeightReference','geoid', ...
    'LineWidth',3)

uif.WindowButtonDownFcn = @callback_WindowButtonDownFcn;



function callback_WindowButtonDownFcn(~,~)
    disp('1')
end