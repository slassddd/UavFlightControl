function saveMatFileName(dataFileNames)
% 保存log文件名称到指定目录下的.mat文件中
[naviPath,~] = fileparts(which(mfilename));% 在文件所在目录保存.mat文件
curPath = cd;
cd(naviPath);
save lastFlightDataFileLoadedForNavi.mat dataFileNames
cd(curPath);