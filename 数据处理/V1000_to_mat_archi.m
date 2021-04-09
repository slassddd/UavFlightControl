% 将数据文件夹放在程序目录中，数据文件夹应能够体现数据特征，如型号、日期等
clear,clc
tic
setGlobalParams();
DecodeParam.evokeDir = cd; % 调用该函数时matlab的当前文件夹位置
DecodeParam.nameDecodeFile = which(mfilename);
DecodeParam.dirDecodeFile = fileparts(DecodeParam.nameDecodeFile);
[DecodeParam.nameDataFile,isSuccess] = selFileToDecode('bin');if ~isSuccess,return;end
nFile = length(DecodeParam.nameDataFile);
for i_file = 1:nFile
    clear IN_SENSOR FlightLog_Original FlightLog_SecondProc  % 清理数据，防止不同文件间数据赋值错误
    FileName = DecodeParam.nameDataFile{i_file};
    %% 读取 bin 文件
    BLOCK_SIZE = 296; % 256，288, 296
    [data,Count] = readBinFile([GLOBAL_PARAM.dirDataFileForDecode,'\\',FileName],BLOCK_SIZE);
    %% 解码
    V1000_decode_common
    V1000_decode_simulation
    V1000_decode_auto;
    FlightLog_Original = SL;clear SL
    FlightLog_Original = addStructDataTime(FlightLog_Original,IN_SENSOR.IMU1.time);
    %% 对齐数据
    FlightLog_Original.TASK_WindParam = alignDimension(FlightLog_Original.TASK_WindParam);
    IN_SENSOR.baro1 = alignDimension(IN_SENSOR.baro1);
    IN_SENSOR.mag1 = alignDimension(IN_SENSOR.mag1);
    IN_SENSOR.mag2 = alignDimension(IN_SENSOR.mag2);
    IN_SENSOR.um482 = alignDimension(IN_SENSOR.um482);
    IN_SENSOR.radar1 = alignDimension(IN_SENSOR.radar1);
    IN_SENSOR.airspeed1 = alignDimension(IN_SENSOR.airspeed1);
    %% 保存数据
    cd(DecodeParam.dirDecodeFile)
    % 保存日志解析相关的所有数据 -------------------------------------------
    dotIdx = strfind(FileName,'.');
    temp = FileName(1:dotIdx(end)-1);
    saveFileName{i_file} = [GLOBAL_PARAM.dirDataFileForDecode,'日志数据_',temp,'.mat'];
    save(saveFileName{i_file})
    fprintf('保存飞行数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)
    % 保存仿真相关数据 -----------------------------------------------------
    saveFileName{i_file} = [GLOBAL_PARAM.dirDataFileForDecode,'仿真数据_',temp,'.mat'];
    try
        run_PlotFlightData
    end
    save(saveFileName{i_file},'IN_SENSOR','FlightLog_Original','FlightLog_SecondProc')
    fprintf('保存仿真数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)
    % 保存磁力计标定相关数据 -----------------------------------------------
    saveFileName_magCalib{i_file} = [GLOBAL_PARAM.dirDataFileForDecode,'磁力计标定数据_',temp,'.mat'];
    mag1B = [mag1_x_forCalib, mag1_y_forCalib, mag1_z_forCalib]; % mag自身坐标系
    mag2B = [mag2_x_forCalib, mag2_y_forCalib, mag2_z_forCalib];
    mag1B_correct = [mag1calib_x_magFrame,mag1calib_y_magFrame,mag1calib_z_magFrame]; % mag自身坐标系
    mag2B_correct = [mag2calib_x_magFrame,mag2calib_y_magFrame,mag2calib_z_magFrame];
    lla = [IN_SENSOR.ublox1.Lat,IN_SENSOR.ublox1.Lon,IN_SENSOR.ublox1.height];
    save(saveFileName_magCalib{i_file},'mag1B','mag2B','mag1B_correct','mag2B_correct','lla')
    cd(DecodeParam.evokeDir)
    fprintf('保存标定数据为： %s [%d/%d]\n',saveFileName_magCalib{i_file},i_file,nFile)
    % 保存航线数据
    pathFileName{i_file} = [GLOBAL_PARAM.dirDataFileForDecode,'航线数据_',temp,'.mat'];
    PathData = FlightLog_SecondProc.IN_MAVLINK.mavlink_mission_item_def;
    save(pathFileName{i_file},'PathData')
    fprintf('保存航线数据为： %s [%d/%d]\n',pathFileName{i_file},i_file,nFile)
end
cd(DecodeParam.evokeDir)
timeSpend = toc;
fprintf('数据载入完成，耗时 %.2f [s]\n',timeSpend);
%% 选择挂载磁力计文件
try
    if false
        [magFileName,magFilePath,~] = uigetfile([GLOBAL_PARAM.dirDataFileForDecode,'\\*.txt']); %
        magFullPath = strcat(magFilePath,magFileName);
        RM3100.k = 1/75;
        RM3100.mag = RM3100.k*importdata(magFullPath); % 需手动对TXT数据文件进行修改，删除XYZ和：
        RM3100.mag(:,3) = - RM3100.mag(:,3);
        RM3100.norm = vecnorm(RM3100.mag,2,2);
        SinglePlot_mag_RM3100
    end
end
%% V10机头空速计
try
    temp = strrep(DecodeParam.nameDataFile{1},'.bin','');
    filenameArspeed = [temp,' LOG'];
    data_V10_arspeed = byc_V10_arspeed(filenameArspeed);
    % 画图
    figure;
    t_offset = 16.65;
    plot(data_V10_arspeed.time+t_offset,data_V10_arspeed.arspeed);
    hold on;grid on;
    if exist('IN_SENSOR')
        plot(IN_SENSOR.airspeed1.time,IN_SENSOR.airspeed1.airspeed_indicate);hold on;
        legend('机头','机翼')
    end    
end
%% END 选择挂载磁力计文件