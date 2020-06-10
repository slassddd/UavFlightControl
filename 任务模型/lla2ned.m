function p = lla2ned(lla, ll0)
% 纬经高转换为NED位置
% lla: 纬度[deg] 经度[deg] 高度[m] 
% ll0: 基准点， 纬度[deg] 经度[deg]
% p: NED位置
p = zeros(1,3);
psi0 = 0;
href = 0;
f = 0.003352810664747;
R = 6378.137e3;
% wrap latitude and longitude if needed
[~, lla(:,1), lla(:,2)] = wraplatitude( lla(:,1), lla(:,2), 'deg' );
[~, ll0(1), ll0(2)] = wraplatitude( ll0(1), ll0(2), 'deg' );

% check and fix angle wrapping in longitude
[~, lla(:,2)] = wraplongitude( lla(:,2), 'deg', '180' );
[~, ll0(2)] = wraplongitude( ll0(2), 'deg', '180' );

dLat = lla(:,1) - ll0(1);
dLon = lla(:,2) - ll0(2);

% wrap latitude and longitude if needed
[~, dLat, dLon] = wraplatitude( dLat', dLon', 'deg' );

% check and fix angle wrapping in longitude
[~, dLon] = wraplongitude( dLon, 'deg', '180' );

rll0 = ll0*pi/180;
rpsi0 = psi0*pi/180;

Rn = R/sqrt(1-(2*f-f*f)*sin(rll0(1))*sin(rll0(1)));
Rm = Rn*((1-(2*f-f*f))/(1-(2*f-f*f)*sin(rll0(1))*sin(rll0(1))));

dNorth = dLat./atan2(1,Rm)*pi/180;
dEast = dLon./atan2(1,Rn*cos(rll0(1)))*pi/180;

p(:,1) = cos(rpsi0)*dNorth + sin(rpsi0)*dEast;
p(:,2) = -sin(rpsi0)*dNorth + cos(rpsi0)*dEast;
p(:,3) = -lla(:,3) - href;
end

function [lat_wrapped, lat, lon] = wraplatitude( lat, lon, units)
% WRAPLATITUDE internal function to check and fix angle wrapping in
% latitude and longitude if needed.

%   Copyright 2007-2013 The MathWorks, Inc.

% Convert units if necessary
if strcmp(units,'deg')
    pideg = 180;
else
    pideg = pi;
end

% Set lat_wrapped flag to false
lat_wrapped = false;

% Re-set latitudes to values between pi and -pi
flat = abs(lat);

if any(flat>pideg)
    lat(flat>pideg) = mod(lat(flat>pideg)+pideg,2*pideg)-pideg;
    % Set lat_wrapped flag to true if necessary
    flat = abs(lat);
    lat_wrapped = true;
end

% Determine if any latitudes need to be wrapped
idx = flat>pideg/2;

if any(idx)
    
    % Adjustments for -pi to pi
    flat = abs(lat);
    latp2 = flat>pideg/2;
    lon(idx) = lon(idx) + pideg;
    lat(latp2) = sign(lat(latp2)).*(pideg/2-(flat(latp2)-pideg/2));
    
    % Set lat_wrapped flag to true if necessary
    lat_wrapped = true;
    
end
end

function [lon_wrapped, lon] = wraplongitude( lon, inputUnits, maxRange )
% WRAPLONGITUDE internal function to check and fix angle wrapping in
% longitude.

%   Copyright 2007-2010 The MathWorks, Inc.

% Convert units if necessary
if strcmp(inputUnits,'deg')
    lon = lon*pi/180;
end

lon_wrapped = false;

switch maxRange
    % Range goes between -pi and pi
    case {'180','pi'}
        idx = lon > pi | lon < -pi;
        if any(idx)
            lon(idx) = rem(lon(idx),2*pi)- (2*pi)*fix(rem(lon(idx),2*pi)/pi);
            lon_wrapped = true;
        end
    % Range goes between 0 and 2*pi
    case {'360','2*pi'}
        idx = lon > 2*pi | lon < 0;
        if any(idx)
            lon(idx) = mod(lon(idx),2*pi);
            lon_wrapped = true;
        end
    otherwise
        % do nothing
end

% Convert units if necessary
if strcmp(inputUnits,'deg')
    lon = lon*180/pi;
end
end