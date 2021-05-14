% clear,clc
setGlobalParams();

DecodeParam.evokeDir = cd; % 调用该函数时matlab的当前文件夹位置
DecodeParam.nameDecodeFile = which(mfilename);
DecodeParam.dirDecodeFile = fileparts(DecodeParam.nameDecodeFile);
[DecodeParam.nameDataFile,isSuccess] = selFileToDecode('any');if ~isSuccess,return;end
if strcmp(DecodeParam.nameDataFile{1}(end-3:end),'.bin')
    DecodeParam.nameDataFile{1}(end-2:end) = 'mat';
end
cd(GLOBAL_PARAM.dirDataFileForDecode)
%
DecodeParam.nFile = length(DecodeParam.nameDataFile);%
for i_file = 1:DecodeParam.nFile
    V10Log = V10_decode_auto([DecodeParam.nameDataFile{i_file}]);
    %% 保存磁力计矫正相关数据
    V10_SaveMagCalibData
end
fprintf('[END] 载入数据完成\n');