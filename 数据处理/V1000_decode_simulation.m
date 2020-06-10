%% 数据解码
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SYSTEM
temp=reshape([data(:,251:254)'],1,[]);
SYSTEM.save_time=double(typecast(uint8(temp),'uint32')')*1e-3;
temp=reshape([data(index_40,255:256)'],1,[]);
SYSTEM.FC_VERSION=typecast(uint8(temp),'uint16');

IN_SENSOR.time=save_time;
IN_SENSOR.IMU1.time=save_time;
IN_SENSOR.IMU2.time=save_time;
IN_SENSOR.IMU3.time=save_time;
IN_SENSOR.baro1.time=save_time(1:2:end);
IN_SENSOR.mag1.time=save_time(1:4:end);
IN_SENSOR.mag2.time = IN_SENSOR.mag1.time;
IN_SENSOR.radar1.time = save_time(1:4:end);
IN_SENSOR.ublox1.time = save_time(1:4:end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU1
% 原始数据
% temp=reshape([data(:,3:6)'],1,[]);
% IN_SENSOR.IMU1.accel_x=typecast(uint8(temp),'single')';
% temp=reshape([data(:,7:10)'],1,[]);
% IN_SENSOR.IMU1.accel_y=typecast(uint8(temp),'single')';
% temp=reshape([data(:,11:14)'],1,[]);
% IN_SENSOR.IMU1.accel_z=typecast(uint8(temp),'single')';
% temp=reshape([data(:,15:18)'],1,[]);
% IN_SENSOR.IMU1.gyro_x=typecast(uint8(temp),'single')';
% temp=reshape([data(:,19:22)'],1,[]);
% IN_SENSOR.IMU1.gyro_y=typecast(uint8(temp),'single')';
% temp=reshape([data(:,23:26)'],1,[]);
% IN_SENSOR.IMU1.gyro_z=typecast(uint8(temp),'single')';
% 1ms滤波
temp = reshape([data(1:1:end,27:28)'],1,[]);
IN_SENSOR.IMU1.accel_x=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(1:1:end,29:30)'],1,[]);
IN_SENSOR.IMU1.accel_y=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(1:1:end,31:32)'],1,[]);
IN_SENSOR.IMU1.accel_z=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
temp = reshape([data(1:1:end,33:34)'],1,[]);
IN_SENSOR.IMU1.gyro_x=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(1:1:end,35:36)'],1,[]);
IN_SENSOR.IMU1.gyro_y=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
temp = reshape([data(1:1:end,37:38)'],1,[]);
IN_SENSOR.IMU1.gyro_z=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU2
disp('IMU2还未解析')
IN_SENSOR.IMU2 = IN_SENSOR.IMU1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU3
disp('IMU3还未解析')
IN_SENSOR.IMU3 = IN_SENSOR.IMU1;
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

IN_SENSOR.mag2.mag_x = mag2calib_x_magFrame;
IN_SENSOR.mag2.mag_y = mag2calib_y_magFrame;
IN_SENSOR.mag2.mag_z = mag2calib_z_magFrame;
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
temp=reshape([data(index_43,119:120)'],1,[]);
IN_SENSOR.radar1.Range = double(typecast(uint8(temp),'int16')')/32768*2000;
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
IN_SENSOR.ublox1.hAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
IN_SENSOR.ublox1.vAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
IN_SENSOR.ublox1.sAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
IN_SENSOR.ublox1.headAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% um482
IN_SENSOR.um482.time = IN_SENSOR.time;
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
temp = reshape([data(1:1:end,239:242)'],1,[]);
Lon=double(typecast(uint8(temp),'single')')/1*0.0000001000;
IN_SENSOR.um482.Lon = Lon; % create struct
temp = reshape([data(1:1:end,257:260)'],1,[]);
Lat=double(typecast(uint8(temp),'single')')/1*0.0000001000;
IN_SENSOR.um482.Lat = Lat; % create struct
temp = reshape([data(1:1:end,261:264)'],1,[]);
height=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.height = height; % create struct
temp = reshape([data(1:1:end,265:268)'],1,[]);
velN=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.velN = velN; % create struct
temp = reshape([data(1:1:end,269:272)'],1,[]);
velE=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.velE = velE; % create struct
temp = reshape([data(1:1:end,273:276)'],1,[]);
velD=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.velD = velD; % create struct
temp = reshape([data(1:1:end,277:280)'],1,[]);
delta_lon=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.delta_lon = delta_lon; % create struct
temp = reshape([data(1:1:end,281:284)'],1,[]);
delta_lat=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.delta_lat = delta_lat; % create struct
temp = reshape([data(1:1:end,285:288)'],1,[]);
delta_height=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IN_SENSOR.um482.delta_height = delta_height; % create struct
temp = reshape([data(1:1:end,237:238)'],1,[]);
pDop=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
IN_SENSOR.um482.pDop = pDop; % create struct
temp = reshape([data(1:1:end,39:39)'],1,[]);
BESTPOS=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
IN_SENSOR.um482.BESTPOS = BESTPOS; % create struct
temp = reshape([data(1:1:end,40:40)'],1,[]);
numSv=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
IN_SENSOR.um482.numSv = numSv; % create struct
% disp('um482还未解析')
% IN_SENSOR.um482.time = save_time(1:4:end);
% temp=reshape([data(index_41,109:112)'],1,[]);
% ublox_iTOW=double(typecast(uint8(temp),'int32')');
% temp=reshape([data(index_41,113:116)'],1,[]);
% IN_SENSOR.um482.velE=double(typecast(uint8(temp),'int32')')*1e-3;
% temp=reshape([data(index_41,117:120)'],1,[]);
% IN_SENSOR.um482.velN=double(typecast(uint8(temp),'int32')')*1e-3;
% temp=reshape([data(index_41,121:124)'],1,[]);
% IN_SENSOR.um482.velD=double(typecast(uint8(temp),'int32')')*1e-3;
% temp=reshape([data(index_41,125:128)'],1,[]);
% IN_SENSOR.um482.Lon=double(typecast(uint8(temp),'int32')')*1e-7;
% temp=reshape([data(index_41,129:132)'],1,[]);
% IN_SENSOR.um482.Lat=double(typecast(uint8(temp),'int32')')*1e-7;
% temp=reshape([data(index_41,133:136)'],1,[]);
% IN_SENSOR.um482.height=double(typecast(uint8(temp),'int32')')*1e-3;
% temp=reshape([data(index_40,127:128)'],1,[]);
% IN_SENSOR.um482.pDop=double(typecast(uint8(temp),'uint16')')*1e-2;
% temp=reshape([data(index_40,129)'],-3,[]);
% IN_SENSOR.um482.numSv=typecast(uint8(temp),'uint8')';
% IN_SENSOR.um482.delta_lat = single(zeros(size(IN_SENSOR.um482.time)));
% IN_SENSOR.um482.delta_lon = single(zeros(size(IN_SENSOR.um482.time)));
% IN_SENSOR.um482.delta_height = single(zeros(size(IN_SENSOR.um482.time)));
% 
% IN_SENSOR.um482.velE = 0*IN_SENSOR.um482.velE;
% IN_SENSOR.um482.velN = 0*IN_SENSOR.um482.velN;
% IN_SENSOR.um482.velD = 0*IN_SENSOR.um482.velD;
% IN_SENSOR.um482.Lon = 0*IN_SENSOR.um482.Lon;
% IN_SENSOR.um482.Lat = 0*IN_SENSOR.um482.Lat;
% IN_SENSOR.um482.height = 0*IN_SENSOR.um482.height;
% IN_SENSOR.um482.pDop = 0*IN_SENSOR.um482.pDop;
% IN_SENSOR.um482.numSv = 0*IN_SENSOR.um482.numSv;
% IN_SENSOR.um482.delta_lat = 0*IN_SENSOR.um482.delta_lat;
% IN_SENSOR.um482.delta_lon = 0*IN_SENSOR.um482.delta_lon;
% IN_SENSOR.um482.delta_height = 0*IN_SENSOR.um482.delta_height;
% IN_SENSOR.um482.BESTPOS = 0*IN_SENSOR.um482.numSv;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% airspeed
IN_SENSOR.airspeed1.time = IN_SENSOR.ublox1.time;
temp=reshape([data(index_42,181:182)'],1,[]);
IN_SENSOR.airspeed1.airspeed=double(typecast(uint8(temp),'int16')')/32768*100;