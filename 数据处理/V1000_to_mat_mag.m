 % �������ļ��з��ڳ���Ŀ¼�У������ļ���Ӧ�ܹ������������������ͺš����ڵ�
% clear,clc
tic
evokeDir = cd; % ���øú���ʱmatlab�ĵ�ǰ�ļ���λ��
fullName = which(mfilename);
rootDir = fileparts(fullName);
global PathName
if PathName~=0
    [FileNames,PathName,~] = uigetfile([PathName,'\\*.bin'],'MultiSelect','on'); % 
else
%     curProj = currentProject;
% %     cd(curProj.RootFolder)
%     try % ֱ�ӽ�����ܵġ�������ݵ����ļ���
%         subfolders = dir(curProj.RootFolder);
%         for i = 1:length(subfolders)
%             if contains(subfolders(i).name,'����') && ... 
%                     (contains(subfolders(i).name,'����')||contains(subfolders(i).name,'����')||contains(subfolders(i).name,'�Է�'))
%                 PathName = [curProj.RootFolder{1},'\',subfolders(i).name];
%             end
%         end
%     catch ME
%         slassddd = 1;
%     end
    [FileNames,PathName,~] = uigetfile([PathName,'\\*.bin'],'MultiSelect','on'); % 
end
returnFlag = false;
if ~iscell(FileNames)
    nFile = 1;
    if FileNames==0
        returnFlag = true;
        return;
    end
else
    nFile = length(FileNames);
end
if contains(PathName,rootDir) % �����ļ����ڳ���Ŀ¼��
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
    BLOCK_SIZE = 296; % 256��288
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
    %% ����
    V1000_decode_magCalib
    %%
    dataDir = cd;
    cd(rootDir)
    dotIdx = strfind(FileName,'.');
    temp = FileName(1:dotIdx-1);
    saveFileName_magCalib{i_file} = [subFoldName,'�����Ʊ궨����_',temp,'.mat'];
    mag1B = [mag1_x_forCalib, mag1_y_forCalib, mag1_z_forCalib]; % mag��������ϵ
    mag2B = [mag2_x_forCalib, mag2_y_forCalib, mag2_z_forCalib];
    mag1B_correct = [mag1calib_x_magFrame,mag1calib_y_magFrame,mag1calib_z_magFrame]; % mag��������ϵ
    mag2B_correct = [mag2calib_x_magFrame,mag2calib_y_magFrame,mag2calib_z_magFrame];
    save(saveFileName_magCalib{i_file},'mag1B','mag2B','mag1B_correct','mag2B_correct')
    cd(dataDir)
    fprintf('����궨����Ϊ�� %s [%d/%d]\n',saveFileName_magCalib{i_file},i_file,nFile)
end
cd(evokeDir)
timeSpend = toc;
fprintf('����������ɣ���ʱ %.2f [s]\n',timeSpend);