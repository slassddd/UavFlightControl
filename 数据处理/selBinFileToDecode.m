function [FileNames,PathName,isSuccess] = selBinFileToDecode(PathName)
global GLOBAL_PARAM
isSuccess = true;
if PathName~=0
    [tempFileNames,PathName,~] = uigetfile([PathName,'\\*.bin'],'MultiSelect','on'); % 
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
    end
    [tempFileNames,PathName,~] = uigetfile([PathName,'\\*.bin'],'MultiSelect','on'); % 
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
end
% if contains(PathName,rootDir) % 数据文件夹在程序目录下
%      subFoldName = strrep(PathName,rootDir,'');
%      subFoldName = strrep(subFoldName,'\','');
%      subFoldName = [subFoldName,'\'];
% else
%      subFoldName = PathName;
% end