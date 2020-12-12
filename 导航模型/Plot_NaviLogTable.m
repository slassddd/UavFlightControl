% 解析Log事件数据
naviLogDataRes(1).time_sec = out.naviLogData1.time_sec.Data;
naviLogDataRes(1).idx = out.naviLogData1.idx.Data;
naviLogDataRes(1).blockName = out.naviLogData1.blockName.Data;
naviLogDataRes(1).message = out.naviLogData1.message.Data;
naviLogDataRes(1).var1 = out.naviLogData1.var1.Data;
%%
T_naviLog_All = parserNaviLogData(naviLogDataRes)
matchMessages = ENUM_NaviLogBlockName.NAVILOG_Marg22;
T_naviLog_Marg22 = parserNaviLogData(naviLogDataRes,matchMessages);
matchMessages = ENUM_NaviLogBlockName.NAVILOG_Init;
T_naviLog_Init = parserNaviLogData(naviLogDataRes,matchMessages);