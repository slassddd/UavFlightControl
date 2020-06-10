function out = NAVI_calMagneticDec(varargin)
% 计算磁偏角插值数据
decimal_year = 2020;
if nargin == 1
    decimal_year = varargin{1};
end
model_epoch = '2015v2';
step = 10;
geod_lat = [0:step:60];
geod_lon = [70:step:130];
height = 0;
magDec = zeros(length(geod_lat),length(geod_lon));
for latIdx = 1:length(geod_lat)
    for lonIdx = 1:length(geod_lon)
        [~, ~, magDec(latIdx,lonIdx)] = wrldmagm(height, geod_lat(latIdx),geod_lon(lonIdx), decimal_year, model_epoch);
    end
end
out.lat = geod_lat;
out.lon = geod_lon;
out.height = height;
out.magDec = magDec;
% TEST
if 0
    decimal_year = 2020;
    out = NAVI_calMagneticDec(decimal_year);
    step = 5;
    geod_lat = [0:step:60];
    geod_lon = [70:step:130];
    height = 0;
    magDec = zeros(length(geod_lat),length(geod_lon));
    for latIdx = 1:length(geod_lat)
        for lonIdx = 1:length(geod_lon)
            [~, ~, magDec(latIdx,lonIdx)] = wrldmagm(height, geod_lat(latIdx),geod_lon(lonIdx), decimal_year, '2015v2');
        end
    end
    [lat0,lon0] = meshgrid(out.lat,out.lon);
    [lat1,lon1] = meshgrid(geod_lat,geod_lon);
    magDec_interp = interpn(lon0,lat0,out.magDec',lon1,lat1);
    mesh((magDec-magDec_interp'));
    xlabel('lat (deg)');
    ylabel('lon (deg)');
    zlabel('magDec interp error (deg)');
end