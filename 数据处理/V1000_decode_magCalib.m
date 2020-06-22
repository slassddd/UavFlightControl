%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mag
% mag1
temp = reshape([data(find(mod(Count,4)==0),109:110)'],1,[]);
mag1_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,4)==0),111:112)'],1,[]);
mag1_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,4)==0),113:114)'],1,[]);
mag1_z=double(typecast(uint8(temp),'int16')')/32768*2;
mag1_x_forCalib = mag1_x;
mag1_y_forCalib = mag1_y;
mag1_z_forCalib = mag1_z;

tmp = mag1_x;
mag1_x = -mag1_y;
mag1_y = -tmp;
mag1_z = -mag1_z;
% mag2
temp = reshape([data(find(mod(Count,4)==0),115:116)'],1,[]);
mag2_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,4)==0),117:118)'],1,[]);
mag2_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,4)==0),119:120)'],1,[]);
mag2_z=double(typecast(uint8(temp),'int16')')/32768*2;
mag2_x_forCalib = mag2_x;
mag2_y_forCalib = mag2_y;
mag2_z_forCalib = mag2_z;

tmp = mag2_x;
mag2_x = -mag2_y;
mag2_y = -tmp;
mag2_z = -mag2_z;
% mag3
temp = reshape([data(find(mod(Count,4)==0),121:122)'],1,[]);
mag3_x=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,4)==0),123:124)'],1,[]);
mag3_y=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,4)==0),125:126)'],1,[]);
mag3_z=double(typecast(uint8(temp),'int16')')/32768*2;
tmp = mag3_x;
mag3_x = -mag3_y;
mag3_y = -tmp;
mag3_z = -mag3_z;
% mag2 correct
temp = reshape([data(find(mod(Count,2)==1),191:192)'],1,[]);
mag2calib_x_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,2)==1),193:194)'],1,[]);
mag2calib_y_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,2)==1),195:196)'],1,[]);
mag2calib_z_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
mag2calib_x_magFrame=mag2calib_x_magFrame(1:2:end);
mag2calib_y_magFrame=mag2calib_y_magFrame(1:2:end);
mag2calib_z_magFrame=mag2calib_z_magFrame(1:2:end);
mag2calib_x = -mag2calib_y_magFrame;
mag2calib_y = -mag2calib_x_magFrame;
mag2calib_z = -mag2calib_z_magFrame;
% mag1 correct
temp = reshape([data(find(mod(Count,2)==1),167:168)'],1,[]);
mag1calib_x_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,2)==1),169:170)'],1,[]);
mag1calib_y_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
temp = reshape([data(find(mod(Count,2)==1),171:172)'],1,[]);
mag1calib_z_magFrame=double(typecast(uint8(temp),'int16')')/32768*2;
mag1calib_x_magFrame=mag1calib_x_magFrame(1:2:end);
mag1calib_y_magFrame=mag1calib_y_magFrame(1:2:end);
mag1calib_z_magFrame=mag1calib_z_magFrame(1:2:end);
mag1calib_x = -mag1calib_y_magFrame;
mag1calib_y = -mag1calib_x_magFrame;
mag1calib_z = -mag1calib_z_magFrame;