function [dLat,dLon,dPosX,dPosY] = calDLatLonOfRotateCenterFromCurPos(curLL,heading,turnR,varargin)
if length(varargin) == 1
    flag = varargin{1};
else
    flag = 'right'; 
end
switch lower(flag)
    case 'left'
        R = rotZ(heading-pi/2);
    otherwise
        R = rotZ(heading+pi/2);
end
centerPos = R'*[turnR;0;0]; % 相对于无人机的位置
deg2m = 6378e3*2*pi/360;
dLon = 1/deg2m*centerPos(2)/cos(curLL(1)*pi/180);
dLat = 1/deg2m*centerPos(1);
dPosX = centerPos(1);
dPosY = centerPos(2);

function R = rotZ(yaw)
R = [cos(yaw) sin(yaw) 0;
    -sin(yaw) cos(yaw) 0;
     0        0        1;];