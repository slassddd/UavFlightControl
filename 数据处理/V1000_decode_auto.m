baseIMUtime = IN_SENSOR.IMU1.time;
baseIMUtime = IN_SENSOR.IMU1.time;
% /* ------------------------------algo sl  log ---------------------------------------------- */20200312
% /* |@@MagCalib.mag1@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,4)==0),109:110)'],1,[]);
x=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag1.x = x; % create struct
temp = reshape([data(find(mod(Count,4)==0),111:112)'],1,[]);
y=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag1.y = y; % create struct
temp = reshape([data(find(mod(Count,4)==0),113:114)'],1,[]);
z=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag1.z = z; % create struct
% /* |@@MagCalib.mag2@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,4)==0),115:116)'],1,[]);
x=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag2.x = x; % create struct
temp = reshape([data(find(mod(Count,4)==0),117:118)'],1,[]);
y=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag2.y = y; % create struct
temp = reshape([data(find(mod(Count,4)==0),119:120)'],1,[]);
z=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag2.z = z; % create struct
% /* |@@MagCalib.mag3@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,4)==0),121:122)'],1,[]);
x=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag3.x = x; % create struct
temp = reshape([data(find(mod(Count,4)==0),123:124)'],1,[]);
y=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag3.y = y; % create struct
temp = reshape([data(find(mod(Count,4)==0),125:126)'],1,[]);
z=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag3.z = z; % create struct
% /* |@@MagCalib.mag_cal_0@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,2)==1),167:168)'],1,[]);
x=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag_cal_0.x = x; % create struct
temp = reshape([data(find(mod(Count,2)==1),169:170)'],1,[]);
y=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag_cal_0.y = y; % create struct
temp = reshape([data(find(mod(Count,2)==1),171:172)'],1,[]);
z=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag_cal_0.z = z; % create struct
% /* |@@MagCalib.mag_cal_1@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,2)==1),191:192)'],1,[]);
x=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag_cal_1.x = x; % create struct
temp = reshape([data(find(mod(Count,2)==1),193:194)'],1,[]);
y=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag_cal_1.y = y; % create struct
temp = reshape([data(find(mod(Count,2)==1),195:196)'],1,[]);
z=double(typecast(uint8(temp),'int16')')/32768*2.0000000000;
MagCalib.mag_cal_1.z = z; % create struct
% /* |-----------+--------------------------------+-------------+------------+--------------| */
% /* |@@SL.SystemInfo@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,1)==0),1:2)'],1,[]);
save_count=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.save_count = save_count; % create struct
temp = reshape([data(find(mod(Count,1)==0),251:254)'],1,[]);
save_time=double(typecast(uint8(temp),'uint32')')/1*1.0000000000;
SL.SystemInfo.save_time = save_time; % create struct
temp = reshape([data(find(mod(Count,8)==0),255:256)'],1,[]);
FCVERSION=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.FCVERSION = FCVERSION; % create struct
temp = reshape([data(find(mod(Count,8)==1),255:256)'],1,[]);
GPSVERSION=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.GPSVERSION = GPSVERSION; % create struct
temp = reshape([data(find(mod(Count,8)==2),255:256)'],1,[]);
LOADERVERSION=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.LOADERVERSION = LOADERVERSION; % create struct
temp = reshape([data(find(mod(Count,8)==3),255:256)'],1,[]);
MCU2VERSION=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.MCU2VERSION = MCU2VERSION; % create struct
temp = reshape([data(find(mod(Count,8)==4),255:256)'],1,[]);
ALGO_LOGICVERSION=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.ALGO_LOGICVERSION = ALGO_LOGICVERSION; % create struct
temp = reshape([data(find(mod(Count,8)==5),255:256)'],1,[]);
ALGO_DRIVERVERSION=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.SystemInfo.ALGO_DRIVERVERSION = ALGO_DRIVERVERSION; % create struct
temp = reshape([data(find(mod(Count,4)==3),121:124)'],1,[]);
task_1ms_total_cnt=double(typecast(uint8(temp),'uint32')')/1*1.0000000000;
SL.SystemInfo.task_1ms_total_cnt = task_1ms_total_cnt; % create struct
temp = reshape([data(find(mod(Count,4)==3),125:128)'],1,[]);
task_4ms_total_cnt=double(typecast(uint8(temp),'uint32')')/1*1.0000000000;
SL.SystemInfo.task_4ms_total_cnt = task_4ms_total_cnt; % create struct
temp = reshape([data(find(mod(Count,4)==3),129:132)'],1,[]);
task_12ms_total_cnt=double(typecast(uint8(temp),'uint32')')/1*1.0000000000;
SL.SystemInfo.task_12ms_total_cnt = task_12ms_total_cnt; % create struct
temp = reshape([data(find(mod(Count,4)==3),133:136)'],1,[]);
task_100ms_total_cnt=double(typecast(uint8(temp),'uint32')')/1*1.0000000000;
SL.SystemInfo.task_100ms_total_cnt = task_100ms_total_cnt; % create struct
% /*-----------------------RefModel_SystemArchitecture_Y.OUT_SensorSignalIntegrity.-----------*/
% /* |@@SL.SensorSelect@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==0),223:224)'],1,[]);
IMU=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.IMU = IMU; % create struct
temp = reshape([data(find(mod(Count,16)==0),225:226)'],1,[]);
Mag=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.Mag = Mag; % create struct
temp = reshape([data(find(mod(Count,16)==0),227:228)'],1,[]);
GPS=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.GPS = GPS; % create struct
temp = reshape([data(find(mod(Count,16)==1),223:224)'],1,[]);
Baro=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.Baro = Baro; % create struct
temp = reshape([data(find(mod(Count,16)==1),225:226)'],1,[]);
Radar=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.Radar = Radar; % create struct
temp = reshape([data(find(mod(Count,16)==1),227:228)'],1,[]);
Camera=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.Camera = Camera; % create struct
temp = reshape([data(find(mod(Count,16)==2),223:224)'],1,[]);
Lidar=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorSelect.Lidar = Lidar; % create struct
% /* |@@SL.SensorUpdateFlag@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==2),225:225)'],1,[]);
mag1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.mag1 = mag1; % create struct
temp = reshape([data(find(mod(Count,16)==2),226:226)'],1,[]);
mag2=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.mag2 = mag2; % create struct
temp = reshape([data(find(mod(Count,16)==2),227:227)'],1,[]);
um482=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.um482 = um482; % create struct
temp = reshape([data(find(mod(Count,16)==2),228:228)'],1,[]);
airspeed1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.airspeed1 = airspeed1; % create struct
temp = reshape([data(find(mod(Count,16)==3),223:223)'],1,[]);
ublox1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.ublox1 = ublox1; % create struct
temp = reshape([data(find(mod(Count,16)==3),224:224)'],1,[]);
radar1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.radar1 = radar1; % create struct
temp = reshape([data(find(mod(Count,16)==3),225:225)'],1,[]);
IMU1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.IMU1 = IMU1; % create struct
temp = reshape([data(find(mod(Count,16)==3),226:226)'],1,[]);
IMU2=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.IMU2 = IMU2; % create struct
temp = reshape([data(find(mod(Count,16)==3),227:227)'],1,[]);
IMU3=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.IMU3 = IMU3; % create struct
temp = reshape([data(find(mod(Count,16)==3),228:228)'],1,[]);
baro1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorUpdateFlag.baro1 = baro1; % create struct
% /* |@@SL.SensorLosttime@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==4),223:224)'],1,[]);
mag1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.mag1 = mag1; % create struct
temp = reshape([data(find(mod(Count,16)==4),225:226)'],1,[]);
mag2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.mag2 = mag2; % create struct
temp = reshape([data(find(mod(Count,16)==4),227:228)'],1,[]);
um482=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.um482 = um482; % create struct
temp = reshape([data(find(mod(Count,16)==5),223:224)'],1,[]);
airspeed1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.airspeed1 = airspeed1; % create struct
temp = reshape([data(find(mod(Count,16)==5),225:226)'],1,[]);
radar1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.radar1 = radar1; % create struct
temp = reshape([data(find(mod(Count,16)==5),227:228)'],1,[]);
ublox1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.ublox1 = ublox1; % create struct
temp = reshape([data(find(mod(Count,16)==6),223:224)'],1,[]);
IMU1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.IMU1 = IMU1; % create struct
temp = reshape([data(find(mod(Count,16)==6),225:226)'],1,[]);
IMU2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.IMU2 = IMU2; % create struct
temp = reshape([data(find(mod(Count,16)==6),227:228)'],1,[]);
IMU3=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.IMU3 = IMU3; % create struct
temp = reshape([data(find(mod(Count,16)==7),223:224)'],1,[]);
baro1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SensorLosttime.baro1 = baro1; % create struct
% /* |@@SL.SensorStatus@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==7),225:225)'],1,[]);
mag1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.mag1 = mag1; % create struct
temp = reshape([data(find(mod(Count,16)==7),226:226)'],1,[]);
mag2=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.mag2 = mag2; % create struct
temp = reshape([data(find(mod(Count,16)==7),227:227)'],1,[]);
um482=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.um482 = um482; % create struct
temp = reshape([data(find(mod(Count,16)==7),228:228)'],1,[]);
airspeed1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.airspeed1 = airspeed1; % create struct
temp = reshape([data(find(mod(Count,16)==8),223:223)'],1,[]);
radar1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.radar1 = radar1; % create struct
temp = reshape([data(find(mod(Count,16)==8),224:224)'],1,[]);
ublox1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.ublox1 = ublox1; % create struct
temp = reshape([data(find(mod(Count,16)==8),225:225)'],1,[]);
IMU1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.IMU1 = IMU1; % create struct
temp = reshape([data(find(mod(Count,16)==8),226:226)'],1,[]);
IMU2=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.IMU2 = IMU2; % create struct
temp = reshape([data(find(mod(Count,16)==8),227:227)'],1,[]);
IMU3=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.IMU3 = IMU3; % create struct
temp = reshape([data(find(mod(Count,16)==8),228:228)'],1,[]);
baro1=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.baro1 = baro1; % create struct
temp = reshape([data(find(mod(Count,16)==9),223:223)'],1,[]);
SystemHealthStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.SensorStatus.SystemHealthStatus = SystemHealthStatus; % create struct
% /*             ----------RefModel_SystemArchitecture_Y.OUT_PAYLOAD.-----------------------| */										
% /* |@@SL.CAMERA@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==9),225:226)'],1,[]);
time=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.CAMERA.time = time; % create struct
temp = reshape([data(find(mod(Count,16)==9),227:228)'],1,[]);
trigger=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.CAMERA.trigger = trigger; % create struct
temp = reshape([data(find(mod(Count,16)==10),223:226)'],1,[]);
LLA0=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.CAMERA.LLA0 = LLA0; % create struct
temp = reshape([data(find(mod(Count,16)==15),223:226)'],1,[]);
LLA1=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.CAMERA.LLA1 = LLA1; % create struct
temp = reshape([data(find(mod(Count,16)==15),227:228)'],1,[]);
LLA2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.CAMERA.LLA2 = LLA2; % create struct
temp = reshape([data(find(mod(Count,16)==11),223:224)'],1,[]);
groundspeed=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.CAMERA.groundspeed = groundspeed; % create struct
% /* |@@SL.LIDAR@@+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==11),225:226)'],1,[]);
time=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.LIDAR.time = time; % create struct
temp = reshape([data(find(mod(Count,16)==11),227:228)'],1,[]);
trigger=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.LIDAR.trigger = trigger; % create struct
temp = reshape([data(find(mod(Count,16)==12),223:224)'],1,[]);
LLA0=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.LIDAR.LLA0 = LLA0; % create struct
temp = reshape([data(find(mod(Count,16)==12),225:226)'],1,[]);
LLA1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.LIDAR.LLA1 = LLA1; % create struct
temp = reshape([data(find(mod(Count,16)==12),227:228)'],1,[]);
LLA2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.LIDAR.LLA2 = LLA2; % create struct
temp = reshape([data(find(mod(Count,16)==13),223:224)'],1,[]);
groundspeed=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.LIDAR.groundspeed = groundspeed; % create struct
% /*-----------------------SimParam_LLA    -------------------------------------------------| */										
% /* |@@SL.SimParam_LLA@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==13),225:226)'],1,[]);
SimParam_LLA0=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SimParam_LLA.SimParam_LLA0 = SimParam_LLA0; % create struct
temp = reshape([data(find(mod(Count,16)==13),227:228)'],1,[]);
SimParam_LLA1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SimParam_LLA.SimParam_LLA1 = SimParam_LLA1; % create struct
temp = reshape([data(find(mod(Count,16)==14),223:224)'],1,[]);
SimParam_LLA2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.SimParam_LLA.SimParam_LLA2 = SimParam_LLA2; % create struct
% /*-----------------------Debug_Task_RTInfo    ---------------------------------------------------*/										
% /* |@@SL.Debug_Task_RTInfo@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==14),225:226)'],1,[]);
Task=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.Debug_Task_RTInfo.Task = Task; % create struct
temp = reshape([data(find(mod(Count,16)==14),227:228)'],1,[]);
Payload=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.Debug_Task_RTInfo.Payload = Payload; % create struct
temp = reshape([data(find(mod(Count,16)==10),227:227)'],1,[]);
GSCmd=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.GSCmd = GSCmd; % create struct
temp = reshape([data(find(mod(Count,16)==10),228:228)'],1,[]);
Warning=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.Warning = Warning; % create struct
temp = reshape([data(find(mod(Count,16)==9),231:231)'],1,[]);
ComStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.ComStatus = ComStatus; % create struct
temp = reshape([data(find(mod(Count,16)==9),232:232)'],1,[]);
FenseStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.FenseStatus = FenseStatus; % create struct
temp = reshape([data(find(mod(Count,16)==12),231:231)'],1,[]);
StallStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.StallStatus = StallStatus; % create struct
temp = reshape([data(find(mod(Count,16)==12),232:232)'],1,[]);
SensorStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.SensorStatus = SensorStatus; % create struct
temp = reshape([data(find(mod(Count,16)==9),235:235)'],1,[]);
BatteryStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.BatteryStatus = BatteryStatus; % create struct
temp = reshape([data(find(mod(Count,16)==9),236:236)'],1,[]);
FixWingHeightStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.FixWingHeightStatus = FixWingHeightStatus; % create struct
temp = reshape([data(find(mod(Count,16)==0),243:243)'],1,[]);
FindWind=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.FindWind = FindWind; % create struct
temp = reshape([data(find(mod(Count,16)==0),244:244)'],1,[]);
LandCond1_Acc_H=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.LandCond1_Acc_H = LandCond1_Acc_H; % create struct
temp = reshape([data(find(mod(Count,16)==1),243:243)'],1,[]);
LandCond1_Vd_H=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.LandCond1_Vd_H = LandCond1_Vd_H; % create struct
temp = reshape([data(find(mod(Count,16)==1),244:244)'],1,[]);
LandCond3_near=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_Task_RTInfo.LandCond3_near = LandCond3_near; % create struct
temp = reshape([data(find(mod(Count,16)==2),243:244)'],1,[]);
maxDist_Path2Home=double(typecast(uint8(temp),'int16')')/32768*32000.0000000000;
SL.Debug_Task_RTInfo.maxDist_Path2Home = maxDist_Path2Home; % create struct
temp = reshape([data(find(mod(Count,16)==3),243:244)'],1,[]);
realtimeFenseDist=double(typecast(uint8(temp),'int16')')/32768*32000.0000000000;
SL.Debug_Task_RTInfo.realtimeFenseDist = realtimeFenseDist; % create struct
% /* +===========+================================+=============+============+==============+ */
% /* ------------------------------algo sl output -------------------------------------------| */
% /* ------------+RefModel_SystemArchitecture_Y.OUT_TASKMODE---------------------------------| */
% /* |@@SL.OUT_TASKMODE@@+--------------------------------+-------------+------------+---------------| */
temp = reshape([data(find(mod(Count,16)==0),229:230)'],1,[]);
currentPointNum=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_TASKMODE.currentPointNum = currentPointNum; % create struct
temp = reshape([data(find(mod(Count,16)==0),231:232)'],1,[]);
prePointNum=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_TASKMODE.prePointNum = prePointNum; % create struct
temp = reshape([data(find(mod(Count,16)==1),229:230)'],1,[]);
validPathNum=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_TASKMODE.validPathNum = validPathNum; % create struct
temp = reshape([data(find(mod(Count,16)==1),231:232)'],1,[]);
headingCmd=double(typecast(uint8(temp),'int16')')/32768*6.3000000000;
SL.OUT_TASKMODE.headingCmd = headingCmd; % create struct
temp = reshape([data(find(mod(Count,16)==2),229:230)'],1,[]);
distToGo=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.distToGo = distToGo; % create struct
temp = reshape([data(find(mod(Count,16)==2),231:232)'],1,[]);
dz=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.dz = dz; % create struct
temp = reshape([data(find(mod(Count,16)==3),229:230)'],1,[]);
groundspeedCmd=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.groundspeedCmd = groundspeedCmd; % create struct
temp = reshape([data(find(mod(Count,16)==3),231:232)'],1,[]);
rollCmd=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.rollCmd = rollCmd; % create struct
temp = reshape([data(find(mod(Count,16)==4),229:230)'],1,[]);
turnRadiusCmd=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.turnRadiusCmd = turnRadiusCmd; % create struct
temp = reshape([data(find(mod(Count,16)==4),231:232)'],1,[]);
heightCmd=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.heightCmd = heightCmd; % create struct
temp = reshape([data(find(mod(Count,16)==5),229:232)'],1,[]);
turnCenterLL0=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKMODE.turnCenterLL0 = turnCenterLL0; % create struct
temp = reshape([data(find(mod(Count,16)==6),229:232)'],1,[]);
turnCenterLL1=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKMODE.turnCenterLL1 = turnCenterLL1; % create struct
temp = reshape([data(find(mod(Count,16)==7),229:230)'],1,[]);
dR_turn=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.dR_turn = dR_turn; % create struct
temp = reshape([data(find(mod(Count,16)==7),231:231)'],1,[]);
uavMode=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.uavMode = uavMode; % create struct
temp = reshape([data(find(mod(Count,16)==7),232:232)'],1,[]);
flightTaskMode=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.flightTaskMode = flightTaskMode; % create struct
temp = reshape([data(find(mod(Count,16)==8),229:229)'],1,[]);
flightControlMode=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.flightControlMode = flightControlMode; % create struct
temp = reshape([data(find(mod(Count,16)==8),230:230)'],1,[]);
AutoManualMode=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.AutoManualMode = AutoManualMode; % create struct
temp = reshape([data(find(mod(Count,16)==8),231:231)'],1,[]);
comStatus=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.comStatus = comStatus; % create struct
temp = reshape([data(find(mod(Count,16)==9),229:230)'],1,[]);
maxClimbSpeed=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
SL.OUT_TASKMODE.maxClimbSpeed = maxClimbSpeed; % create struct
temp = reshape([data(find(mod(Count,16)==10),229:232)'],1,[]);
prePathPoint_LLA0=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKMODE.prePathPoint_LLA0 = prePathPoint_LLA0; % create struct
temp = reshape([data(find(mod(Count,16)==11),229:232)'],1,[]);
prePathPoint_LLA1=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKMODE.prePathPoint_LLA1 = prePathPoint_LLA1; % create struct
temp = reshape([data(find(mod(Count,16)==12),229:230)'],1,[]);
prePathPoint_LLA2=double(typecast(uint8(temp),'int16')')/32768*1.0000000000;
SL.OUT_TASKMODE.prePathPoint_LLA2 = prePathPoint_LLA2; % create struct
temp = reshape([data(find(mod(Count,16)==13),229:232)'],1,[]);
curPathPoint_LLA0=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKMODE.curPathPoint_LLA0 = curPathPoint_LLA0; % create struct
temp = reshape([data(find(mod(Count,16)==14),229:232)'],1,[]);
curPathPoint_LLA1=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKMODE.curPathPoint_LLA1 = curPathPoint_LLA1; % create struct
temp = reshape([data(find(mod(Count,16)==15),229:230)'],1,[]);
curPathPoint_LLA2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKMODE.curPathPoint_LLA2 = curPathPoint_LLA2; % create struct
temp = reshape([data(find(mod(Count,16)==1),245:245)'],1,[]);
isTaskComplete=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.isTaskComplete = isTaskComplete; % create struct
temp = reshape([data(find(mod(Count,16)==1),246:246)'],1,[]);
isHeadingRotate_OnGround=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_TASKMODE.isHeadingRotate_OnGround = isHeadingRotate_OnGround; % create struct
temp = reshape([data(find(mod(Count,16)==2),245:246)'],1,[]);
numTakeOff=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_TASKMODE.numTakeOff = numTakeOff; % create struct
% /* ------------+RefModel_SystemArchitecture_Y.OUT_FLIGHTPARAM------------------------------| */
% /* |@@SL.OUT_TASKFLIGHTPARAM@@+--------------------------------+-------------+------------+---------------| */
temp = reshape([data(find(mod(Count,16)==0),233:236)'],1,[]);
curHomeLLA0=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKFLIGHTPARAM.curHomeLLA0 = curHomeLLA0; % create struct
temp = reshape([data(find(mod(Count,16)==1),233:236)'],1,[]);
curHomeLLA1=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKFLIGHTPARAM.curHomeLLA1 = curHomeLLA1; % create struct
temp = reshape([data(find(mod(Count,16)==2),233:234)'],1,[]);
curHomeLLA2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curHomeLLA2 = curHomeLLA2; % create struct
temp = reshape([data(find(mod(Count,16)==2),235:236)'],1,[]);
curVelNED0=double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
SL.OUT_TASKFLIGHTPARAM.curVelNED0 = curVelNED0; % create struct
temp = reshape([data(find(mod(Count,16)==3),233:234)'],1,[]);
curVelNED1=double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
SL.OUT_TASKFLIGHTPARAM.curVelNED1 = curVelNED1; % create struct
temp = reshape([data(find(mod(Count,16)==3),235:236)'],1,[]);
curVelNED2=double(typecast(uint8(temp),'int16')')/32768*30.0000000000;
SL.OUT_TASKFLIGHTPARAM.curVelNED2 = curVelNED2; % create struct
temp = reshape([data(find(mod(Count,16)==4),233:234)'],1,[]);
curSpeed=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curSpeed = curSpeed; % create struct
temp = reshape([data(find(mod(Count,16)==4),235:236)'],1,[]);
curAirSpeed=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curAirSpeed = curAirSpeed; % create struct
temp = reshape([data(find(mod(Count,16)==5),233:234)'],1,[]);
curEuler0=double(typecast(uint8(temp),'int16')')/32768*10.0000000000;
SL.OUT_TASKFLIGHTPARAM.curEuler0 = curEuler0; % create struct
temp = reshape([data(find(mod(Count,16)==5),235:236)'],1,[]);
curEuler1=double(typecast(uint8(temp),'int16')')/32768*10.0000000000;
SL.OUT_TASKFLIGHTPARAM.curEuler1 = curEuler1; % create struct
temp = reshape([data(find(mod(Count,16)==6),233:234)'],1,[]);
curEuler2=double(typecast(uint8(temp),'int16')')/32768*10.0000000000;
SL.OUT_TASKFLIGHTPARAM.curEuler2 = curEuler2; % create struct
temp = reshape([data(find(mod(Count,16)==6),235:236)'],1,[]);
curWB0=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curWB0 = curWB0; % create struct
temp = reshape([data(find(mod(Count,16)==7),233:234)'],1,[]);
curWB1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curWB1 = curWB1; % create struct
temp = reshape([data(find(mod(Count,16)==7),235:236)'],1,[]);
curWB2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curWB2 = curWB2; % create struct
temp = reshape([data(find(mod(Count,16)==8),233:234)'],1,[]);
curPosNED0=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curPosNED0 = curPosNED0; % create struct
temp = reshape([data(find(mod(Count,16)==8),235:236)'],1,[]);
curPosNED1=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curPosNED1 = curPosNED1; % create struct
temp = reshape([data(find(mod(Count,16)==9),233:234)'],1,[]);
curPosNED2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curPosNED2 = curPosNED2; % create struct
temp = reshape([data(find(mod(Count,16)==10),233:236)'],1,[]);
curLLA0=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKFLIGHTPARAM.curLLA0 = curLLA0; % create struct
temp = reshape([data(find(mod(Count,16)==11),233:236)'],1,[]);
curLLA1=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.OUT_TASKFLIGHTPARAM.curLLA1 = curLLA1; % create struct
temp = reshape([data(find(mod(Count,16)==12),233:234)'],1,[]);
curLLA2=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curLLA2 = curLLA2; % create struct
temp = reshape([data(find(mod(Count,16)==12),235:236)'],1,[]);
curGroundSpeed=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curGroundSpeed = curGroundSpeed; % create struct
temp = reshape([data(find(mod(Count,16)==13),233:234)'],1,[]);
curAccZ=double(typecast(uint8(temp),'int16')')/32768*10000.0000000000;
SL.OUT_TASKFLIGHTPARAM.curAccZ = curAccZ; % create struct
% /* +===========+================================+=============+============+==============+ */
% /* |-----------+--------------------------------+-------------+------------+--------------| */
% /* |@@Bus_TASK_WindParam@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==13),235:236)'],1,[]);
sailWindSpeed=double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
Bus_TASK_WindParam.sailWindSpeed = sailWindSpeed; % create struct
temp = reshape([data(find(mod(Count,16)==14),233:234)'],1,[]);
sailWindHeading=double(typecast(uint8(temp),'int16')')/32768*10.0000000000;
Bus_TASK_WindParam.sailWindHeading = sailWindHeading; % create struct
temp = reshape([data(find(mod(Count,16)==14),235:236)'],1,[]);
windSpeedMax=double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
Bus_TASK_WindParam.windSpeedMax = windSpeedMax; % create struct
temp = reshape([data(find(mod(Count,16)==15),233:234)'],1,[]);
windSpeedMin=double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
Bus_TASK_WindParam.windSpeedMin = windSpeedMin; % create struct
temp = reshape([data(find(mod(Count,16)==15),235:236)'],1,[]);
maxWindHeading=double(typecast(uint8(temp),'int16')')/32768*10.0000000000;
Bus_TASK_WindParam.maxWindHeading = maxWindHeading; % create struct
% /* +===========+================================+=============+============+==============+ */
% /* |@@IMUData@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,1)==0),3:6)'],1,[]);
ax=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.ax = ax; % create struct
temp = reshape([data(find(mod(Count,1)==0),7:10)'],1,[]);
ay=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.ay = ay; % create struct
temp = reshape([data(find(mod(Count,1)==0),11:14)'],1,[]);
az=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.az = az; % create struct
temp = reshape([data(find(mod(Count,1)==0),15:18)'],1,[]);
gx=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.gx = gx; % create struct
temp = reshape([data(find(mod(Count,1)==0),19:22)'],1,[]);
gy=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.gy = gy; % create struct
temp = reshape([data(find(mod(Count,1)==0),23:26)'],1,[]);
gz=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.gz = gz; % create struct
% /* |-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,4)==1),239:242)'],1,[]);
a2x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.a2x = a2x; % create struct
temp = reshape([data(find(mod(Count,4)==1),257:260)'],1,[]);
a2y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.a2y = a2y; % create struct
temp = reshape([data(find(mod(Count,4)==1),261:264)'],1,[]);
a2z=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.a2z = a2z; % create struct
temp = reshape([data(find(mod(Count,4)==1),265:268)'],1,[]);
g2x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.g2x = g2x; % create struct
temp = reshape([data(find(mod(Count,4)==1),269:272)'],1,[]);
g2y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.g2y = g2y; % create struct
temp = reshape([data(find(mod(Count,4)==1),273:276)'],1,[]);
g2z=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.g2z = g2z; % create struct
% /* |-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,4)==2),239:242)'],1,[]);
a3x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.a3x = a3x; % create struct
temp = reshape([data(find(mod(Count,4)==2),257:260)'],1,[]);
a3y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.a3y = a3y; % create struct
temp = reshape([data(find(mod(Count,4)==2),261:264)'],1,[]);
a3z=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.a3z = a3z; % create struct
temp = reshape([data(find(mod(Count,4)==2),265:268)'],1,[]);
g3x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.g3x = g3x; % create struct
temp = reshape([data(find(mod(Count,4)==2),269:272)'],1,[]);
g3y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.g3y = g3y; % create struct
temp = reshape([data(find(mod(Count,4)==2),273:276)'],1,[]);
g3z=double(typecast(uint8(temp),'single')')/1*1.0000000000;
IMUData.g3z = g3z; % create struct
% /* |-----------+--------------------------------+-------------+------------+--------------| */
% /* ------------------------------algo sl imu log ----------------------------------------- */20200401
% /* |@@imu_filt@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,1)==0),27:28)'],1,[]);
algo_imu_filtax=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
imu_filt.algo_imu_filtax = algo_imu_filtax; % create struct
temp = reshape([data(find(mod(Count,1)==0),29:30)'],1,[]);
algo_imu_filtay=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
imu_filt.algo_imu_filtay = algo_imu_filtay; % create struct
temp = reshape([data(find(mod(Count,1)==0),31:32)'],1,[]);
algo_imu_filtaz=double(typecast(uint8(temp),'int16')')/32768*80.0000000000;
imu_filt.algo_imu_filtaz = algo_imu_filtaz; % create struct
temp = reshape([data(find(mod(Count,1)==0),33:34)'],1,[]);
algo_imu_filtgx=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
imu_filt.algo_imu_filtgx = algo_imu_filtgx; % create struct
temp = reshape([data(find(mod(Count,1)==0),35:36)'],1,[]);
algo_imu_filtgy=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
imu_filt.algo_imu_filtgy = algo_imu_filtgy; % create struct
temp = reshape([data(find(mod(Count,1)==0),37:38)'],1,[]);
algo_imu_filtgz=double(typecast(uint8(temp),'int16')')/32768*17.5000000000;
imu_filt.algo_imu_filtgz = algo_imu_filtgz; % create struct
% /* |@@SL.HomePointFromGS@@-----------+--------------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,8)==4),203:204)'],1,[]);
mavlink_msg_groundHomeLLA0=double(typecast(uint8(temp),'int16')')/32768*180.0000000000;
SL.HomePointFromGS.mavlink_msg_groundHomeLLA0 = mavlink_msg_groundHomeLLA0; % create struct
temp = reshape([data(find(mod(Count,8)==4),205:206)'],1,[]);
mavlink_msg_groundHomeLLA1=double(typecast(uint8(temp),'int16')')/32768*180.0000000000;
SL.HomePointFromGS.mavlink_msg_groundHomeLLA1 = mavlink_msg_groundHomeLLA1; % create struct
temp = reshape([data(find(mod(Count,8)==4),207:208)'],1,[]);
mavlink_msg_groundHomeLLA2=double(typecast(uint8(temp),'int16')')/32768*5000.0000000000;
SL.HomePointFromGS.mavlink_msg_groundHomeLLA2 = mavlink_msg_groundHomeLLA2; % create struct
% /* +===========+================================+=============+============+===============+ */
% /* +===========+================================+=============+============+===============+ */
% /* +===========+================================+=============+============+==============+ */
% /* |@@Engine@@+-------------------------------+-------------+--------------| */
temp = reshape([data(find(mod(Count,2)==1),137:138)'],1,[]);
servo_out0=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
Engine.servo_out0 = servo_out0; % create struct
temp = reshape([data(find(mod(Count,2)==1),139:140)'],1,[]);
servo_out1=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
Engine.servo_out1 = servo_out1; % create struct
temp = reshape([data(find(mod(Count,2)==1),141:142)'],1,[]);
servo_out2=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
Engine.servo_out2 = servo_out2; % create struct
temp = reshape([data(find(mod(Count,2)==1),143:144)'],1,[]);
servo_out3=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
Engine.servo_out3 = servo_out3; % create struct
% /*             ----------RefModel_SystemArchitecture_Y.OUT_BATTERY.-----------------------| */										
% /* |@@SL.PowerConsume@@-------------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==5),243:244)'],1,[]);
AllTheTimeVoltage=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.PowerConsume.AllTheTimeVoltage = AllTheTimeVoltage; % create struct
temp = reshape([data(find(mod(Count,16)==6),243:246)'],1,[]);
AllTheTimeCurrent=double(typecast(uint8(temp),'int32')')/1*1.0000000000;
SL.PowerConsume.AllTheTimeCurrent = AllTheTimeCurrent; % create struct
temp = reshape([data(find(mod(Count,16)==5),245:245)'],1,[]);
AllTheTimePowerConsume=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.AllTheTimePowerConsume = AllTheTimePowerConsume; % create struct
temp = reshape([data(find(mod(Count,16)==5),246:246)'],1,[]);
GroundStandby=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.GroundStandby = GroundStandby; % create struct
temp = reshape([data(find(mod(Count,16)==7),243:243)'],1,[]);
TakeOff=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.TakeOff = TakeOff; % create struct
temp = reshape([data(find(mod(Count,16)==7),244:244)'],1,[]);
HoverAdjust=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.HoverAdjust = HoverAdjust; % create struct
temp = reshape([data(find(mod(Count,16)==7),245:245)'],1,[]);
Rotor2fix=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.Rotor2fix = Rotor2fix; % create struct
temp = reshape([data(find(mod(Count,16)==7),246:246)'],1,[]);
HoverUp=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.HoverUp = HoverUp; % create struct
temp = reshape([data(find(mod(Count,16)==8),243:243)'],1,[]);
PathFollow=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.PathFollow = PathFollow; % create struct
temp = reshape([data(find(mod(Count,16)==8),244:244)'],1,[]);
GoHome=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.GoHome = GoHome; % create struct
temp = reshape([data(find(mod(Count,16)==8),245:245)'],1,[]);
HoverDown=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.HoverDown = HoverDown; % create struct
temp = reshape([data(find(mod(Count,16)==8),246:246)'],1,[]);
Fix2Rotor=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.Fix2Rotor = Fix2Rotor; % create struct
temp = reshape([data(find(mod(Count,16)==9),243:243)'],1,[]);
Land=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.PowerConsume.Land = Land; % create struct
% /* |@@SL.OUT_NAVI2FIRM@@+-----------------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,16)==0),245:245)'],1,[]);
isNavFilterGood=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_NAVI2FIRM.isNavFilterGood = isNavFilterGood; % create struct
% /*-----------------------GlobalWindEst      ----------------------------------------------| */	
% /* |@@SL.GlobalWindEst@@------------------------+-------------+------------+--------------| */20200602
temp = reshape([data(find(mod(Count,16)==0),246:246)'],1,[]);
oneCircleComplete=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.GlobalWindEst.oneCircleComplete = oneCircleComplete; % create struct
temp = reshape([data(find(mod(Count,16)==3),245:246)'],1,[]);
windSpeed_ms=double(typecast(uint8(temp),'int16')')/32768*50.0000000000;
SL.GlobalWindEst.windSpeed_ms = windSpeed_ms; % create struct
temp = reshape([data(find(mod(Count,16)==12),245:246)'],1,[]);
windHeading_rad=double(typecast(uint8(temp),'int16')')/32768*6.3000000000;
SL.GlobalWindEst.windHeading_rad = windHeading_rad; % create struct
% /* +===========+================================+=============+============+==============+ */
% /*-----------------------Debug_TaskLogData  ----------------------------------------------| */	
% /* |@@SL.Debug_TaskLogData@@--------------------+-------------+------------+--------------| */20200605
temp = reshape([data(find(mod(Count,4)==2),109:112)'],1,[]);
time_sec=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.Debug_TaskLogData.time_sec = time_sec; % create struct
temp = reshape([data(find(mod(Count,4)==2),113:113)'],1,[]);
blockName=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.Debug_TaskLogData.blockName = blockName; % create struct
temp = reshape([data(find(mod(Count,4)==2),114:114)'],1,[]);
idx=double(typecast(uint8(temp),'int8')')/1*1.0000000000;
SL.Debug_TaskLogData.idx = idx; % create struct
temp = reshape([data(find(mod(Count,4)==2),115:116)'],1,[]);
message=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.Debug_TaskLogData.message = message; % create struct
temp = reshape([data(find(mod(Count,4)==2),117:120)'],1,[]);
var10=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.Debug_TaskLogData.var10 = var10; % create struct
temp = reshape([data(find(mod(Count,4)==2),121:124)'],1,[]);
var11=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.Debug_TaskLogData.var11 = var11; % create struct
temp = reshape([data(find(mod(Count,4)==2),125:128)'],1,[]);
var12=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.Debug_TaskLogData.var12 = var12; % create struct
temp = reshape([data(find(mod(Count,4)==2),129:132)'],1,[]);
var13=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.Debug_TaskLogData.var13 = var13; % create struct
temp = reshape([data(find(mod(Count,4)==2),133:136)'],1,[]);
var14=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.Debug_TaskLogData.var14 = var14; % create struct
% /* |@@SL.OUT_FLIGHTPERF@@+----------------------+-------------+------------+---------------| */
temp = reshape([data(find(mod(Count,8)==5),197:197)'],1,[]);
isAbleToCompleteTask=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_FLIGHTPERF.isAbleToCompleteTask = isAbleToCompleteTask; % create struct
temp = reshape([data(find(mod(Count,8)==5),198:198)'],1,[]);
flagGoHomeNow=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.OUT_FLIGHTPERF.flagGoHomeNow = flagGoHomeNow; % create struct
temp = reshape([data(find(mod(Count,8)==5),199:200)'],1,[]);
remainDistToGo_m=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_FLIGHTPERF.remainDistToGo_m = remainDistToGo_m; % create struct
temp = reshape([data(find(mod(Count,8)==5),201:202)'],1,[]);
remainTimeToSpend_sec=double(typecast(uint8(temp),'int16')')/32768*7200.0000000000;
SL.OUT_FLIGHTPERF.remainTimeToSpend_sec = remainTimeToSpend_sec; % create struct
temp = reshape([data(find(mod(Count,8)==5),203:204)'],1,[]);
remainPowerWhenFinish_per=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
SL.OUT_FLIGHTPERF.remainPowerWhenFinish_per = remainPowerWhenFinish_per; % create struct
temp = reshape([data(find(mod(Count,8)==5),205:206)'],1,[]);
economicAirspeed=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
SL.OUT_FLIGHTPERF.economicAirspeed = economicAirspeed; % create struct
temp = reshape([data(find(mod(Count,8)==0),293:294)'],1,[]);
remainPathPoint=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_FLIGHTPERF.remainPathPoint = remainPathPoint; % create struct
temp = reshape([data(find(mod(Count,8)==1),293:294)'],1,[]);
batteryLifeToCompleteTask=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_FLIGHTPERF.batteryLifeToCompleteTask = batteryLifeToCompleteTask; % create struct
temp = reshape([data(find(mod(Count,8)==2),293:294)'],1,[]);
batterylifeNeededToHome=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.OUT_FLIGHTPERF.batterylifeNeededToHome = batterylifeNeededToHome; % create struct
% /* +===========+================================+=============+============+===============+ */
% /*-----------------------RefModel_SystemArchitecture_U.IN_MAVLINK.------------------------- */
% /* |@@SL.mavlink_mission_item_def@@+------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,8)==3),197:198)'],1,[]);
seq=double(typecast(uint8(temp),'uint16')')/1*1.0000000000;
SL.mavlink_mission_item_def.seq = seq; % create struct
temp = reshape([data(find(mod(Count,8)==3),199:202)'],1,[]);
x=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.mavlink_mission_item_def.x = x; % create struct
temp = reshape([data(find(mod(Count,8)==3),203:206)'],1,[]);
y=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.mavlink_mission_item_def.y = y; % create struct
temp = reshape([data(find(mod(Count,8)==3),207:208)'],1,[]);
z=double(typecast(uint8(temp),'int16')')/32768*5000.0000000000;
SL.mavlink_mission_item_def.z = z; % create struct
% /* |@@SL.TEST482@@+------------+-------------+------------+--------------| */
temp = reshape([data(find(mod(Count,4)==0),239:242)'],1,[]);
Lon=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.TEST482.Lon = Lon; % create struct
temp = reshape([data(find(mod(Count,4)==0),257:260)'],1,[]);
Lat=double(typecast(uint8(temp),'int32')')/10000000*1.0000000000;
SL.TEST482.Lat = Lat; % create struct
temp = reshape([data(find(mod(Count,4)==0),261:264)'],1,[]);
height=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.height = height; % create struct
temp = reshape([data(find(mod(Count,4)==0),265:268)'],1,[]);
velN=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.velN = velN; % create struct
temp = reshape([data(find(mod(Count,4)==0),269:272)'],1,[]);
velE=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.velE = velE; % create struct
temp = reshape([data(find(mod(Count,4)==0),273:276)'],1,[]);
velD=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.velD = velD; % create struct
temp = reshape([data(find(mod(Count,4)==0),277:280)'],1,[]);
delta_lon=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.delta_lon = delta_lon; % create struct
temp = reshape([data(find(mod(Count,4)==0),281:284)'],1,[]);
delta_lat=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.delta_lat = delta_lat; % create struct
temp = reshape([data(find(mod(Count,4)==0),285:288)'],1,[]);
delta_height=double(typecast(uint8(temp),'single')')/1*1.0000000000;
SL.TEST482.delta_height = delta_height; % create struct
temp = reshape([data(find(mod(Count,4)==0),237:238)'],1,[]);
pDop=double(typecast(uint8(temp),'int16')')/32768*100.0000000000;
SL.TEST482.pDop = pDop; % create struct
temp = reshape([data(find(mod(Count,4)==0),39:39)'],1,[]);
BESTPOS=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.TEST482.BESTPOS = BESTPOS; % create struct
temp = reshape([data(find(mod(Count,4)==0),40:40)'],1,[]);
numSv=double(typecast(uint8(temp),'uint8')')/1*1.0000000000;
SL.TEST482.numSv = numSv; % create struct
