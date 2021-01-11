%% 数据解码
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SYSTEM
temp=reshape([data(:,251:254)'],1,[]);
SYSTEM.save_time=double(typecast(uint8(temp),'uint32')')*1e-3;
temp=reshape([data(index_40,255:256)'],1,[]);
SYSTEM.FC_VERSION=typecast(uint8(temp),'uint16');

IN_SENSOR.time=save_time;
IN_SENSOR.IMU1.time=save_time;
IN_SENSOR.IMU2.time=save_time(1:4:end);
IN_SENSOR.IMU3.time=save_time(1:4:end);
IN_SENSOR.IMU1_Control.time=save_time(1:2:end);
IN_SENSOR.baro1.time=save_time(1:2:end);
IN_SENSOR.mag1.time=save_time(1:4:end);
IN_SENSOR.mag2.time = IN_SENSOR.mag1.time;
IN_SENSOR.radar1.time = save_time(1:4:end);
IN_SENSOR.ublox1.time = save_time(1:4:end);
IN_SENSOR.um482.time = save_time(1:4:end);
IN_SENSOR.IMU1_0.time = IN_SENSOR.IMU1.time;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU1
% 原始数据
% /* |@@IMUData@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,1)==0),3:6)'],1,[]);
IN_SENSOR.IMU1_0.accel_x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
temp = reshape([data(find(mod(Count,1)==0),7:10)'],1,[]);
IN_SENSOR.IMU1_0.accel_y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
temp = reshape([data(find(mod(Count,1)==0),11:14)'],1,[]);
IN_SENSOR.IMU1_0.accel_z=double(typecast(uint8(temp),'single')')/1*1.0000000000;
temp = reshape([data(find(mod(Count,1)==0),15:18)'],1,[]);
IN_SENSOR.IMU1_0.gyro_x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
temp = reshape([data(find(mod(Count,1)==0),19:22)'],1,[]);
IN_SENSOR.IMU1_0.gyro_y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
temp = reshape([data(find(mod(Count,1)==0),23:26)'],1,[]);
IN_SENSOR.IMU1_0.gyro_z=double(typecast(uint8(temp),'single')')/1*1.0000000000;

IN_SENSOR.IMU1_0.nChange = zeros(size(IN_SENSOR.IMU1_0.accel_x));
if sum(IN_SENSOR.IMU1_0.nChange) == 0
    disp('IMU1_0 的 nChange 没有正常赋值');
end
% 早期版本log存储的IMU数据为IMU坐标系下IMU测量，后期将log改为体坐标系下的IMU测量
if mean(IN_SENSOR.IMU1_0.accel_z) > 0
    % 对老版本数据进行坐标转换，由IMU坐标系转换到体坐标系
    disp('特别注意这里对IMU1_Control正负号的特别处理')
    keyboard
    IN_SENSOR.IMU1_0.accel_y = - IN_SENSOR.IMU1_0.accel_y;
    IN_SENSOR.IMU1_0.accel_z = - IN_SENSOR.IMU1_0.accel_z;
    IN_SENSOR.IMU1_0.gyro_y = -IN_SENSOR.IMU1_0.gyro_y;
    IN_SENSOR.IMU1_0.gyro_z = -IN_SENSOR.IMU1_0.gyro_z;
end
% 1ms滤波
temp = reshape([data(1:1:end,27:28)'],1,[]);
IN_SENSOR.IMU1.accel_x = double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(1:1:end,29:30)'],1,[]);
IN_SENSOR.IMU1.accel_y = double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(1:1:end,31:32)'],1,[]);
IN_SENSOR.IMU1.accel_z = double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(1:1:end,33:34)'],1,[]);
IN_SENSOR.IMU1.gyro_x = double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(1:1:end,35:36)'],1,[]);
IN_SENSOR.IMU1.gyro_y = double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(1:1:end,37:38)'],1,[]);
IN_SENSOR.IMU1.gyro_z = double(typecast(uint8(temp),'int16')')/32768*17.5000000000;

IN_SENSOR.IMU1.nChange = zeros(size(IN_SENSOR.IMU1.accel_x));
if sum(IN_SENSOR.IMU1.nChange) == 0
    disp('IMU1 的 nChange 没有正常赋值');
end
% 早期版本log存储的IMU数据为IMU坐标系下IMU测量，后期将log改为体坐标系下的IMU测量
if mean(IN_SENSOR.IMU1.accel_z) > 0
    % 对老版本数据进行坐标转换，由IMU坐标系转换到体坐标系
    disp('特别注意这里对IMU1正负号的特别处理')
    keyboard
    IN_SENSOR.IMU1.accel_y = - IN_SENSOR.IMU1.accel_y;
    IN_SENSOR.IMU1.accel_z = - IN_SENSOR.IMU1.accel_z;
    IN_SENSOR.IMU1.gyro_y = -IN_SENSOR.IMU1.gyro_y;
    IN_SENSOR.IMU1.gyro_z = -IN_SENSOR.IMU1.gyro_z;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU2
temp = reshape([data(find(mod(Count,4)==1),277:278)'],1,[]);
IN_SENSOR.IMU2.accel_x=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(find(mod(Count,4)==1),279:280)'],1,[]);
IN_SENSOR.IMU2.accel_y=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(find(mod(Count,4)==1),281:282)'],1,[]);
IN_SENSOR.IMU2.accel_z=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(find(mod(Count,4)==1),283:284)'],1,[]);
IN_SENSOR.IMU2.gyro_x=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(find(mod(Count,4)==1),285:286)'],1,[]);
IN_SENSOR.IMU2.gyro_y=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(find(mod(Count,4)==1),287:288)'],1,[]);
IN_SENSOR.IMU2.gyro_z=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;

IN_SENSOR.IMU2.nChange = zeros(size(IN_SENSOR.IMU2.accel_x));
if sum(IN_SENSOR.IMU2.nChange) == 0
    disp('IMU2 的 nChange 没有正常赋值');
end
% 早期版本log存储的IMU数据为IMU坐标系下IMU测量，后期将log改为体坐标系下的IMU测量
if mean(IN_SENSOR.IMU2.accel_z) > 0
    % 对老版本数据进行坐标转换，由IMU坐标系转换到体坐标系
    disp('特别注意这里对IMU2正负号的特别处理')
    keyboard
    IN_SENSOR.IMU2.accel_y = - IN_SENSOR.IMU2.accel_y;
    IN_SENSOR.IMU2.accel_z = - IN_SENSOR.IMU2.accel_z;
    IN_SENSOR.IMU2.gyro_y = -IN_SENSOR.IMU2.gyro_y;
    IN_SENSOR.IMU2.gyro_z = -IN_SENSOR.IMU2.gyro_z;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU3
temp = reshape([data(find(mod(Count,4)==2),277:278)'],1,[]);
IN_SENSOR.IMU3.accel_x=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(find(mod(Count,4)==2),279:280)'],1,[]);
IN_SENSOR.IMU3.accel_y=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(find(mod(Count,4)==2),281:282)'],1,[]);
IN_SENSOR.IMU3.accel_z=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(find(mod(Count,4)==2),283:284)'],1,[]);
IN_SENSOR.IMU3.gyro_x=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(find(mod(Count,4)==2),285:286)'],1,[]);
IN_SENSOR.IMU3.gyro_y=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(find(mod(Count,4)==2),287:288)'],1,[]);
IN_SENSOR.IMU3.gyro_z=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;

IN_SENSOR.IMU3.nChange = zeros(size(IN_SENSOR.IMU3.accel_x));
if sum(IN_SENSOR.IMU3.nChange) == 0
    disp('IMU3 的 nChange 没有正常赋值');
end
% 早期版本log存储的IMU数据为IMU坐标系下IMU测量，后期将log改为体坐标系下的IMU测量
if mean(IN_SENSOR.IMU3.accel_z) > 0
    % 对老版本数据进行坐标转换，由IMU坐标系转换到体坐标系
    disp('特别注意这里对IMU3正负号的特别处理')
    keyboard
    IN_SENSOR.IMU3.accel_y = - IN_SENSOR.IMU3.accel_y;
    IN_SENSOR.IMU3.accel_z = - IN_SENSOR.IMU3.accel_z;
    IN_SENSOR.IMU3.gyro_y = -IN_SENSOR.IMU3.gyro_y;
    IN_SENSOR.IMU3.gyro_z = -IN_SENSOR.IMU3.gyro_z;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU4
IN_SENSOR.IMU4 = IN_SENSOR.IMU3;
disp('IMU4 为正常赋值，暂用IMU3作为数据源');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%baro1
temp=reshape([data(index_21,41:42)'],1,[]);
IN_SENSOR.baro1.alt_baro = double(typecast(uint8(temp),'int16')')/32768*2000;
temp=reshape([data(index_21,43:44)'],1,[]);
temperature=double(typecast(uint8(temp),'int16')')/32768*100;
temp=reshape([data(index_21,45:46)'],1,[]);
pressure=double(typecast(uint8(temp),'int16')')/32768*1100;
temp=reshape([data(index_21,47:48)'],1,[]);
temperature_gs=double(typecast(uint8(temp),'int16')')/32768*1100;
temp=reshape([data(index_21,49:50)'],1,[]);
pressure_gs=double(typecast(uint8(temp),'int16')')/32768*1100;

IN_SENSOR.baro1.nChange = zeros(size(IN_SENSOR.baro1.alt_baro));
if sum(IN_SENSOR.baro1.nChange) == 0
    disp('baro1 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mag
% mag1
temp=reshape([data(index_40,109:110)'],1,[]);
mag1_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_40,111:112)'],1,[]);
mag1_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_40,113:114)'],1,[]);
mag1_z=double(typecast(uint8(temp),'int16')')/32768*2;
mag1_x_forCalib = mag1_x;
mag1_y_forCalib = mag1_y;
mag1_z_forCalib = mag1_z;

tmp = mag1_x;
mag1_x = -mag1_y;
mag1_y = -tmp;
mag1_z = -mag1_z;
% mag2
temp=reshape([data(index_40,115:116)'],1,[]);
mag2_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_40,117:118)'],1,[]);
mag2_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_40,119:120)'],1,[]);
mag2_z=double(typecast(uint8(temp),'int16')')/32768*2;
mag2_x_forCalib = mag2_x;
mag2_y_forCalib = mag2_y;
mag2_z_forCalib = mag2_z;

tmp = mag2_x;
mag2_x = -mag2_y;
mag2_y = -tmp;
mag2_z = -mag2_z;
% mag3
temp=reshape([data(index_40,121:122)'],1,[]);
mag3_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_40,123:124)'],1,[]);
mag3_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_40,125:126)'],1,[]);
mag3_z=double(typecast(uint8(temp),'int16')')/32768*2;
tmp = mag3_x;
mag3_x = -mag3_y;
mag3_y = -tmp;
mag3_z = -mag3_z;
%     % mag1 correct
temp=reshape([data(index_21,191:192)'],1,[]);
mag2calib_x_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_21,193:194)'],1,[]);
mag2calib_y_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_21,195:196)'],1,[]);
mag2calib_z_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
mag2calib_x_magFrame=mag2calib_x_magFrame(1:2:end);
mag2calib_y_magFrame=mag2calib_y_magFrame(1:2:end);
mag2calib_z_magFrame=mag2calib_z_magFrame(1:2:end);
mag2calib_x = -mag2calib_y_magFrame;
mag2calib_y = -mag2calib_x_magFrame;
mag2calib_z = -mag2calib_z_magFrame;

temp=reshape([data(index_21,167:168)'],1,[]);
mag1calib_x_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_21,169:170)'],1,[]);
mag1calib_y_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(index_21,171:172)'],1,[]);
mag1calib_z_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
mag1calib_x_magFrame=mag1calib_x_magFrame(1:2:end);
mag1calib_y_magFrame=mag1calib_y_magFrame(1:2:end);
mag1calib_z_magFrame=mag1calib_z_magFrame(1:2:end);
mag1calib_x = -mag1calib_y_magFrame;
mag1calib_y = -mag1calib_x_magFrame;
mag1calib_z = -mag1calib_z_magFrame;

IN_SENSOR.mag1.mag_x = mag1calib_x_magFrame;
IN_SENSOR.mag1.mag_y = mag1calib_y_magFrame;
IN_SENSOR.mag1.mag_z = mag1calib_z_magFrame;
IN_SENSOR.mag1.nChange = zeros(size(IN_SENSOR.mag1.mag_x));
if sum(IN_SENSOR.mag1.nChange) == 0
    disp('mag1 的 nChange 没有正常赋值');
end

IN_SENSOR.mag2.mag_x = mag2calib_x_magFrame;
IN_SENSOR.mag2.mag_y = mag2calib_y_magFrame;
IN_SENSOR.mag2.mag_z = mag2calib_z_magFrame;
IN_SENSOR.mag2.nChange = zeros(size(IN_SENSOR.mag2.mag_x));
if sum(IN_SENSOR.mag2.nChange) == 0
    disp('mag2 的 nChange 没有正常赋值');
end
% IN_SENSOR.mag2.mag_x = mag2_x_forCalib;
% IN_SENSOR.mag2.mag_y = mag2_y_forCalib;
% IN_SENSOR.mag2.mag_z = mag2_z_forCalib;
%     plot([mag1_x,mag1_y,mag1_z]);hold on;
%     plot([mag2calib_x,mag2calib_y,mag2calib_z]);hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%radar
temp=reshape([data(index_43,117)'],1,[]);
IN_SENSOR.radar1.SNR = uint8(temp');
temp=reshape([data(index_43,118)'],1,[]);
IN_SENSOR.radar1.Flag = uint8(temp');
temp = reshape([data(find(mod(Count,4)==3),119:120)'],1,[]);
IN_SENSOR.radar1.Range = double(typecast(uint8(temp),'int16')')/1*0.0100000000;
IN_SENSOR.radar1.nChange = zeros(size(IN_SENSOR.radar1.SNR));
if sum(IN_SENSOR.radar1.nChange) == 0
    disp('radar1 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ublox
temp=reshape([data(index_41,109:112)'],1,[]);
ublox_iTOW=double(typecast(uint8(temp),'int32')');
temp=reshape([data(index_41,113:116)'],1,[]);
IN_SENSOR.ublox1.velE=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(index_41,117:120)'],1,[]);
IN_SENSOR.ublox1.velN=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(index_41,121:124)'],1,[]);
IN_SENSOR.ublox1.velD=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(index_41,125:128)'],1,[]);
IN_SENSOR.ublox1.Lon=double(typecast(uint8(temp),'int32')')*1e-7;
temp=reshape([data(index_41,129:132)'],1,[]);
IN_SENSOR.ublox1.Lat=double(typecast(uint8(temp),'int32')')*1e-7;
temp=reshape([data(index_41,133:136)'],1,[]);
IN_SENSOR.ublox1.height=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(index_40,127:128)'],1,[]);
IN_SENSOR.ublox1.pDop=double(typecast(uint8(temp),'uint16')')*1e-2;
temp=reshape([data(index_40,129)'],1,[]);
IN_SENSOR.ublox1.numSv=typecast(uint8(temp),'uint8')';
temp = reshape([data(find(mod(Count,4)==0),131:134)'],1,[]);
hAcc=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.ublox1.hAcc = hAcc; % create struct
temp = reshape([data(find(mod(Count,8)==1),197:200)'],1,[]);
vAcc=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.ublox1.vAcc = vAcc; % create struct
temp = reshape([data(find(mod(Count,8)==1),201:204)'],1,[]);
headAcc=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.ublox1.headAcc = headAcc; % create struct
temp = reshape([data(find(mod(Count,8)==1),205:208)'],1,[]);
sAcc=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.ublox1.sAcc = sAcc; % create struct
IN_SENSOR.ublox1.nChange = zeros(size(IN_SENSOR.ublox1.velE));
if sum(IN_SENSOR.ublox1.nChange) == 0
    disp('ublox1 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% um482
% temp = reshape([data(1:1:end,239:242)'],1,[]);
% lon=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.Lon = lon; % create struct
% temp = reshape([data(1:1:end,257:260)'],1,[]);
% lat=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.Lat = lat; % create struct
% temp = reshape([data(1:1:end,261:264)'],1,[]);
% height=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.height = height; % create struct
% temp = reshape([data(1:1:end,265:268)'],1,[]);
% velN=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.velN = velN; % create struct
% temp = reshape([data(1:1:end,269:272)'],1,[]);
% velE=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.velE = velE; % create struct
% temp = reshape([data(1:1:end,273:276)'],1,[]);
% velU=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.velD = -velU; % create struct
% temp = reshape([data(1:1:end,277:280)'],1,[]);
% lon_deviation=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.delta_lon = lon_deviation; % create struct
% temp = reshape([data(1:1:end,281:284)'],1,[]);
% lat_deviation=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.delta_lat = lat_deviation; % create struct
% temp = reshape([data(1:1:end,285:288)'],1,[]);
% height_deviation=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
% IN_SENSOR.um482.delta_height = height_deviation; % create struct
% temp = reshape([data(1:1:end,237:238)'],1,[]);
% pDop=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
% IN_SENSOR.um482.pDop = pDop; % create struct
% temp = reshape([data(1:1:end,39:39)'],1,[]);
% pos_type=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
% IN_SENSOR.um482.BESTPOS = pos_type; % create struct
% temp = reshape([data(1:1:end,40:40)'],1,[]);
% numSv=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
% IN_SENSOR.um482.numSv = numSv; % create struct
temp = reshape([data(find(mod(Count,4)==0),239:242)'],1,[]);
Lon=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
IN_SENSOR.um482.Lon = Lon; % create struct
temp = reshape([data(find(mod(Count,4)==0),257:260)'],1,[]);
Lat=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
IN_SENSOR.um482.Lat = Lat; % create struct
temp = reshape([data(find(mod(Count,4)==0),261:264)'],1,[]);
height=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.height = height; % create struct
temp = reshape([data(find(mod(Count,4)==0),265:268)'],1,[]);
velN=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.velN = velN; % create struct
temp = reshape([data(find(mod(Count,4)==0),269:272)'],1,[]);
velE=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.velE = velE; % create struct
temp = reshape([data(find(mod(Count,4)==0),273:276)'],1,[]);
velD=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.velD = velD; % create struct
temp = reshape([data(find(mod(Count,4)==0),277:280)'],1,[]);
delta_lon=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.delta_lon = delta_lon; % create struct
temp = reshape([data(find(mod(Count,4)==0),281:284)'],1,[]);
delta_lat=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.delta_lat = delta_lat; % create struct
temp = reshape([data(find(mod(Count,4)==0),285:288)'],1,[]);
delta_height=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.delta_height = delta_height; % create struct
temp = reshape([data(find(mod(Count,4)==0),237:238)'],1,[]);
pDop=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
IN_SENSOR.um482.pDop = pDop; % create struct
temp = reshape([data(find(mod(Count,4)==0),39:39)'],1,[]);
BESTPOS=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
IN_SENSOR.um482.BESTPOS = BESTPOS; % create struct
temp = reshape([data(find(mod(Count,4)==0),40:40)'],1,[]);
numSv=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
IN_SENSOR.um482.numSv = numSv; % create struct

IN_SENSOR.um482.nChange = zeros(size(IN_SENSOR.um482.velE));
if sum(IN_SENSOR.um482.nChange) == 0
    disp('um482 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% airspeed1
IN_SENSOR.airspeed1.time = IN_SENSOR.ublox1.time;
temp=reshape([data(index_42,181:182)'],1,[]);
IN_SENSOR.airspeed1.airspeed=double(typecast(uint8(temp),'int16')')/32768*100;
temp = reshape([data(find(mod(Count,2)==0),183:184)'],1,[]);
temp =double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
IN_SENSOR.airspeed1.airspeed_indicate = temp(1:2:end);
temp = reshape([data(find(mod(Count,2)==0),185:186)'],1,[]);
temp = double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
EAS2TAS_Algo = temp(1:2:end);
IN_SENSOR.airspeed1.airspeed_true = EAS2TAS_Algo.*IN_SENSOR.airspeed1.airspeed_indicate;
IN_SENSOR.airspeed1.airspeed_calibrate = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.temperature = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.static_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.dynamic_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.status = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.EAS2TAS_Algo = EAS2TAS_Algo;

IN_SENSOR.airspeed1.nChange = zeros(size(IN_SENSOR.airspeed1.time));
if sum(IN_SENSOR.airspeed1.nChange) == 0
    disp('airspeed1 的 nChange 没有正常赋值');
end
% airspeed2
disp('airspeed2未赋值')
IN_SENSOR.airspeed2.time = IN_SENSOR.ublox1.time;
temp=reshape([data(index_42,181:182)'],1,[]);
IN_SENSOR.airspeed2.airspeed=0*double(typecast(uint8(temp),'int16')')/32768*100;
IN_SENSOR.airspeed2.airspeed_true = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.airspeed_indicate = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.airspeed_calibrate = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.temperature = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.static_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.dynamic_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.status = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed2.EAS2TAS_Algo = 0*EAS2TAS_Algo;

IN_SENSOR.airspeed2.nChange = zeros(size(IN_SENSOR.airspeed2.time));
if sum(IN_SENSOR.airspeed2.nChange) == 0
    disp('airspeed2 的 nChange 没有正常赋值');
end
% airspeed3
disp('airspeed3未赋值')
IN_SENSOR.airspeed3.time = IN_SENSOR.ublox1.time;
temp=reshape([data(index_42,181:182)'],1,[]);
IN_SENSOR.airspeed3.airspeed=0*double(typecast(uint8(temp),'int16')')/32768*100;
IN_SENSOR.airspeed3.airspeed_true = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.airspeed_indicate = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.airspeed_calibrate = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.temperature = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.static_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.dynamic_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.status = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed3.EAS2TAS_Algo = 0*EAS2TAS_Algo;

IN_SENSOR.airspeed3.nChange = zeros(size(IN_SENSOR.airspeed3.time));
if sum(IN_SENSOR.airspeed3.nChange) == 0
    disp('airspeed3 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% laserDown1
disp('laserDown1未赋值')
IN_SENSOR.laserDown1.time = IN_SENSOR.radar1.time;
IN_SENSOR.laserDown1.range = -1*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.laserDown1.flag = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.laserDown1.strength = 0*ones(size(IN_SENSOR.radar1.Range));

IN_SENSOR.laserDown1.nChange = zeros(size(IN_SENSOR.laserDown1.time));
if sum(IN_SENSOR.laserDown1.nChange) == 0
    disp('laserDown1 的 nChange 没有正常赋值');
end
% laserDown2
disp('laserDown2未赋值')
IN_SENSOR.laserDown2.time = IN_SENSOR.radar1.time;
IN_SENSOR.laserDown2.range = -1*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.laserDown2.flag = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.laserDown2.strength = 0*ones(size(IN_SENSOR.radar1.Range));

IN_SENSOR.laserDown2.nChange = zeros(size(IN_SENSOR.laserDown2.time));
if sum(IN_SENSOR.laserDown2.nChange) == 0
    disp('laserDown2 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% radarLongForward1
disp('radarLongForward1未赋值')
IN_SENSOR.radarLongForward1.time = IN_SENSOR.radar1.time;
IN_SENSOR.radarLongForward1.range = -1*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongForward1.flag = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongForward1.strength = 0*ones(size(IN_SENSOR.radar1.Range));

IN_SENSOR.radarLongForward1.nChange = zeros(size(IN_SENSOR.radarLongForward1.time));
if sum(IN_SENSOR.radarLongForward1.nChange) == 0
    disp('radarLongForward1 的 nChange 没有正常赋值');
end
% radarLongDown1
disp('radarLongDown1未赋值')
IN_SENSOR.radarLongDown1.time = IN_SENSOR.radar1.time;
IN_SENSOR.radarLongDown1.range = -1*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongDown1.flag = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongDown1.strength = 0*ones(size(IN_SENSOR.radar1.Range));

IN_SENSOR.radarLongDown1.nChange = zeros(size(IN_SENSOR.radarLongDown1.time));
if sum(IN_SENSOR.radarLongDown1.nChange) == 0
    disp('radarLongDown1 的 nChange 没有正常赋值');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU2
% disp('IMU1_Control未赋值')
% IN_SENSOR.IMU1_Control = IN_SENSOR.IMU1;
temp = reshape([data(find(mod(Count,2)==0),159:160)'],1,[]);
rtY_filter_gx=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
IN_SENSOR.IMU1_Control.gyro_x = rtY_filter_gx; % create struct
temp = reshape([data(find(mod(Count,2)==0),161:162)'],1,[]);
rtY_filter_gy=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
IN_SENSOR.IMU1_Control.gyro_y = rtY_filter_gy; % create struct
temp = reshape([data(find(mod(Count,2)==0),163:164)'],1,[]);
rtY_filter_gz=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
IN_SENSOR.IMU1_Control.gyro_z = rtY_filter_gz; % create struct
temp = reshape([data(find(mod(Count,2)==1),145:146)'],1,[]);
rtY_filter_ax=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
IN_SENSOR.IMU1_Control.accel_x = rtY_filter_ax; % create struct
temp = reshape([data(find(mod(Count,2)==1),147:148)'],1,[]);
rtY_filter_ay=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
IN_SENSOR.IMU1_Control.accel_y = rtY_filter_ay; % create struct
temp = reshape([data(find(mod(Count,2)==1),149:150)'],1,[]);
rtY_filter_az=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
IN_SENSOR.IMU1_Control.accel_z = rtY_filter_az; % create struct

IN_SENSOR.IMU1_Control.nChange = zeros(size(IN_SENSOR.IMU1_Control.time));
if sum(IN_SENSOR.IMU1_Control.nChange) == 0
    disp('IMU1_Control 的 nChange 没有正常赋值');
end
% 早期版本log存储的IMU数据为IMU坐标系下IMU测量，后期将log改为体坐标系下的IMU测量
if mean(IN_SENSOR.IMU1_Control.accel_z) > 0
    % 对老版本数据进行坐标转换，由IMU坐标系转换到体坐标系
    disp('特别注意这里对IMU1_Control正负号的特别处理')
    keyboard
    IN_SENSOR.IMU1_Control.accel_y = - IN_SENSOR.IMU1_Control.accel_y;
    IN_SENSOR.IMU1_Control.accel_z = - IN_SENSOR.IMU1_Control.accel_z;
    IN_SENSOR.IMU1_Control.gyro_y = -IN_SENSOR.IMU1_Control.gyro_y;
    IN_SENSOR.IMU1_Control.gyro_z = -IN_SENSOR.IMU1_Control.gyro_z;
end
if 1
    fprintf('使用IMU_Control数据滤波\n');
    IN_SENSOR.IMU1 = IN_SENSOR.IMU1_Control;
end
% figure(220)
% subplot(311);plot(IN_SENSOR.IMU1.time,IN_SENSOR.IMU1.accel_x);hold on;grid on;subplot(312);plot(IN_SENSOR.IMU1.time,IN_SENSOR.IMU1.accel_y);hold on;grid on;subplot(313);plot(IN_SENSOR.IMU1.time,IN_SENSOR.IMU1.accel_z);hold on;grid on;
% figure(222)
% subplot(311);plot(IN_SENSOR.IMU2.time,IN_SENSOR.IMU2.accel_x);hold on;grid on;subplot(312);plot(IN_SENSOR.IMU2.time,IN_SENSOR.IMU2.accel_y);hold on;grid on;subplot(313);plot(IN_SENSOR.IMU2.time,IN_SENSOR.IMU2.accel_z);hold on;grid on;
% figure(223)
% subplot(311);plot(IN_SENSOR.IMU3.time,IN_SENSOR.IMU3.accel_x);hold on;grid on;subplot(312);plot(IN_SENSOR.IMU3.time,IN_SENSOR.IMU3.accel_y);hold on;grid on;subplot(313);plot(IN_SENSOR.IMU3.time,IN_SENSOR.IMU3.accel_z);hold on;grid on;
if 0
    fprintf('使用IMU原始数据滤波\n');
    IN_SENSOR.IMU1 = IN_SENSOR.IMU1_0;
end