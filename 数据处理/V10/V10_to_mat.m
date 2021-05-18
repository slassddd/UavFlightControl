clear,clc
setGlobalParams();
if 0
    GLOBAL_PARAM.dirDataFileForDecode = 'D:\work\V1000_firmware\数据处理\V10\';
    DecodeParam.nameDataFile{1} = 'D:\work\V1000_firmware\数据处理\V10\log_31.bin-488896.mat';
else
    DecodeParam.evokeDir = cd; % 调用该函数时matlab的当前文件夹位置
    DecodeParam.nameDecodeFile = which(mfilename);
    DecodeParam.dirDecodeFile = fileparts(DecodeParam.nameDecodeFile);
    [DecodeParam.nameDataFile,isSuccess] = selFileToDecode('any');if ~isSuccess,return;end
    if strcmp(DecodeParam.nameDataFile{1}(end-3:end),'.bin')
        data_read_V10([GLOBAL_PARAM.dirDataFileForDecode,'\',DecodeParam.nameDataFile{1}]);
        DecodeParam.nameDataFile{1}(end-2:end) = 'mat';
    end
    cd(GLOBAL_PARAM.dirDataFileForDecode)
end
%
DecodeParam.nFile = length(DecodeParam.nameDataFile);%
for i_file = 1:DecodeParam.nFile
    V10Log = V10_decode_auto([DecodeParam.nameDataFile{i_file}]);
    %% 缺失数据对齐
    structToAlign = {'V10Log.OUT_TASKFLIGHTPARAM','V10Log.OUT_TASKMODE','V10Log.Debug_Task_RTInfo'}; % 待处理的结构体变量名
    for i_align = 1:length(structToAlign)
        str = sprintf('%s = alignDimension( %s );',structToAlign{i_align},structToAlign{i_align});
        eval(str);
    end
    %% 保存磁力计矫正相关数据
    V10_SaveMagCalibData
    %% 保存仿真数据
%     try
        IN_SENSOR = V10_Decode_Sensors(V10Log);
        FlightLog_Original = V10_Decode_FlightLog_Orignal(V10Log);
%         FlightLog_SecondProc = V10_Decode_FlightLog_SecondProc(V10Log);   
        V10_Decode_FlightLog_SecondProc
        %
        saveFileName{i_file} = [GLOBAL_PARAM.dirDataFileForDecode,'仿真数据_',DecodeParam.nameDataFile{i_file}];%['D:\work\V1000_firmware\数据处理\V10\仿真日志.mat'];
        save(saveFileName{i_file},'IN_SENSOR','FlightLog_Original','FlightLog_SecondProc');
%     end
end
fprintf('[END] 载入数据完成\n');