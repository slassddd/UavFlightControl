saveFileName_magCalib{i_file} = [GLOBAL_PARAM.dirDataFileForDecode,'磁力计标定数据_',DecodeParam.nameDataFile{i_file}];
mag1B = [V10Log.MAG1.true_data_x, V10Log.MAG1.true_data_y, V10Log.MAG1.true_data_z]; % mag自身坐标系
mag2B = [V10Log.MAG2.true_data_x, V10Log.MAG2.true_data_y, V10Log.MAG2.true_data_z];
mag1B_correct = [V10Log.MAG1.cali_data_x, V10Log.MAG1.cali_data_y, V10Log.MAG1.cali_data_z]; % mag自身坐标系
mag2B_correct = [V10Log.MAG2.cali_data_x, V10Log.MAG2.cali_data_y, V10Log.MAG2.cali_data_z];
if isfield(V10Log,'UBX')
    lla = [V10Log.UBX.lat(end) V10Log.UBX.lon(end) V10Log.UBX.height(end)];
else
    % 默认保底坐标
    lla = [39.7239  116.9653  109.6080];
end
if 0
    figure;
    subplot(311)
    plot(mag1B);grid on;
    subplot(312)
    plot(mag1B_correct);grid on;
    subplot(325)
    plot(vecnorm(mag1B,2,2));grid on;
    subplot(326)
    plot(vecnorm(mag1B_correct,2,2));grid on;
    figure;
    subplot(311)
    plot(mag2B);grid on;
    subplot(312)
    plot(mag2B_correct);grid on;
    subplot(325)
    plot(vecnorm(mag2B,2,2));grid on;
    subplot(326)
    plot(vecnorm(mag2B_correct,2,2));grid on;
    figure;
    scatter3(x1(:,1),x1(:,2),x1(:,3));hold("on");
    scatter3(res1_xCorrect(:,1),res1_xCorrect(:,2),res1_xCorrect(:,3),'r*');hold("on");
    scatter3(data.mag1B_correct(:,1),data.mag1B_correct(:,2),data.mag1B_correct(:,3),'k*');hold("on");
end

save(saveFileName_magCalib{i_file},'mag1B','mag2B','mag1B_correct','mag2B_correct','lla')