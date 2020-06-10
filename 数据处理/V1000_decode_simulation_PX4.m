%% 数据解码
load(['20200214 四川\','px4_11_30066定高模式前飞加速至8m左右.BIN-685169.mat'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IN_SENSOR.time = IMU(:,2);
IN_SENSOR.IMU1.time = IMU(:,2);
IN_SENSOR.IMU2.time = IMU2(:,2);
IN_SENSOR.IMU3.time = IMU3(:,2);
IN_SENSOR.baro1.time= BARO(:,2);
IN_SENSOR.mag1.time = MAG(:,2);
IN_SENSOR.mag2.time = MAG2(:,2);
IN_SENSOR.radar1.time = GPS(:,2);
IN_SENSOR.ublox1.time = GPS(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU1
IN_SENSOR.IMU1.accel_x= IMU(:,6);
IN_SENSOR.IMU1.accel_y= IMU(:,7);
IN_SENSOR.IMU1.accel_z= IMU(:,8);
IN_SENSOR.IMU1.gyro_x= IMU(:,3);
IN_SENSOR.IMU1.gyro_y= IMU(:,4);
IN_SENSOR.IMU1.gyro_z= IMU(:,5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU2
% disp('IMU2还未解析')
% IN_SENSOR.IMU2 = IN_SENSOR.IMU1;
IN_SENSOR.IMU2.accel_x= IMU2(:,6);
IN_SENSOR.IMU2.accel_y= IMU2(:,7);
IN_SENSOR.IMU2.accel_z= IMU2(:,8);
IN_SENSOR.IMU2.gyro_x= IMU2(:,3);
IN_SENSOR.IMU2.gyro_y= IMU2(:,4);
IN_SENSOR.IMU2.gyro_z= IMU2(:,5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMU3
% IN_SENSOR.IMU3 = IN_SENSOR.IMU1;
IN_SENSOR.IMU3.accel_x= IMU3(:,6);
IN_SENSOR.IMU3.accel_y= IMU3(:,7);
IN_SENSOR.IMU3.accel_z= IMU3(:,8);
IN_SENSOR.IMU3.gyro_x= IMU3(:,3);
IN_SENSOR.IMU3.gyro_y= IMU3(:,4);
IN_SENSOR.IMU3.gyro_z= IMU3(:,5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%baro1
IN_SENSOR.baro1.alt_baro = BARO(:,3);
temperature= BARO(:,5);
pressure= BARO(:,4);
temperature_gs= BARO(:,9);
pressure_gs= BARO(:,4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mag
% mag1
mag1_x=double(typecast(uint8(temp),'int16')')/32768*2;
mag1_y=double(typecast(uint8(temp),'int16')')/32768*2;
mag1_z=double(typecast(uint8(temp),'int16')')/32768*2;
mag1_x_forCalib = mag1_x;
mag1_y_forCalib = mag1_y;
mag1_z_forCalib = mag1_z;

tmp = mag1_x;
mag1_x = -mag1_y;
mag1_y = -tmp;
mag1_z = -mag1_z;
% mag2
temp=reshape([data(4:4:end,115:116)'],1,[]);
mag2_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(4:4:end,117:118)'],1,[]);
mag2_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(4:4:end,119:120)'],1,[]);
mag2_z=double(typecast(uint8(temp),'int16')')/32768*2;
mag2_x_forCalib = mag2_x;
mag2_y_forCalib = mag2_y;
mag2_z_forCalib = mag2_z;

tmp = mag2_x;
mag2_x = -mag2_y;
mag2_y = -tmp;
mag2_z = -mag2_z;
% mag3
temp=reshape([data(4:4:end,121:122)'],1,[]);
mag3_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(4:4:end,123:124)'],1,[]);
mag3_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(4:4:end,125:126)'],1,[]);
mag3_z=double(typecast(uint8(temp),'int16')')/32768*2;
tmp = mag3_x;
mag3_x = -mag3_y;
mag3_y = -tmp;
mag3_z = -mag3_z;
%     % mag1 correct
temp=reshape([data(1:2:end,191:192)'],1,[]);
mag2calib_x_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(1:2:end,193:194)'],1,[]);
mag2calib_y_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(1:2:end,195:196)'],1,[]);
mag2calib_z_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
mag2calib_x_magFrame=mag2calib_x_magFrame(1:2:end);
mag2calib_y_magFrame=mag2calib_y_magFrame(1:2:end);
mag2calib_z_magFrame=mag2calib_z_magFrame(1:2:end);
mag2calib_x = -mag2calib_y_magFrame;
mag2calib_y = -mag2calib_x_magFrame;
mag2calib_z = -mag2calib_z_magFrame;

temp=reshape([data(1:2:end,167:168)'],1,[]);
mag1calib_x_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(1:2:end,169:170)'],1,[]);
mag1calib_y_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp=reshape([data(1:2:end,171:172)'],1,[]);
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
temp=reshape([data(2:4:end,109)'],1,[]);
IN_SENSOR.radar1.SNR = uint8(temp');
temp=reshape([data(2:4:end,110)'],1,[]);
IN_SENSOR.radar1.Flag = uint8(temp');
temp=reshape([data(2:4:end,111:112)'],1,[]);
IN_SENSOR.radar1.Range = double(typecast(uint8(temp),'int16')')/32768*2000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ublox
temp=reshape([data(1:4:end,109:112)'],1,[]);
ublox_iTOW=double(typecast(uint8(temp),'int32')');
temp=reshape([data(1:4:end,113:116)'],1,[]);
IN_SENSOR.ublox1.velE=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(1:4:end,117:120)'],1,[]);
IN_SENSOR.ublox1.velN=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(1:4:end,121:124)'],1,[]);
IN_SENSOR.ublox1.velD=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(1:4:end,125:128)'],1,[]);
IN_SENSOR.ublox1.Lon=double(typecast(uint8(temp),'int32')')*1e-7;
temp=reshape([data(1:4:end,129:132)'],1,[]);
IN_SENSOR.ublox1.Lat=double(typecast(uint8(temp),'int32')')*1e-7;
temp=reshape([data(1:4:end,133:136)'],1,[]);
IN_SENSOR.ublox1.height=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(4:4:end,127:128)'],1,[]);
IN_SENSOR.ublox1.pDop=double(typecast(uint8(temp),'uint16')')*1e-2;
temp=reshape([data(4:4:end,129)'],1,[]);
IN_SENSOR.ublox1.numSv=typecast(uint8(temp),'uint8')';
IN_SENSOR.ublox1.hAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
IN_SENSOR.ublox1.vAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
IN_SENSOR.ublox1.sAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
IN_SENSOR.ublox1.headAcc = single(zeros(size(IN_SENSOR.ublox1.time)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% um482
disp('um482还未解析')
% IN_SENSOR.um482 = IN_SENSOR.ublox1;
% GPSFieldNames = fieldnames(IN_SENSOR.ublox1);
% nGPSField = length(GPSFieldNames);
% for i_gps = 1:nGPSField
%     tempFieldName = GPSFieldNames{i_gps};
%     IN_SENSOR.um482.(tempFieldName) = IN_SENSOR.ublox1.(tempFieldName);
% end
IN_SENSOR.um482.time = save_time(1:4:end);
temp=reshape([data(1:4:end,109:112)'],1,[]);
ublox_iTOW=double(typecast(uint8(temp),'int32')');
temp=reshape([data(1:4:end,113:116)'],1,[]);
IN_SENSOR.um482.velE=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(1:4:end,117:120)'],1,[]);
IN_SENSOR.um482.velN=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(1:4:end,121:124)'],1,[]);
IN_SENSOR.um482.velD=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(1:4:end,125:128)'],1,[]);
IN_SENSOR.um482.Lon=double(typecast(uint8(temp),'int32')')*1e-7;
temp=reshape([data(1:4:end,129:132)'],1,[]);
IN_SENSOR.um482.Lat=double(typecast(uint8(temp),'int32')')*1e-7;
temp=reshape([data(1:4:end,133:136)'],1,[]);
IN_SENSOR.um482.height=double(typecast(uint8(temp),'int32')')*1e-3;
temp=reshape([data(4:4:end,127:128)'],1,[]);
IN_SENSOR.um482.pDop=double(typecast(uint8(temp),'uint16')')*1e-2;
temp=reshape([data(4:4:end,129)'],1,[]);
IN_SENSOR.um482.numSv=typecast(uint8(temp),'uint8')';
IN_SENSOR.um482.delta_lat = single(zeros(size(IN_SENSOR.um482.time)));
IN_SENSOR.um482.delta_lon = single(zeros(size(IN_SENSOR.um482.time)));
IN_SENSOR.um482.delta_height = single(zeros(size(IN_SENSOR.um482.time)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% airspeed
disp('airspeed还未解析')
IN_SENSOR.airspeed1.time = IN_SENSOR.um482.time;
IN_SENSOR.airspeed1.airspeed = zeros(size(IN_SENSOR.airspeed1.time));
