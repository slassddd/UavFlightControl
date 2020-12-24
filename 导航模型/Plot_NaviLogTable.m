% 解析Log事件数据
tempIdx = 1:length(out.naviLogData1.time_sec.Data);
% tempIdx = 1:10000;
naviLogDataRes(1).time_sec = out.naviLogData1.time_sec.Data(tempIdx);
naviLogDataRes(1).idx = out.naviLogData1.idx.Data(tempIdx);
naviLogDataRes(1).blockName = out.naviLogData1.blockName.Data(tempIdx);
naviLogDataRes(1).message = out.naviLogData1.message.Data(tempIdx);
naviLogDataRes(1).var1 = out.naviLogData1.var1.Data(tempIdx,:);
%%
T_naviLog_All = parserLogData(naviLogDataRes);
% block选择
matchBlock = ENUM_NaviLogBlockName.NAVILOG_Marg22;
T_naviLog_Marg22 = parserLogData(naviLogDataRes,'BlockName',matchBlock,'Decimation',1);
matchBlock = ENUM_NaviLogBlockName.NAVILOG_Init;
T_naviLog_Init = parserLogData(naviLogDataRes,'BlockName',matchBlock);
% message选择
matchMessage = ENUM_RTInfo_Navi.RTIN_Filter_GPSVelErrorLarge;
T_naviLog_GPSVelErrorLarge = parserLogData(naviLogDataRes,'MessageName',matchMessage,'Decimation',1);
matchMessage = ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Ublox;
T_naviLog_Fuse_Ublox = parserLogData(naviLogDataRes,'MessageName',matchMessage,'Decimation',1);