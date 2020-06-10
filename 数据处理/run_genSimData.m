clear,clc
%% 载入数据文件
fullName = which(mfilename);
rootDir = fileparts(fullName);
[FileNames, PathName] = uigetfile('*.mat','MultiSelect','on'); % 读取雷达数据
if ~iscell(FileNames)
    nFile = 1;
    if FileNames==0
        return;
    end
else
    nFile = length(FileNames);
end
if contains(PathName,rootDir) % 数据文件夹在程序目录下
     subFoldName = strrep(PathName,rootDir,'');
     subFoldName = strrep(subFoldName,'\','');
     subFoldName = [subFoldName,'\'];
     if nFile == 1
         FileNames = [subFoldName,FileNames];
     else
         for i = 1:nFile
             FileNames{i} = [subFoldName,FileNames{i}];
         end
     end
else
     subFoldName = '';
end
%% 绘制数据
plotOpt = setPlotOpt; % 设置plot属性
ticAll = tic;
ticLoad = tic;
for i_file = 1:nFile  % 载入1分钟时长数据，parfor速度慢
    if iscell(FileNames)
        fileName = FileNames{i_file};
    else
        fileName = FileNames;
    end
    dataSaved{i_file} = load(fileName);  % length(fieldnames(dataSaved)),sl = load(fileName);length(fieldnames(sl))
    fprintf('\t\t载入文件进度 [%d/%d] \n',i_file,nFile)
end
tocLoad = toc(ticLoad);
fprintf('文件载入耗时 %.2f [s]\n',tocLoad)
ticPlot = tic;
%
for i_file = 1:nFile
    if iscell(FileNames)
        fileName = FileNames{i_file};
    else
        fileName = FileNames;
    end    
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    idx_color = rem(i_file,nColor)+1;
    idx_style = ceil(i_file/nColor);
    idx_color = rem(idx_color,nColor) + 1;
    idx_style = rem(idx_style,nStyle) + 1;
    %
    sensors(i_file) = dataSaved{i_file}.sensors;
    sensors(i_file) = run_timeCut(sensors(i_file)); % 以imu为基准对齐各传感器时间戳，其他传感器数据时间均在imu时间范围内
    % 计算传感器滤波数据
    if 1 %
        %         disp('进行传感器数据滤波')
        [filterdata(i_file),calibParam(i_file)] = calSensorFilterData(sensors(i_file),'lowpass');
    end
    
    if 0
        figure(99)
        stepSpace = 10;
        myplot_navfilter(sensors(i_file),plotOpt,idx_color,idx_style,stepSpace); % 显示组合导航数据
        figure(102)
        stepSpace = 1;
        myplot_sensor(sensors(i_file),plotOpt,idx_color,idx_style,stepSpace);    % 显示传感器数据
        myplot_sensor(filterdata(i_file),plotOpt,2,idx_style+1,stepSpace); % 显示传感器滤波数据
    end
    
    if nFile == 1 && 0
        stepSpace = 1;
        sensor_filter_data = [sensors filterdata];
        figure(201)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'gyro',plotOpt,stepSpace);
        figure(202)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'acc',plotOpt,stepSpace);   
        figure(203)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'mag1',plotOpt,stepSpace);      
        figure(204)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'mag2',plotOpt,stepSpace);      
        figure(205)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'mag3',plotOpt,stepSpace);              
        figure(206)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'gpsvel',plotOpt,stepSpace);           
        figure(207)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'gpspos',plotOpt,stepSpace);         
        figure(208)
        [meandata,stddata] = myplot_sensor_single(sensor_filter_data,'baro',plotOpt,stepSpace);
    end
    fprintf('\t\t绘图进度 [%d/%d] \n',i_file,nFile)
    % 保存数据for组合导航仿真
    writeDataForNavSim(sensors(i_file),filterdata(i_file),fileName)
end
if 0
    calibParamUsingAllData = calibParam(1);
    for i_data = 2:nFile % 从2开始，第一个数据已经作为 calibParamUsingAllData 初始化数据
        calibSensorNames = fieldnames(calibParam(1));
        for i_sensor = 1:length(calibSensorNames)
            tmpSensor = calibSensorNames{i_sensor};
            paramNames = fieldnames(calibParam(1).(tmpSensor));
            for i_param = 1:length(paramNames)
                tmpParam = paramNames{i_param};
                calibParamUsingAllData.(tmpSensor).(tmpParam) = calibParamUsingAllData.(tmpSensor).(tmpParam)+calibParam(i_data).(tmpSensor).(tmpParam);
                if i_data == nFile
                    calibParamUsingAllData.(tmpSensor).(tmpParam) = calibParamUsingAllData.(tmpSensor).(tmpParam)/nFile;
                end
            end
        end
    end
    % test case
%     temp = 0;
%     for i = 1:nFile
%         temp = temp + calibParam(i).IMU.a_std;
%     end
%     temp = temp/nFile;
%     calibParamUsingAllData.IMU.a_std, temp
    fprintf('标定数据：\n')
    fprintf('\t IMU gyro bias:  [%.3f,%.3f,%.3f] deg/s\n',calibParamUsingAllData.IMU.g_bias)
    fprintf('\t IMU gyro std:  [%.3f,%.3f,%.3f] deg/s\n',calibParamUsingAllData.IMU.g_std)
%     fprintf('\t IMU acc bias:  [%.3f,%.3f,%.3f] m/s^2\n',calibParamUsingAllData.IMU.a_bias)
    fprintf('\t IMU acc std:  [%.3f,%.3f,%.3f] m/s^2\n',calibParamUsingAllData.IMU.a_std)
%     fprintf('\t Mag bias:  [%.3f,%.3f,%.3f] T\n',calibParamUsingAllData.Mag.mag_bias)
    fprintf('\t Mag3 std:  [%.3f,%.3f,%.3f] T\n',calibParamUsingAllData.Mag.mag3_std)
    fprintf('\t Mag3 std:  [%.3f,%.3f,%.3f] T\n',calibParamUsingAllData.Mag.mag3_std)
    
    calibFileName = sprintf('V1000_calibFile %s.txt',datetime);
    calibFileName = strrep(calibFileName,' ','_');
    calibFileName = strrep(calibFileName,':','_');
    calibFileName = strrep(calibFileName,'-','_');
    fileID = fopen(calibFileName,'w');
    writeCalibFile(fileID,calibParamUsingAllData,FileNames);
    fclose(fileID);    
end
tocPlot = toc(ticPlot);
fprintf('绘图耗时 %.2f [s]\n',tocPlot)
timeSpend = toc(ticAll);
fprintf('总耗时 %.2f [s]\n',timeSpend);
% 用于图形显示飞机姿态
i_show = 1;
temp = interp1(sensors(i_show).GPS.time_ublox,sensors(i_show).GPS.posmNED,sensors(i_show).Algo.time_algo);
temp(end,:) = temp(end-1,:);
simdata(:,1) = sensors(i_show).Algo.time_algo;
simdata(:,2:4) = temp;
simdata(:,5) = sensors(i_show).Algo.algo_roll;
simdata(:,6) = sensors(i_show).Algo.algo_pitch;
simdata(:,7) = sensors(i_show).Algo.algo_yaw;
%