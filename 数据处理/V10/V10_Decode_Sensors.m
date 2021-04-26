function IN_SENSOR = V10_Decode_Sensors(V10Log)
timeScale = 1e4;
%% 传感器数据构造
IN_SENSOR.time = V10Log.IMU1.TimeUS/timeScale;
%% IMU1
try
    childName = 'IMU1';
    IN_SENSOR.(childName).time = V10Log.(childName).TimeUS/timeScale;
    IN_SENSOR.(childName).accel_x = V10Log.(childName).ax;
    IN_SENSOR.(childName).accel_y = V10Log.(childName).ay;
    IN_SENSOR.(childName).accel_z = V10Log.(childName).az;
    IN_SENSOR.(childName).gyro_x = V10Log.(childName).gx;
    IN_SENSOR.(childName).gyro_y = V10Log.(childName).gy;
    IN_SENSOR.(childName).gyro_z = V10Log.(childName).gz;
    IN_SENSOR.(childName).nChange = zeros(size(IN_SENSOR.(childName).accel_x));
    if sum(IN_SENSOR.(childName).nChange) == 0
        fprintf('[%s] nChange 没有正常赋值\n',childName);
    end
catch
    try
        V10Log.(childName)
    catch
        fprintf('当前协议中没有 %s 的解析信息\n',childName)
    end
end
%% IMU2
try
    childName = 'IMU2';
    IN_SENSOR.(childName).time = V10Log.(childName).TimeUS/timeScale;
    IN_SENSOR.(childName).accel_x = V10Log.(childName).ax;
    IN_SENSOR.(childName).accel_y = V10Log.(childName).ay;
    IN_SENSOR.(childName).accel_z = V10Log.(childName).az;
    IN_SENSOR.(childName).gyro_x = V10Log.(childName).gx;
    IN_SENSOR.(childName).gyro_y = V10Log.(childName).gy;
    IN_SENSOR.(childName).gyro_z = V10Log.(childName).gz;
    IN_SENSOR.(childName).nChange = zeros(size(IN_SENSOR.(childName).accel_x));
    if sum(IN_SENSOR.(childName).nChange) == 0
        fprintf('[%s] nChange 没有正常赋值\n',childName);
    end
catch
    try
        V10Log.(childName)
    catch
        fprintf('当前协议中没有 %s 的解析信息\n',childName)
    end
end
%% IMU3
try
    childName = 'IMU3';
    IN_SENSOR.(childName).time = V10Log.(childName).TimeUS/timeScale;
    IN_SENSOR.(childName).accel_x = V10Log.(childName).ax;
    IN_SENSOR.(childName).accel_y = V10Log.(childName).ay;
    IN_SENSOR.(childName).accel_z = V10Log.(childName).az;
    IN_SENSOR.(childName).gyro_x = V10Log.(childName).gx;
    IN_SENSOR.(childName).gyro_y = V10Log.(childName).gy;
    IN_SENSOR.(childName).gyro_z = V10Log.(childName).gz;
    IN_SENSOR.(childName).nChange = zeros(size(IN_SENSOR.(childName).accel_x));
    if sum(IN_SENSOR.(childName).nChange) == 0
        fprintf('[%s] nChange 没有正常赋值\n',childName);
    end
catch
    try
        V10Log.(childName)
    catch
        fprintf('当前协议中没有 %s 的解析信息\n',childName)
    end
end
%% IMU4
try
    childName = 'IMU4';
    IN_SENSOR.(childName).time = V10Log.(childName).TimeUS/timeScale;
    IN_SENSOR.(childName).accel_x = V10Log.(childName).ax;
    IN_SENSOR.(childName).accel_y = V10Log.(childName).ay;
    IN_SENSOR.(childName).accel_z = V10Log.(childName).az;
    IN_SENSOR.(childName).gyro_x = V10Log.(childName).gx;
    IN_SENSOR.(childName).gyro_y = V10Log.(childName).gy;
    IN_SENSOR.(childName).gyro_z = V10Log.(childName).gz;
    IN_SENSOR.(childName).nChange = zeros(size(IN_SENSOR.(childName).accel_x));
    if sum(IN_SENSOR.(childName).nChange) == 0
        fprintf('[%s] nChange 没有正常赋值\n',childName);
    end
catch
    try
        V10Log.(childName)
    catch
        fprintf('当前协议中没有 %s 的解析信息\n',childName)
    end
end
%% Baro1
IN_SENSOR.baro1.time = V10Log.BAR1.TimeUS/timeScale;
IN_SENSOR.baro1.alt_baro = V10Log.BAR1.altitude;
IN_SENSOR.baro1.nChange = zeros(size(IN_SENSOR.baro1.alt_baro));
if sum(IN_SENSOR.baro1.nChange) == 0
    disp('[baro1] nChange 没有正常赋值');
end
%% Baro2
IN_SENSOR.baro2.time = V10Log.BAR2.TimeUS/timeScale;
IN_SENSOR.baro2.alt_baro = 0*V10Log.BAR2.altitude;
IN_SENSOR.baro2.nChange = zeros(size(IN_SENSOR.baro2.alt_baro));
if sum(IN_SENSOR.baro2.nChange) == 0
    disp('[baro2] nChange 没有正常赋值');
end
%% Mag1
IN_SENSOR.mag1.time = V10Log.MAG1.TimeUS/timeScale;
IN_SENSOR.mag1.mag_x = V10Log.MAG1.cali_data_x;
IN_SENSOR.mag1.mag_y = V10Log.MAG1.cali_data_y;
IN_SENSOR.mag1.mag_z = V10Log.MAG1.cali_data_z;
IN_SENSOR.mag1.nChange = zeros(size(IN_SENSOR.mag1.mag_x));
if sum(IN_SENSOR.mag1.nChange) == 0
    disp('[mag1] nChange 没有正常赋值');
end
%% Mag2
if hasThisChild(V10Log,'MAG2')
    IN_SENSOR.mag2.time = V10Log.MAG2.TimeUS/timeScale;
    IN_SENSOR.mag2.mag_x = V10Log.MAG2.cali_data_x;
    IN_SENSOR.mag2.mag_y = V10Log.MAG2.cali_data_y;
    IN_SENSOR.mag2.mag_z = V10Log.MAG2.cali_data_z;
    IN_SENSOR.mag2.nChange = zeros(size(IN_SENSOR.mag2.mag_x));
else
    IN_SENSOR.mag2 = IN_SENSOR.mag1;
end
if sum(IN_SENSOR.mag2.nChange) == 0
    disp('[mag2] nChange 没有正常赋值');
end
%% Radar
IN_SENSOR.radar1.time = V10Log.NRA.TimeUS/timeScale;
IN_SENSOR.radar1.SNR = V10Log.NRA.SNR;
IN_SENSOR.radar1.Flag = V10Log.NRA.Flag;
IN_SENSOR.radar1.Range = V10Log.NRA.Range;
IN_SENSOR.radar1.nChange = zeros(size(V10Log.NRA.TimeUS));
if sum(IN_SENSOR.radar1.nChange) == 0
    disp('[radar1] nChange 没有正常赋值');
end
%% ublox1
IN_SENSOR.ublox1.time = V10Log.UBX.TimeUS/timeScale;
IN_SENSOR.ublox1.velE = V10Log.UBX.velE;
IN_SENSOR.ublox1.velN = V10Log.UBX.velN;
IN_SENSOR.ublox1.velD = V10Log.UBX.velD;
IN_SENSOR.ublox1.Lon = V10Log.UBX.lon;
IN_SENSOR.ublox1.Lat = V10Log.UBX.lat;
IN_SENSOR.ublox1.height = V10Log.UBX.height;
IN_SENSOR.ublox1.pDop = V10Log.UBX.pDOP;
IN_SENSOR.ublox1.numSv = V10Log.UBX.numSV;
IN_SENSOR.ublox1.hAcc = V10Log.UBX.hAcc;
IN_SENSOR.ublox1.vAcc = V10Log.UBX.vAcc;
IN_SENSOR.ublox1.headAcc = V10Log.UBX.headAcc;
IN_SENSOR.ublox1.sAcc = V10Log.UBX.sAcc;
IN_SENSOR.ublox1.nChange = zeros(size(IN_SENSOR.ublox1.time));
if sum(IN_SENSOR.ublox1.nChange) == 0
    disp('[ublox1] nChange 没有正常赋值');
end
% IN_SENSOR.ublox1.headAcc = V10Log.UBX.headAcc;
% IN_SENSOR.ublox1.sAcc = V10Log.UBX.sAcc;
%% um482
IN_SENSOR.um482.time = V10Log.GPS.TimeUS/timeScale;
IN_SENSOR.um482.Lon = V10Log.GPS.lon;
IN_SENSOR.um482.Lat = V10Log.GPS.lat;
IN_SENSOR.um482.height = V10Log.GPS.height;
IN_SENSOR.um482.velN = V10Log.GPS.velN;
IN_SENSOR.um482.velE = V10Log.GPS.velE;
IN_SENSOR.um482.velD = V10Log.GPS.velD;
IN_SENSOR.um482.delta_lon = V10Log.GPS.lon_deviation;
IN_SENSOR.um482.delta_lat = V10Log.GPS.lat_deviation;
IN_SENSOR.um482.delta_height = V10Log.GPS.height_deviation;
IN_SENSOR.um482.pDop = V10Log.GPS.pDOP;
IN_SENSOR.um482.BESTPOS = V10Log.GPS.pos_type;
IN_SENSOR.um482.numSv = V10Log.GPS.svn;
IN_SENSOR.um482.nChange = zeros(size(IN_SENSOR.um482.time));
if sum(IN_SENSOR.um482.nChange) == 0
    disp('[um482] nChange 没有正常赋值');
end
%% airspeed1
IN_SENSOR.airspeed1.time = V10Log.ARP1.TimeUS/timeScale;
IN_SENSOR.airspeed1.airspeed = V10Log.ARP1.indicated_airspeed;
IN_SENSOR.airspeed1.airspeed_indicate = V10Log.ARP1.indicated_airspeed;
IN_SENSOR.airspeed1.airspeed_true = V10Log.ARP1.true_airspeed;
IN_SENSOR.airspeed1.airspeed_calibrate = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.temperature = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.static_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.dynamic_pressure = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.status = 0*IN_SENSOR.airspeed1.airspeed;
IN_SENSOR.airspeed1.EAS2TAS_Algo = zeros(size(IN_SENSOR.airspeed1.time));
IN_SENSOR.airspeed1.nChange = zeros(size(IN_SENSOR.airspeed1.time));
disp('airspeed1没有解析：EAS2TAS_Algo')
if sum(IN_SENSOR.airspeed1.nChange) == 0
    disp('[airspeed1] nChange 没有正常赋值');
end
%% airspeed2
if hasThisChild(V10Log,'ARP2')
    IN_SENSOR.airspeed2.time = V10Log.ARP2.TimeUS/timeScale;
    IN_SENSOR.airspeed2.airspeed = V10Log.ARP2.indicated_airspeed;
    IN_SENSOR.airspeed2.airspeed_indicate = V10Log.ARP2.indicated_airspeed;
    IN_SENSOR.airspeed2.airspeed_true = V10Log.ARP2.true_airspeed;
    IN_SENSOR.airspeed2.airspeed_calibrate = 0*IN_SENSOR.airspeed2.airspeed;
    IN_SENSOR.airspeed2.temperature = 0*IN_SENSOR.airspeed2.airspeed;
    IN_SENSOR.airspeed2.static_pressure = 0*IN_SENSOR.airspeed2.airspeed;
    IN_SENSOR.airspeed2.dynamic_pressure = 0*IN_SENSOR.airspeed2.airspeed;
    IN_SENSOR.airspeed2.status = 0*IN_SENSOR.airspeed2.airspeed;
    IN_SENSOR.airspeed2.EAS2TAS_Algo = zeros(size(IN_SENSOR.airspeed2.time));
    IN_SENSOR.airspeed2.nChange = zeros(size(IN_SENSOR.airspeed2.time));
else
    IN_SENSOR.airspeed2 = IN_SENSOR.airspeed1;
end

disp('airspeed2 没有解析：EAS2TAS_Algo')
if sum(IN_SENSOR.airspeed2.nChange) == 0
    disp('[airspeed2] nChange 没有正常赋值');
end
%% airspeed3
IN_SENSOR.airspeed3 = IN_SENSOR.airspeed2;
disp('[airspeed3] 结构体没有解析')
% IN_SENSOR.airspeed3.time = V10Log.ARP3.TimeUS;
% IN_SENSOR.airspeed3.airspeed = V10Log.ARP3.indicated_airspeed;
% IN_SENSOR.airspeed3.airspeed_indicate = V10Log.ARP3.indicated_airspeed;
% IN_SENSOR.airspeed3.airspeed_true = V10Log.ARP3.true_airspeed;
% IN_SENSOR.airspeed3.airspeed_calibrate = 0*IN_SENSOR.airspeed3.airspeed;
% IN_SENSOR.airspeed3.temperature = 0*IN_SENSOR.airspeed3.airspeed;
% IN_SENSOR.airspeed3.static_pressure = 0*IN_SENSOR.airspeed3.airspeed;
% IN_SENSOR.airspeed3.dynamic_pressure = 0*IN_SENSOR.airspeed3.airspeed;
% IN_SENSOR.airspeed3.status = 0*IN_SENSOR.airspeed3.airspeed;
% IN_SENSOR.airspeed3.EAS2TAS_Algo = zeros(size(IN_SENSOR.airspeed3.time));
% IN_SENSOR.airspeed3.nChange = zeros(size(IN_SENSOR.airspeed3.time));
% disp('airspeed3 没有解析：EAS2TAS_Algo')
% if sum(IN_SENSOR.airspeed3.nChange) == 0
%     disp('airspeed3 的 nChange 没有正常赋值');
% end
%% laserDown1
disp('[laserDown1] 结构体未解析')
IN_SENSOR.laserDown1.time = V10Log.LASE.TimeUS/timeScale;
IN_SENSOR.laserDown1.range = V10Log.LASE.laser1_distance;
IN_SENSOR.laserDown1.flag = V10Log.LASE.laser1_valid;
IN_SENSOR.laserDown1.strength = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.laserDown1.nChange = zeros(size(IN_SENSOR.laserDown1.time));
if sum(IN_SENSOR.laserDown1.nChange) == 0
    disp('[laserDown1] nChange 没有正常赋值');
end
%% laserDown2
disp('[laserDown2] 结构体未解析')
IN_SENSOR.laserDown2.time = V10Log.LASE.TimeUS/timeScale;
IN_SENSOR.laserDown2.range = V10Log.LASE.laser2_distance;
IN_SENSOR.laserDown2.flag = V10Log.LASE.laser2_valid;
IN_SENSOR.laserDown2.strength = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.laserDown2.nChange = zeros(size(IN_SENSOR.laserDown2.time));
if sum(IN_SENSOR.laserDown2.nChange) == 0
    disp('[laserDown2] nChange 没有正常赋值');
end
%% radarLongForward1
disp('[radarLongForward1] 结构体未解析')
IN_SENSOR.radarLongForward1.time = IN_SENSOR.radar1.time;
IN_SENSOR.radarLongForward1.range = -1*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongForward1.flag = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongForward1.strength = 0*ones(size(IN_SENSOR.radar1.Range));

IN_SENSOR.radarLongForward1.nChange = zeros(size(IN_SENSOR.radarLongForward1.time));
%% radarLongDown1
disp('[radarLongForward2] 结构体未解析')
IN_SENSOR.radarLongDown1.time = IN_SENSOR.radar1.time;
IN_SENSOR.radarLongDown1.range = -1*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongDown1.flag = 0*ones(size(IN_SENSOR.radar1.Range));
IN_SENSOR.radarLongDown1.strength = 0*ones(size(IN_SENSOR.radar1.Range));

IN_SENSOR.radarLongDown1.nChange = zeros(size(IN_SENSOR.radarLongDown1.time));
%% IMU1_Control
IN_SENSOR.IMU1_Control = IN_SENSOR.IMU1;
IN_SENSOR.IMU1_0 = IN_SENSOR.IMU1;
%% 子函数 ---------------------------------------------------------------------
function flag = hasThisChild(structdata,childname)
children = fieldnames(structdata);
temp = contains(children,childname);
if any(temp)
    flag = true;
else
    flag = false;
end