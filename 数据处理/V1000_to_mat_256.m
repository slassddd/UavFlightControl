%% 【仅用来解析V1000磁力计标定固件的数据】
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
%     cd(curProj.RootFolder)
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
    if ~iscell(FileNames)
        FileName = FileNames;
    else
        FileName = FileNames{i_file};
    end  
    BLOCK_SIZE = 256; % 256，288
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
    %%
    dataDir = cd;
    cd(rootDir)
    dotIdx = strfind(FileName,'.');
    temp = FileName(1:dotIdx-1);
    saveFileName{i_file} = [subFoldName,'日志数据_',temp,'.mat'];
    save(saveFileName{i_file})
    fprintf('保存飞行数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)
    saveFileName{i_file} = [subFoldName,'仿真数据_',temp,'.mat'];

%     fprintf('保存仿真数据为： %s [%d/%d]\n',saveFileName{i_file},i_file,nFile)    
    saveFileName_magCalib{i_file} = [subFoldName,'磁力计标定数据_',temp,'.mat'];
    mag1B = [mag1_x_forCalib, mag1_y_forCalib, mag1_z_forCalib]; % mag自身坐标系
    mag2B = [mag2_x_forCalib, mag2_y_forCalib, mag2_z_forCalib];
    mag1B_correct = [mag1calib_x_magFrame,mag1calib_y_magFrame,mag1calib_z_magFrame]; % mag自身坐标系
    mag2B_correct = [mag2calib_x_magFrame,mag2calib_y_magFrame,mag2calib_z_magFrame];
    lla = [algo_NAV_lat(end) algo_NAV_lon(end) algo_NAV_alt(end)];
    save(saveFileName_magCalib{i_file},'mag1B','mag2B','mag1B_correct','mag2B_correct','lla')
    cd(dataDir)
    fprintf('保存标定数据为： %s [%d/%d]\n',saveFileName_magCalib{i_file},i_file,nFile)
end
cd(evokeDir)
timeSpend = toc;
fprintf('数据载入完成，耗时 %.2f [s]\n',timeSpend);