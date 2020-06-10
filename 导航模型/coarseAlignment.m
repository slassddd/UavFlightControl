function [alignmentComplete,refloc,eulerd0,quat0,acc_bias0,dw0,mag0,pos0,alt0,range0,...
          std_acc,std_gyro, std_mag, std_lla, std_gpsvel, std_alt, std_range] = ...
            coarseAlignment(i,accel,gyro,mag,lla,gpsvel,alt,range,...
            imuUpdateFs,magUpdateFs,gpsUpdateFs,baroUpdateFs,radarUpdateFs)
global eulerd_buffer lla_buffer gpsvel_buffer acc_buffer gyro_buffer mag_buffer alt_buffer...
    range_buffer quat_buffer step_coarseAlignment
staticTime = 5; % second
nIMUdata = staticTime*imuUpdateFs;
bufferSize = 100;
stepSpace = nIMUdata/bufferSize;
flag = 9999;
fs = imuUpdateFs;
if isempty(acc_buffer)
    eulerd_buffer = flag*ones(bufferSize,3);
    lla_buffer = flag*ones(bufferSize,3);
    acc_buffer = flag*ones(bufferSize,3);
    gyro_buffer = flag*ones(bufferSize,3);
    mag_buffer = flag*ones(bufferSize,3);
    alt_buffer = flag*ones(1,bufferSize);
    range_buffer = flag*ones(1,bufferSize);
    quat_buffer = flag*ones(bufferSize,4);
    gpsvel_buffer = flag*ones(bufferSize,3);
end
acc_buffer(1:bufferSize-1,:) = acc_buffer(2:bufferSize,:);
acc_buffer(bufferSize,:) = accel;
gyro_buffer(1:bufferSize-1,:) = gyro_buffer(2:bufferSize,:);
gyro_buffer(bufferSize,:) = gyro;
if rem(i,fs/gpsUpdateFs) == 0 && i ~= 1
    lla_buffer(1:bufferSize-1,:) = lla_buffer(2:bufferSize,:);
    lla_buffer(bufferSize,:) = lla;
    gpsvel_buffer(1:bufferSize-1,:) = gpsvel_buffer(2:bufferSize,:);
    gpsvel_buffer(bufferSize,:) = gpsvel;
end
if rem(i,fs/magUpdateFs) == 0 && i ~= 1
    mag_buffer(1:bufferSize-1,:) = mag_buffer(2:bufferSize,:);
    mag_buffer(bufferSize,:) = mag;
    quat_buffer(1:bufferSize-1,:) = quat_buffer(2:bufferSize,:);
    quat_buffer(bufferSize,:) = compact(ecompass(accel,mag));
    eulerd_buffer(1:bufferSize-1,:) = eulerd_buffer(2:bufferSize,:);
    eulerd_buffer(bufferSize,:) = eulerd(quat_buffer(bufferSize,:));
end
if rem(i,fs/baroUpdateFs) == 0 && i ~= 1
    alt_buffer(1:bufferSize-1) = alt_buffer(2:bufferSize);
    alt_buffer(bufferSize) = alt;
end
if rem(i,fs/radarUpdateFs) == 0 && i ~= 1
    range_buffer(1:bufferSize-1) = range_buffer(2:bufferSize);
    range_buffer(bufferSize) = range;
end


alignmentComplete = 0;
acc_bias0 = zeros(1,3);
dw0 = zeros(1,3);
mag0 = zeros(1,3);
pos0 = zeros(1,3);
alt0 = 0;
range0 = 0;
eulerd0 = zeros(1,3);
quat0 = zeros(1,4);
std_acc = zeros(1,3);
std_gyro = zeros(1,3);
std_mag = zeros(1,3);
std_lla = zeros(1,3);
std_gpsvel = zeros(1,3);
std_alt = zeros(1,1);
std_range = zeros(1,1);
refloc = zeros(1,3);
if std(eulerd_buffer(:,1)) < 5 && std(eulerd_buffer(:,2)) < 5 && std(eulerd_buffer(:,3)) < 5 &&...
        abs(mean(eulerd_buffer(:,1))) < 400 && abs(mean(eulerd_buffer(:,2))) < 400 && abs(mean(eulerd_buffer(:,3)) < 400) &&...
        abs(mean(alt_buffer)) < 2 % 高度稳定要求
    alignmentComplete = 1;
    acc_bias0 = mean(acc_buffer);
    dw0 = mean(gyro_buffer);
    alt0 = mean(alt_buffer);
    pos0 = mean(lla_buffer); % LLA (deg deg m)
    pos0(3) = alt0;
    range0 = mean(range_buffer);
    eulerd0 = mean(eulerd_buffer);
    quat0 = mean(quat_buffer);
    mag0 = rotateframe(conj(quaternion(quat0)),mean(mag_buffer));
    std_acc = std(acc_buffer);
    std_gyro = std(gyro_buffer);
    std_mag = std(mag_buffer);
    temp = std(lla_buffer);
    std_lla = [111e3*cos(pi/180*pos0(1)),111e3,1].*temp;
    std_gpsvel = std(gpsvel_buffer);
    std_alt = std(alt_buffer);
    std_range = std(range_buffer);
    
    refloc = pos0;
end
end


function eout = eulerd(quat)
% rotate 'ZYX'
qa = quat(1);
qb = quat(2);
qc = quat(3);
qd = quat(4);
the1 = 1;
the2 = 2;

tmp = qb.*qd.*the2 - qa.*qc.*the2;
if tmp > the1
    tmp = the1;
else 
    tmp = -the1;
end
% tmp(tmp > the1) = the1;
% tmp(tmp < -the1) = -the1;
b = -asin(tmp);
a = atan2((qa.*qd.*the2 + qb.*qc.*the2),(qa.^2.*the2 - the1 + qb.^2.*the2));
c = atan2((qa.*qb.*the2 + qc.*qd.*the2),(qa.^2.*the2 - the1 + qd.^2.*the2));
eout = [a b c]*180/pi;
end