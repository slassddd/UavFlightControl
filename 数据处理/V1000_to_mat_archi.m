% 将数据文件夹放在程序目录中，数据文件夹应能够体现数据特征，如型号、日期等
clear,clc
tic
evokeDir = cd; % 调用该函数时matlab的当前文件夹位置
fullName = which(mfilename);
rootDir = fileparts(fullName);
global PathName
if PathName~=0
    [FileNames,PathName,~] = uigetfile([PathName,'\\*.bin'],'MultiSelect','on'); % 
else
    curProj = currentProject;
    try % 直接进入可能的、存放数据的子文件夹
        subfolders = dir(curProj.RootFolder);
        for i = 1:length(subfolders)
            if contains(subfolders(i).name,'数据') && ... 
                    (contains(subfolders(i).name,'飞行')||contains(subfolders(i).name,'试验')||contains(subfolders(i).name,'试飞'))
                PathName = [curProj.RootFolder{1},'\',subfolders(i).name];
            end
        end
    catch ME
        slassddd = 1;
    end
    [FileNames,PathName,~] = uigetfile([PathName,'\\*.bin'],'MultiSelect','on'); % 
end
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
else
     subFoldName = PathName;
end
for i_file = 1:nFile
    clear IN_SENSOR SL  % 清理数据，防止不同文件间数据赋值错误
    if ~iscell(FileNames)
        FileName = FileNames;
    else
        FileName = FileNames{i_file};
    end  
    BLOCK_SIZE = 296; % 256，288, 296
    fp = fopen([PathName,'\\',FileName],'r');
    datas{i_file} = fread(fp);
    fclose(fp);

    data = datas{i_file};
    n=length(data);
    i=1;
    m=floor(n/BLOCK_SIZE);
    data=reshape(data(1:BLOCK_SIZE*m)',[BLOCK_SIZE,m]);
    data=data';
    
    Count=binDecode(data,1,0,0);
    indexn=find(mod(Count,8)==1);
    if( indexn(1) >1 )
        data=data(indexn(1):end,:);
    end
    
    [m,mm]=size(data);
    m=floor(m/8)*8;
    data=data(1:m,:);
    datacolumn=data;
    Count=binDecode(data,1,0,0);
    HD=180/pi;
    %% 解码
    V1000_decode_common
    V1000_decode_simulation
    V1000_decode_auto
    SL = addStructDataTime(SL,IN_SENSOR.IMU1.time);   
    %% 对齐数据
    SL.TASK_WindParam = alignDimension(SL.TASK_WindParam);
    IN_SENSOR.baro1 = alignDimension(IN_SENSOR.baro1);
    IN_SENSOR.mag1 = alignDimension(IN_SENSOR.mag1);
    IN_SENSOR.mag2 = alignDimension(IN_SENSOR.mag2);
    IN_SENSOR.um482 = alignDimension(IN_SENSOR.um482);
    IN_SENSOR.radar1 = alignDimension(IN_SENSOR.radar1);
    %%
    clear temp1
    temp = IN_SENSOR.ublox1.vAcc;
    templen = length(temp);
    temp1(1:2:2*templen-1) = temp;
    temp1(2:2:2*templen) = temp;
    IN_SENSOR.ublox1.vAcc = temp1';
    clear temp1
    temp = IN_SENSOR.ublox1.sAcc;
    templen = length(temp);
    temp1(1:2:2*templen-1) = temp;
    temp1(2:2:2*templen) = temp;
    IN_SENSOR.ublox1.sAcc = temp1';
    clear temp1
    temp = IN_SENSOR.ublox1.headAcc;
    templen = length(temp);
    temp1(1:2:2*templen-1) = temp;
    temp1(2:2:2*templen) = temp;
    IN_SENSOR.ublox1.headAcc = temp1';    
    clear temp1
    %%
%     IN_SENSOR.ublox1 = alignDimension(IN_SENSOR.ublox1);
    IN_SENSOR.airspeed1 = alignDimension(IN_SENSOR.airspeed1);
    %%
%     V1000_decode_task
    dataDir = cd;
    cd(rootDir)
    dotIdx = strfind(FileName,'.');
    temp = FileName(1:dotIdx-1);
    saveFileName{i_file} = [subFoldName,'日志数据_',temp,'.mat'];
    save(saveFileName{i_file})
    fprintf('保存飞行数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)
    saveFileName{i_file} = [subFoldName,'仿真数据_',temp,'.mat'];
    try
        run_PlotFlightData
    end
    save(saveFileName{i_file},'IN_SENSOR','SL','SL_LOAD')
    fprintf('保存仿真数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)    
    saveFileName_magCalib{i_file} = [subFoldName,'磁力计标定数据_',temp,'.mat'];
    mag1B = [mag1_x_forCalib, mag1_y_forCalib, mag1_z_forCalib]; % mag自身坐标系
    mag2B = [mag2_x_forCalib, mag2_y_forCalib, mag2_z_forCalib];
    mag1B_correct = [mag1calib_x_magFrame,mag1calib_y_magFrame,mag1calib_z_magFrame]; % mag自身坐标系
    mag2B_correct = [mag2calib_x_magFrame,mag2calib_y_magFrame,mag2calib_z_magFrame];
    lla = [IN_SENSOR.ublox1.Lat,IN_SENSOR.ublox1.Lon,IN_SENSOR.ublox1.height];
    save(saveFileName_magCalib{i_file},'mag1B','mag2B','mag1B_correct','mag2B_correct','lla')
    cd(dataDir)
    fprintf('保存标定数据为： %s [%d/%d]\n',saveFileName_magCalib{i_file},i_file,nFile)
end
cd(evokeDir)
timeSpend = toc;
fprintf('数据载入完成，耗时 %.2f [s]\n',timeSpend);
%% 选择挂载磁力计文件
try
    if false
        [magFileName,magFilePath,~] = uigetfile([PathName,'\\*.txt']); %
        magFullPath = strcat(magFilePath,magFileName);
        RM3100.k = 1/75;
        RM3100.mag = RM3100.k*importdata(magFullPath); % 需手动对TXT数据文件进行修改，删除XYZ和：
        RM3100.mag(:,3) = - RM3100.mag(:,3);
        RM3100.norm = vecnorm(RM3100.mag,2,2);
        SinglePlot_mag_RM3100
    end
end
%% END 选择挂载磁力计文件