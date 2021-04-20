function [FileNames,isSuccess] = selFileToDecode(type)
global GLOBAL_PARAM
isSuccess = true;
switch type
    case 'bin'
        dirMat = [GLOBAL_PARAM.project.RootFolder{1},'\resources\savedata\','bin日志读取路径.mat'];
    case 'mat'
        dirMat = [GLOBAL_PARAM.project.RootFolder{1},'\resources\savedata\','mat日志读取路径.mat'];
end
try
    temp = load(dirMat);
    readdir = temp.readdir;
    if ~exist(readdir,'dir')
        readdir = [];
    end
catch
    readdir = [];
end
if readdir~=0
    [tempFileNames,GLOBAL_PARAM.dirDataFileForDecode,~] = uigetfile([readdir,'\\*.',type],'MultiSelect','on'); %
else
    try
        curProj = currentProject;
    catch
        curProj.RootFolder = cd;
    end
    try % 直接进入可能的、存放数据的子文件夹
        subfolders = dir(curProj.RootFolder);
        for i = 1:length(subfolders)
            if contains(subfolders(i).name,'数据') && ...
                    (contains(subfolders(i).name,'飞行')||contains(subfolders(i).name,'试验')||contains(subfolders(i).name,'试飞'))
                GLOBAL_PARAM.dirDataFileForDecode = [curProj.RootFolder{1},'\',subfolders(i).name];
            end
        end
    end
    [tempFileNames,GLOBAL_PARAM.dirDataFileForDecode,~] = uigetfile([GLOBAL_PARAM.dirDataFileForDecode,'\*.',type],'MultiSelect','on'); %
end
if ischar(tempFileNames)
    % 选择单一文件时
    FileNames{1} = tempFileNames;
else
    % 选择多个文件时
    FileNames = tempFileNames;
end
% 没有选择文件
if isfloat(FileNames) % strcmp(class(FileNames),'double')
    if FileNames==0
        isSuccess = false;
        return;
    end
else
    readdir = GLOBAL_PARAM.dirDataFileForDecode;
    save(dirMat,'readdir');
end
% if contains(GLOBAL_PARAM.dirDataFileForDecode,rootDir) % 数据文件夹在程序目录下
%      subFoldName = strrep(GLOBAL_PARAM.dirDataFileForDecode,rootDir,'');
%      subFoldName = strrep(subFoldName,'\','');
%      subFoldName = [subFoldName,'\'];
% else
%      subFoldName = GLOBAL_PARAM.dirDataFileForDecode;
% end