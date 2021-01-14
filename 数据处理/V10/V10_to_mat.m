clear,clc
cd D:\work\V1000_firmware\数据处理\V10\
dataFileName{1} = 'D:\work\V1000_firmware\数据处理\V10\log_31.bin-488896.mat';
% 
V10Log = V10_DecodePX4Format([dataFileName{1}]);
IN_SENSOR = V10_Decode_Sensors(V10Log);
FlightLog_Original = V10_Decode_FlightLog_Orignal(V10Log);
load('SubFolder_ICD\IOBusInfo_V1000')
FlightLog_SecondProc = V10_Decode_FlightLog_SecondProc(V10Log);
%%
saveFileName{1} = ['D:\work\V1000_firmware\数据处理\V10\仿真日志.mat'];
save(saveFileName{1},'IN_SENSOR','FlightLog_Original','FlightLog_SecondProc');