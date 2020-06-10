function writeCalibFile(id,calibParamUsingAllData,FileNames)
fprintf(id,'标定文件\n');
fprintf(id,'生成时间: %s\n',datetime);
if ~iscell(FileNames)
    nFile = 1;
else
    nFile = length(FileNames);
end
if nFile ~= 1
    fprintf(id,'使用的数据文件: %s',FileNames{1});
else
    fprintf(id,'使用的数据文件: %s',FileNames);
end
for i = 2:nFile
    fprintf(id,', %s',FileNames{i});
end
% fprintf(id,'% 陀螺偏差: %.3f %.3f %.3f deg/s\n',calibParamUsingAllData.IMU.g_bias);
fprintf(id,'\n');
fprintf(id,'IMU_gyro_bias_x:  %.3f deg/s\n',calibParamUsingAllData.IMU.g_bias(1));
fprintf(id,'IMU_gyro_bias_y:  %.3f deg/s\n',calibParamUsingAllData.IMU.g_bias(2));
fprintf(id,'IMU_gyro_bias_z:  %.3f deg/s\n',calibParamUsingAllData.IMU.g_bias(3));
fprintf(id,'\n');
fprintf(id,'IMU_gyro_std_x:  %.3f deg/s\n',calibParamUsingAllData.IMU.g_std(1));
fprintf(id,'IMU_gyro_std_y:  %.3f deg/s\n',calibParamUsingAllData.IMU.g_std(2));
fprintf(id,'IMU_gyro_std_z:  %.3f deg/s\n',calibParamUsingAllData.IMU.g_std(3));
fprintf(id,'\n');
%     fprintf('\t IMU acc bias:  [%.3f,%.3f,%.3f] m/s^2\n',calibParamUsingAllData.IMU.a_bias)
fprintf(id,'IMU_acc_std_x:  %.3f m/s^2\n',calibParamUsingAllData.IMU.a_std(1));
fprintf(id,'IMU_acc_std_y:  %.3f m/s^2\n',calibParamUsingAllData.IMU.a_std(2));
fprintf(id,'IMU_acc_std_z:  %.3f m/s^2\n',calibParamUsingAllData.IMU.a_std(3));
fprintf(id,'\n');
%     fprintf('\t Mag bias:  [%.3f,%.3f,%.3f] T\n',calibParamUsingAllData.Mag.mag_bias)
fprintf(id,'Mag1_std_x:  %.3f Gs\n',calibParamUsingAllData.Mag.mag1_std(1));
fprintf(id,'Mag1_std_y:  %.3f Gs\n',calibParamUsingAllData.Mag.mag1_std(2));
fprintf(id,'Mag1_std_z:  %.3f Gs\n',calibParamUsingAllData.Mag.mag1_std(3));
fprintf(id,'Mag2_std_x:  %.3f Gs\n',calibParamUsingAllData.Mag.mag2_std(1));
fprintf(id,'Mag2_std_y:  %.3f Gs\n',calibParamUsingAllData.Mag.mag2_std(2));
fprintf(id,'Mag2_std_z:  %.3f Gs\n',calibParamUsingAllData.Mag.mag2_std(3));
fprintf(id,'Mag3_std_x:  %.3f Gs\n',calibParamUsingAllData.Mag.mag3_std(1));
fprintf(id,'Mag3_std_y:  %.3f Gs\n',calibParamUsingAllData.Mag.mag3_std(2));
fprintf(id,'Mag3_std_z:  %.3f Gs\n',calibParamUsingAllData.Mag.mag3_std(3));
