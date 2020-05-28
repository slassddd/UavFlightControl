function InfoTable = SingPlot_PowerConsumer(baseTime,structData,altStruct)
fprintf('----------------------------------------------\n')
% time = baseTime;
time = structData.time_cal;
children = fieldnames(structData);
nChildren = length(children);
nrow = ceil(sqrt(nChildren));
ncol = ceil(nChildren/nrow);
fig = figure;
fig.Name = mfilename;
ylabelstr = {...
    '全程电压','全程电流','全程功率','GroundStandby功率','TakeOff功率','HoverAdjust功率',...
    'Rotor2fix功率','HoverUp功率','PathFollow功率','GoHome功率','HoverDown功率','Fix2Rotor功率','Land功率','time'};
idx_nz = 1:length(structData.(children{1}));
for i = 1:nChildren
    subplot(nrow,ncol,i)
    plot(time,structData.(children{i}));
    grid on;
    xlabel('time (sec)');
    ylabel(ylabelstr{i})
end
%% 显示信息
alt = altStruct.value;
time_alt = altStruct.time;
temp = max(alt);
maxAlt = temp(1);
temp = min(alt);
minAlt = temp(1);
maxFlightHeight = maxAlt - minAlt;
val_TakeOff = structData.TakeOff;
val_HoverAdjust = structData.HoverAdjust;
val_Rotor2fix = structData.Rotor2fix;
val_HoverUp = structData.HoverUp;
val_PathFollow = structData.PathFollow;
val_GoHome = structData.GoHome;
val_HoverDown = structData.HoverDown;
val_Fix2Rotor = structData.Fix2Rotor;
val_Land = structData.Land;
% TakeOff     --------------------------------------------------------------
Struct_TakeOff = calParam(time,val_TakeOff,structData);
% Rotor2fix     --------------------------------------------------------------
Struct_Rotor2fix = calParam(time,val_Rotor2fix,structData);
% HoverUp     --------------------------------------------------------------
Struct_HoverUp = calParam(time,val_HoverUp,structData);
% PathFollow --------------------------------------------------------------
Struct_PathFollow = calParam(time,val_PathFollow,structData);
% GoHome     --------------------------------------------------------------
Struct_GoHome = calParam(time,val_GoHome,structData);
% HoverDown     --------------------------------------------------------------
Struct_HoverDown = calParam(time,val_HoverDown,structData);
% Fix2Rotor     --------------------------------------------------------------
Struct_Fix2Rotor = calParam(time,val_Fix2Rotor,structData);
% Land     --------------------------------------------------------------
Struct_Land = calParam(time,val_Land,structData);
% HoverAdjust     --------------------------------------------------------------
Struct_HoverAdjust = calParam(time,val_HoverAdjust,structData);
% 全局
Struct_InAir.t0 = Struct_TakeOff.t0;
Struct_InAir.tf = Struct_Land.tf;
Struct_InAir.du = Struct_InAir.tf - Struct_InAir.t0;

Struct_InAir.p0 = structData.AllTheTimePowerConsume(Struct_TakeOff.idx(1));
Struct_InAir.pf = structData.AllTheTimePowerConsume(Struct_Land.idx(end));
Struct_InAir.pErr = Struct_InAir.p0-Struct_InAir.pf;
% 单位时间耗电量 [%/sec]
Struct_InAir.powerPerSec_up = round((Struct_InAir.pErr+0.9)/Struct_InAir.du,3);
Struct_InAir.powerPerSec_mid = round((Struct_InAir.pErr)/Struct_InAir.du,3);
Struct_InAir.powerPerSec_low = round(max(0.1,Struct_InAir.pErr-0.9)/Struct_InAir.du,3);
% 单位电量的续航时间 [sec/%]
Struct_InAir.duPerPower_low = 1/Struct_InAir.powerPerSec_up; 
Struct_InAir.duPerPower_mid = 1/Struct_InAir.powerPerSec_mid; 
Struct_InAir.duPerPower_up = 1/Struct_InAir.powerPerSec_low; 
% 构造数据table
Info_duration = [Struct_TakeOff.du;Struct_Rotor2fix.du ;Struct_HoverUp.du ;Struct_PathFollow.du ;Struct_GoHome.du ;Struct_HoverDown.du ;Struct_Fix2Rotor.du ;Struct_Land.du ;Struct_InAir.du;];
Info_pErr = [Struct_TakeOff.pErr;Struct_Rotor2fix.pErr ;Struct_HoverUp.pErr ;Struct_PathFollow.pErr ;Struct_GoHome.pErr ;Struct_HoverDown.pErr ;Struct_Fix2Rotor.pErr ;Struct_Land.pErr ;Struct_InAir.pErr;];
Info_powerPerSec = {...
    mat2str([Struct_TakeOff.powerPerSec_low,    Struct_TakeOff.powerPerSec_mid,    Struct_TakeOff.powerPerSec_up]);...
    mat2str([Struct_Rotor2fix.powerPerSec_low,  Struct_Rotor2fix.powerPerSec_mid,  Struct_Rotor2fix.powerPerSec_up]);...
    mat2str([Struct_HoverUp.powerPerSec_low,    Struct_HoverUp.powerPerSec_mid,    Struct_HoverUp.powerPerSec_up]);...
    mat2str([Struct_PathFollow.powerPerSec_low, Struct_PathFollow.powerPerSec_mid, Struct_PathFollow.powerPerSec_up]);...
    mat2str([Struct_GoHome.powerPerSec_low,     Struct_GoHome.powerPerSec_mid,     Struct_GoHome.powerPerSec_up]);...
    mat2str([Struct_HoverDown.powerPerSec_low,  Struct_HoverDown.powerPerSec_mid,  Struct_HoverDown.powerPerSec_up]);...
    mat2str([Struct_Fix2Rotor.powerPerSec_low,  Struct_Fix2Rotor.powerPerSec_mid,  Struct_Fix2Rotor.powerPerSec_up]);...
    mat2str([Struct_Land.powerPerSec_low,       Struct_Land.powerPerSec_mid,       Struct_Land.powerPerSec_up]);...
    mat2str([Struct_InAir.powerPerSec_low,      Struct_InAir.powerPerSec_mid,      Struct_InAir.powerPerSec_up]);};

Info_duPerPower = {...
    mat2str(round([Struct_TakeOff.duPerPower_low,     Struct_TakeOff.duPerPower_mid,     Struct_TakeOff.duPerPower_up],0));...
    mat2str(round([Struct_Rotor2fix.duPerPower_low,   Struct_Rotor2fix.duPerPower_mid,   Struct_Rotor2fix.duPerPower_up],0));...
    mat2str(round([Struct_HoverUp.duPerPower_low,     Struct_HoverUp.duPerPower_mid,     Struct_HoverUp.duPerPower_up],0));...
    mat2str(round([Struct_PathFollow.duPerPower_low,  Struct_PathFollow.duPerPower_mid,  Struct_PathFollow.duPerPower_up],0));...
    mat2str(round([Struct_GoHome.duPerPower_low,      Struct_GoHome.duPerPower_mid,      Struct_GoHome.duPerPower_up],0));...
    mat2str(round([Struct_HoverDown.duPerPower_low,   Struct_HoverDown.duPerPower_mid,   Struct_HoverDown.duPerPower_up],0));...
    mat2str(round([Struct_Fix2Rotor.duPerPower_low,   Struct_Fix2Rotor.duPerPower_mid,   Struct_Fix2Rotor.duPerPower_up],0));...
    mat2str(round([Struct_Land.duPerPower_low,        Struct_Land.duPerPower_mid,        Struct_Land.duPerPower_up],0));...
    mat2str(round([Struct_InAir.duPerPower_low,       Struct_InAir.duPerPower_mid,       Struct_InAir.duPerPower_up],0));};
%
% InfoTable = table(TakeOff,Rotor2fix,HoverUp,PathFollow,GoHome,HoverDown,Fix2Rotor,Land,InAir);
% InfoTable.Row = {'飞行时间[sec]','耗电量[%]','每秒耗电[%/sec]','单位电量续航[sec/%]'};
% InfoTable

InfoTable = table(Info_duration,Info_pErr,Info_powerPerSec,Info_duPerPower);
InfoTable.Row = {'TakeOff','Rotor2fix','HoverUp','PathFollow','GoHome','HoverDown','Fix2Rotor','Land','全程'};
InfoTable.Properties.VariableNames = {'续航时间[sec]','耗电量[%]','每秒耗电量[%/sec]','单位电量续航[sec/%]'};
InfoTable
%% 子函数
function Struct = calParam(time,val,structData)
Struct.idx = find(val~=0);
if isempty(Struct.idx)
    varname = inputname(2);
    flagIdx = strfind(varname,'_');
    modeName = varname(flagIdx+1:end);
    fprintf('该数据没有%s模式\n',modeName);
    Struct.idx = 1;
end
Struct.time = time(Struct.idx);
Struct.t0 = Struct.time(1);
Struct.tf = Struct.time(end);
Struct.du = Struct.tf - Struct.t0;
Struct.p0 = structData.AllTheTimePowerConsume(Struct.idx(1));
Struct.pf = structData.AllTheTimePowerConsume(Struct.idx(end));
Struct.pErr = Struct.p0-Struct.pf;
Struct.powerPerSec_up = round((Struct.pErr+0.9)/Struct.du,3);
Struct.powerPerSec_mid = round((Struct.pErr)/Struct.du,3);
Struct.powerPerSec_low = round(max(0.1,Struct.pErr-0.9)/Struct.du,3);
Struct.duPerPower_low = 1/Struct.powerPerSec_up; 
Struct.duPerPower_mid = 1/Struct.powerPerSec_mid; 
Struct.duPerPower_up = 1/Struct.powerPerSec_low;
