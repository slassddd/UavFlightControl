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
    clear IN_SENSOR SL sensors % 清理数据，防止不同文件间数据赋值错误
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
    
    %         Count=binDecode(data,1,0,0);
    %         indexn=find(Count==1);
    %         data=data(indexn(1):end,:);
    
    %         Count=binDecode(data,1,0,0);
    %         indexn=find(Count>0);
    %         if( mod(Count(indexn(1)),2) ==1 )
    %             data=data(indexn(1):end,:);
    %         else
    %             data=data( (indexn(1)+1) :end,:);
    %         end
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
    V1000_decode_fusionDebug
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
    velHeading = atan2(IN_SENSOR.ublox1.velE,IN_SENSOR.ublox1.velN)*180/pi;
    figure;
    plot(IN_SENSOR.ublox1.time, velHeading,'r');hold on;
    plot(IN_SENSOR.ublox1.time, algo_NAV_yaw,'b');hold on;
%     V1000_decode_task
    %%
    %IMU
    len=100;
    ax(1:len)=[];
    ay(1:len)=[];
    az(1:len)=[];
    gx(1:len)=[];
    gy(1:len)=[];
    gz(1:len)=[];
    time_imu(1:len)=[];
    data_imu_txt={
        'time_imu'
        'ax';
        'ay';
        'az';
        'gx';
        'gy';
        'gz';
        };
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %baro
    data_baro_txt={
        'time_baro'
        'altitue';
        'temperature';
        'pressure';
        'temperature_gs';
        'pressure_gs';
        };
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Mag
    data_mag_txt={
        'time_mag';
        'mag1_x';
        'mag1_y';
        'mag1_z';
        'mag2_x';
        'mag2_y';
        'mag2_z';        
        'mag3_x';
        'mag3_y';
        'mag3_z';
        'mag1calib_x_magFrame';
        'mag1calib_y_magFrame';
        'mag1calib_z_magFrame';
        'mag2calib_x_magFrame';
        'mag2calib_y_magFrame';
        'mag2calib_z_magFrame';        
        };
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %radar
    data_radar_txt={
        'time_radar'
        'radar_SNR';
        'radar_Flag';
        'radar_Range';
        };
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ublox
    data_ublox_txt={
        'time_ublox'
        'ublox_iTOW';
        'ublox_velE';
        'ublox_velN';
        'ublox_velD';
        'ublox_lon';
        'ublox_lat';
        'ublox_height';
        'ublox_pDOP';
        'ublox_numSV';
        };
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %algo
    data_ck_txt={
        'time_algo'
        'Switch_LockStatus';
        'Lock_Status';
        'algo_mode';
        'PLANE_COPTER_MODE';
        'src_pitch';
        'src_roll';
        'src_throttle';
        'src_yaw';
        'algo_remote_ct_st_pitch';
        'algo_remote_ct_st_roll';
        'algo_remote_ct_st_throttle';
        'algo_remote_ct_st_yaw';
        'algo_roll';
        'algo_pitch';
        'algo_yaw';
        'algo_curr_vel_0';
        'algo_curr_vel_1';
        'algo_curr_vel_2';
        'algo_curr_pos_0';
        'algo_curr_pos_1';
        'algo_curr_pos_2';
        'algo_curr_alt';
        'algo_rate_target_ang_vel_0';
        'algo_rate_target_ang_vel_1';
        'algo_rate_target_ang_vel_2';
        'algo_roll_in';
        'algo_pitch_in';
        'algo_yaw_in';
        'algo_throttle_in';
        'algo_attitude_target_euler_rate_0';
        'algo_attitude_target_euler_rate_1';
        'algo_attitude_target_euler_rate_2';
        'algo_attitude_target_euler_angle_0';
        'algo_attitude_target_euler_angle_1';
        'algo_attitude_target_euler_angle_2';
        'algo_pwm_out_0';
        'algo_pwm_out_1';
        'algo_pwm_out_2';
        'algo_pwm_out_3';
        'algo_attitude_error_vector_0';
        'algo_attitude_error_vector_1';
        'algo_attitude_error_vector_2';
        'algo_speed_out_0';
        'algo_speed_out_1';
        'algo_speed_out_2';
        'algo_speed_out_3';
        'algo_pos_target_0';
        'algo_pos_target_1';
        'algo_pos_target_2';
        'algo_vel_target_0';
        'algo_vel_target_1';
        'algo_vel_target_2';
        'algo_accel_target_0';
        'algo_accel_target_1';
        'algo_accel_target_2';
        'algo_z_accel_meas';
        'algo_climb_rate_cms';
        'algo_throttle_filter';
        'algo_vel_desired_2';
        'algo_throttle_lower';
        'algo_throttle_upper';
        'algo_limit_pos_up';
        'algo_nav_pitch_cd';
        'algo_latAccDem';
        'algo_yaw_out';
        'algo_throttle_dem';
        'algo_k_rudder';
        'algo_k_elevator';
        'algo_k_throttle';
        'algo_k_aileron';
        'dAB_00';
        'dAB_01';
        'dAB_02';
        'dWB_00';
        'dWB_01';
        'dWB_02';
        'dAB_10';
        'dAB_11';
        'dAB_12';
        'dWB_10';
        'dWB_11';
        'dWB_12';
        'dAB_20';
        'dAB_21';
        'dAB_22';
        'dWB_20';
        'dWB_21';
        'dWB_22';
        'ax_f';
        'ay_f';
        'az_f';
        'gx_f';
        'gy_f';
        'gz_f';
        };
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %slalgo   
    data_slalgo_txt={
        'algo_NAV_lon'
        'algo_NAV_lat';
        'algo_NAV_yaw';
        'algo_NAV_pitch'
        'algo_NAV_roll';
        'algo_NAV_alt';        
        'algo_NAV_Vn'
        'algo_NAV_Ve';
        'algo_NAV_Vd';        
        };
    %
    dataDir = cd;
    cd(rootDir)
    myplot_genStruct % 生成结构体数据
    dotIdx = strfind(FileName,'.');
    temp = FileName(1:dotIdx-1);
    saveFileName{i_file} = [subFoldName,'日志数据_',temp,'.mat'];
    save(saveFileName{i_file})
    fprintf('保存飞行数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)
    saveFileName{i_file} = [subFoldName,'仿真数据_',temp,'.mat'];
    tempSensor = sensors(i_file);
    clear sensors
    sensors = tempSensor;
    try
        run_PlotFlightData
    end
    save(saveFileName{i_file},'IN_SENSOR','sensors','','Out_initValue','stepInfo','SL','SL_LOAD')
    fprintf('保存仿真数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)    
    saveFileName_magCalib{i_file} = [subFoldName,'磁力计标定数据_',temp,'.mat'];
    mag1B = [mag1_x_forCalib, mag1_y_forCalib, mag1_z_forCalib]; % mag自身坐标系
    mag2B = [mag2_x_forCalib, mag2_y_forCalib, mag2_z_forCalib];
    mag1B_correct = [mag1calib_x_magFrame,mag1calib_y_magFrame,mag1calib_z_magFrame]; % mag自身坐标系
    mag2B_correct = [mag2calib_x_magFrame,mag2calib_y_magFrame,mag2calib_z_magFrame];
    lla = [sensors.GPS.ublox_lat,sensors.GPS.ublox_lon,sensors.GPS.ublox_height];
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