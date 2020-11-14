clear,clc
% 姿态角（body相对world，即world到body）
yaw = 120*pi/180;
pitch = -25*pi/180;
roll = 15*pi/180;
% 
Rx = [1 0 0;0 cos(roll) sin(roll);0 -sin(roll) cos(roll)];
Ry = [cos(pitch) 0 -sin(pitch);0 1 0;sin(pitch) 0 cos(pitch)];
Rz = [cos(yaw) sin(yaw) 0;-sin(yaw) cos(yaw) 0;0 0 1];
%
R = Rx*Ry*Rz; % world到body的转换矩阵，即  Vbody = R*Vworld
%
[r1,r2,r3] = dcm2angle(R,'ZYX');
fprintf('预置姿态角     : roll (%.2f deg) pitch (%.2f deg) yaw (%.2f deg)\n',roll*180/pi,pitch*180/pi,yaw*180/pi);
fprintf('dcm2angle计算值: roll (%.2f deg) pitch (%.2f deg) yaw (%.2f deg)\n',r3*180/pi,r2*180/pi,r1*180/pi);