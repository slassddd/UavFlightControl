function heading_rad = calHeadingOfTwoLL(LL0,LL1)
% 计算 LL1 相对 LL0 的角度
% LL0: 原点的纬度、经度[deg]
% LL1: 目标点的纬度、经度[deg]
% -------------------------------
% example:
% calHeadingOfTwoLL([40 179],[41 -179])*57.3
deg2m = 111e3;
rad2deg = 180/pi;
deg2rad = pi/180;
dlat = angdiff(LL0(1)*deg2rad,LL1(1)*deg2rad)*rad2deg;
dlon = angdiff(LL0(2)*deg2rad,LL1(2)*deg2rad)*rad2deg;
dPn = dlat*deg2m;
dPe = dlon*deg2m*cos(LL0(1)*pi/180);
heading_rad = atan2(dPe,dPn);
