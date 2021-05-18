function V10Log = V10_decode_auto(logFile)
% This .m file is generated automatically by generateDecodeFile.m
% example: V10Log = V10_decode_auto('10ÿÿÿÿÿÿ 2021-05-18 17-24-31.mat')
% computer name: DESKTOP-QLU0EFU
% generate date: 18-May-2021
% Matlab version: 9.9.0.1467703 (R2020b)
% protocol file: V10_v20210518_10.txt
% data file: 10ÿÿÿÿÿÿ 2021-05-18 17-24-31.mat
% logFile: .mat log file
load(logFile);
%% ARP1
try
V10Log.ARP1.TimeUS = ARP1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.ARP1.air_temp = ARP1(:,3);                                %   2. | tmp1     | air_temp                       | [F]   | [10:10]    | 
V10Log.ARP1.air_diff_press_pa_raw = ARP1(:,4);                   %   3. | prs1     | air_diff_press_pa_raw          | [F]   | [10:10]    | 
V10Log.ARP1.indicated_airspeed = ARP1(:,5);                      %   4. | isp1     | indicated_airspeed             | [F]   | [10:10]    | 
V10Log.ARP1.true_airspeed = ARP1(:,6);                           %   5. | tsp1     | true_airspeed                  | [F]   | [10:10]    | 
V10Log.ARP1.EAS_Algo = ARP1(:,7);                                %   6. | EAS      | EAS_Algo                       | [F]   | [10:10]    | 
V10Log.ARP1.EAS2TAS_Algo = ARP1(:,8);                            %   7. | EAS2     | EAS2TAS_Algo                   | [F]   | [10:10]    | 
V10Log.ARP1.I2C_AirRetryCount_0(:,1) = ARP1(:,9);                %   8. | err1     | I2C_AirRetryCount[0][0]        | [U8]  | [10:10]    | 
V10Log.ARP1.I2C_AirRetryCount_0(:,2) = ARP1(:,10);               %   9. | err2     | I2C_AirRetryCount[0][1]        | [U8]  | [10:10]    | 
V10Log.ARP1.Sum = ARP1(:,11);                                    %  10. | Sum      | Sum                            | [U8]  | [10:10]    | 
catch ME
	disp(ME.message);
end
%% ARP2
try
V10Log.ARP2.TimeUS = ARP2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.ARP2.air_temp = ARP2(:,3);                                %   2. | tmp2     | air_temp                       | [F]   | [10:10]    | 
V10Log.ARP2.air_diff_press_pa_raw = ARP2(:,4);                   %   3. | prs2     | air_diff_press_pa_raw          | [F]   | [10:10]    | 
V10Log.ARP2.indicated_airspeed = ARP2(:,5);                      %   4. | isp2     | indicated_airspeed             | [F]   | [10:10]    | 
V10Log.ARP2.true_airspeed = ARP2(:,6);                           %   5. | tsp2     | true_airspeed                  | [F]   | [10:10]    | 
V10Log.ARP2.EAS_Algo = ARP2(:,7);                                %   6. | EAS      | EAS_Algo                       | [F]   | [10:10]    | 
V10Log.ARP2.EAS2TAS_Algo = ARP2(:,8);                            %   7. | EAS2     | EAS2TAS_Algo                   | [F]   | [10:10]    | 
V10Log.ARP2.I2C_AirRetryCount_1(:,1) = ARP2(:,9);                %   8. | err1     | I2C_AirRetryCount[1][0]        | [U8]  | [10:10]    | 
V10Log.ARP2.I2C_AirRetryCount_1(:,2) = ARP2(:,10);               %   9. | err2     | I2C_AirRetryCount[1][1]        | [U8]  | [10:10]    | 
V10Log.ARP2.Sum = ARP2(:,11);                                    %  10. | Sum      | Sum                            | [U8]  | [10:10]    | 
catch ME
	disp(ME.message);
end
%% MAG1
try
V10Log.MAG1.TimeUS = MAG1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.MAG1.true_data_x = MAG1(:,3);                             %   2. | Lx_t     | true_data_x                    | [F]   | [10:10]    | 
V10Log.MAG1.true_data_y = MAG1(:,4);                             %   3. | Ly_t     | true_data_y                    | [F]   | [10:10]    | 
V10Log.MAG1.true_data_z = MAG1(:,5);                             %   4. | Lz_t     | true_data_z                    | [F]   | [10:10]    | 
V10Log.MAG1.cali_data_x = MAG1(:,6);                             %   5. | Lx_c     | cali_data_x                    | [F]   | [10:10]    | 
V10Log.MAG1.cali_data_y = MAG1(:,7);                             %   6. | Ly_c     | cali_data_y                    | [F]   | [10:10]    | 
V10Log.MAG1.cali_data_z = MAG1(:,8);                             %   7. | Lz_c     | cali_data_z                    | [F]   | [10:10]    | 
V10Log.MAG1.I2C_MagRetryCount_0(:,1) = MAG1(:,9);                %   8. | err1     | I2C_MagRetryCount[0][0]        | [U8]  | [10:10]    | 
V10Log.MAG1.I2C_MagRetryCount_0(:,2) = MAG1(:,10);               %   9. | err2     | I2C_MagRetryCount[0][1]        | [U8]  | [10:10]    | 
V10Log.MAG1.Sum = MAG1(:,11);                                    %  10. | Sum      | Sum                            | [U8]  | [10:10]    | 
catch ME
	disp(ME.message);
end
%% MAG2
try
V10Log.MAG2.TimeUS = MAG2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.MAG2.true_data_x = MAG2(:,3);                             %   2. | Rx_t     | true_data_x                    | [F]   | [10:10]    | 
V10Log.MAG2.true_data_y = MAG2(:,4);                             %   3. | Ry_t     | true_data_y                    | [F]   | [10:10]    | 
V10Log.MAG2.true_data_z = MAG2(:,5);                             %   4. | Rz_t     | true_data_z                    | [F]   | [10:10]    | 
V10Log.MAG2.cali_data_x = MAG2(:,6);                             %   5. | Rx_c     | cali_data_x                    | [F]   | [10:10]    | 
V10Log.MAG2.cali_data_y = MAG2(:,7);                             %   6. | Ry_c     | cali_data_y                    | [F]   | [10:10]    | 
V10Log.MAG2.cali_data_z = MAG2(:,8);                             %   7. | Rz_c     | cali_data_z                    | [F]   | [10:10]    | 
V10Log.MAG2.I2C_MagRetryCount_1(:,1) = MAG2(:,9);                %   8. | err1     | I2C_MagRetryCount[1][0]        | [U8]  | [10:10]    | 
V10Log.MAG2.I2C_MagRetryCount_1(:,2) = MAG2(:,10);               %   9. | err2     | I2C_MagRetryCount[1][1]        | [U8]  | [10:10]    | 
V10Log.MAG2.Sum = MAG2(:,11);                                    %  10. | Sum      | Sum                            | [U8]  | [10:10]    | 
catch ME
	disp(ME.message);
end
%% BAR1
try
V10Log.BAR1.TimeUS = BAR1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.BAR1.ground_pressure = BAR1(:,3);                         %   2. | gP       | ground_pressure                | [F]   | [10:10]    | 
V10Log.BAR1.ground_temperature = BAR1(:,4);                      %   3. | gT       | ground_temperature             | [F]   | [10:10]    | 
V10Log.BAR1.pressure = BAR1(:,5);                                %   4. | pres     | pressure                       | [F]   | [10:10]    | 
V10Log.BAR1.altitude = BAR1(:,6);                                %   5. | alt      | altitude                       | [F]   | [10:10]    | 
V10Log.BAR1.temperature = BAR1(:,7);                             %   6. | temp     | temperature                    | [F]   | [10:10]    | 
V10Log.BAR1.Sum = BAR1(:,9);                                     %   7. | Sum      | Sum                            | [U8]  | [10:10]    | 
catch ME
	disp(ME.message);
end
%% BAR2
try
V10Log.BAR2.TimeUS = BAR2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.BAR2.ground_pressure = BAR2(:,3);                         %   2. | gP       | ground_pressure                | [F]   | [10:10]    | 
V10Log.BAR2.ground_temperature = BAR2(:,4);                      %   3. | gT       | ground_temperature             | [F]   | [10:10]    | 
V10Log.BAR2.pressure = BAR2(:,5);                                %   4. | pres     | pressure                       | [F]   | [10:10]    | 
V10Log.BAR2.altitude = BAR2(:,6);                                %   5. | alt      | altitude                       | [F]   | [10:10]    | 
V10Log.BAR2.temperature = BAR2(:,7);                             %   6. | temp     | temperature                    | [F]   | [10:10]    | 
V10Log.BAR2.Sum = BAR2(:,9);                                     %   7. | Sum      | Sum                            | [U8]  | [10:10]    | 
catch ME
	disp(ME.message);
end
%% IMU1
try
V10Log.IMU1.TimeUS = IMU1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMU1.ax = IMU1(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMU1.ay = IMU1(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMU1.az = IMU1(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMU1.gx = IMU1(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMU1.gy = IMU1(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMU1.gz = IMU1(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMU1.temperature = IMU1(:,9);                             %   8. | temp     | temperature                    | [F]   | [1:4]      | 
V10Log.IMU1.temp_pwm = IMU1(:,10);                               %   9. | IO_0     | temp_pwm                       | [F]   | [1:4]      | 
V10Log.IMU1.Sum = IMU1(:,11);                                    %  10. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% IMU2
try
V10Log.IMU2.TimeUS = IMU2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMU2.ax = IMU2(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMU2.ay = IMU2(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMU2.az = IMU2(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMU2.gx = IMU2(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMU2.gy = IMU2(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMU2.gz = IMU2(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMU2.temperature = IMU2(:,9);                             %   8. | temp     | temperature                    | [F]   | [1:4]      | 
V10Log.IMU2.temp_pwm = IMU2(:,10);                               %   9. | IO_0     | temp_pwm                       | [F]   | [1:4]      | 
V10Log.IMU2.Sum = IMU2(:,11);                                    %  10. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% IMF1
try
V10Log.IMF1.TimeUS = IMF1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF1.ax = IMF1(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF1.ay = IMF1(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF1.az = IMF1(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF1.gx = IMF1(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF1.gy = IMF1(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF1.gz = IMF1(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF1.Sum = IMF1(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% IMF5
try
V10Log.IMF5.TimeUS = IMF5(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF5.ax = IMF5(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF5.ay = IMF5(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF5.az = IMF5(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF5.gx = IMF5(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF5.gy = IMF5(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF5.gz = IMF5(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF5.Sum = IMF5(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% IMF6
try
V10Log.IMF6.TimeUS = IMF6(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF6.ax = IMF6(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF6.ay = IMF6(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF6.az = IMF6(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF6.gx = IMF6(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF6.gy = IMF6(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF6.gz = IMF6(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF6.Sum = IMF6(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% IMF7
try
V10Log.IMF7.TimeUS = IMF7(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF7.ax = IMF7(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF7.ay = IMF7(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF7.az = IMF7(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF7.gx = IMF7(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF7.gy = IMF7(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF7.gz = IMF7(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF7.Sum = IMF7(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% IMF8
try
V10Log.IMF8.TimeUS = IMF8(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF8.ax = IMF8(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF8.ay = IMF8(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF8.az = IMF8(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF8.gx = IMF8(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF8.gy = IMF8(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF8.gz = IMF8(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF8.Sum = IMF8(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
catch ME
	disp(ME.message);
end
%% GPS
try
V10Log.GPS.TimeUS = GPS(:,2);                                    %   1. | TimeUS   | TimeUS                         | [U32] | [50:50]    | 
V10Log.GPS.lat = GPS(:,3);                                       %   2. | lat      | lat                            | [D]   | [50:50]    | 57.2957795f
V10Log.GPS.lon = GPS(:,4);                                       %   3. | lon      | lon                            | [D]   | [50:50]    | 57.2957795f
V10Log.GPS.height = GPS(:,5);                                    %   4. | hgt      | height                         | [F]   | [50:50]    | 
V10Log.GPS.velN = GPS(:,6);                                      %   5. | vN       | velN                           | [F]   | [50:50]    | 
V10Log.GPS.velE = GPS(:,7);                                      %   6. | vE       | velE                           | [F]   | [50:50]    | 
V10Log.GPS.velD = GPS(:,8);                                      %   7. | vD       | velD                           | [F]   | [50:50]    | 
V10Log.GPS.pDOP = GPS(:,9);                                      %   8. | pDp      | pDOP                           | [F]   | [50:50]    | 
V10Log.GPS.hDOP = GPS(:,10);                                     %   9. | hDp      | hDOP                           | [F]   | [50:50]    | 
V10Log.GPS.lat_deviation = GPS(:,11);                            %  10. | lad      | lat_deviation                  | [F]   | [50:50]    | 
V10Log.GPS.lon_deviation = GPS(:,12);                            %  11. | lod      | lon_deviation                  | [F]   | [50:50]    | 
V10Log.GPS.height_deviation = GPS(:,13);                         %  12. | hd       | height_deviation               | [F]   | [50:50]    | 
V10Log.GPS.svn = GPS(:,14);                                      %  13. | svn      | svn                            | [U8]  | [50:50]    | satellitetracking
V10Log.GPS.solnSVs = GPS(:,15);                                  %  14. | solV     | solnSVs                        | [U8]  | [50:50]    | satelliteusing
V10Log.GPS.pos_type = GPS(:,16);                                 %  15. | post     | pos_type                       | [U8]  | [50:50]    | BEST_POS
V10Log.GPS.Sum = GPS(:,17);                                      %  16. | Sum      | Sum                            | [U8]  | [50:50]    | 
catch ME
	disp(ME.message);
end
%% GPSE
try
V10Log.GPSE.TimeUS = GPSE(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [50:50]    | 
V10Log.GPSE.decode_error_cnt = GPSE(:,3);                        %   2. | er1      | decode_error_cnt               | [U8]  | [50:50]    | 
V10Log.GPSE.decode_crc_error_cnt = GPSE(:,4);                    %   3. | er2      | decode_crc_error_cnt           | [U8]  | [50:50]    | 
V10Log.GPSE.decode_psrdop_cnt = GPSE(:,5);                       %   4. | er3      | decode_psrdop_cnt              | [U8]  | [50:50]    | 
V10Log.GPSE.oem718d_decode_status = GPSE(:,6);                   %   5. | er4      | oem718d_decode_status          | [U8]  | [50:50]    | 
V10Log.GPSE.decode_bestpos_cnt = GPSE(:,7);                      %   6. | er5      | decode_bestpos_cnt             | [U8]  | [50:50]    | 
V10Log.GPSE.decode_bestvel_cnt = GPSE(:,8);                      %   7. | er6      | decode_bestvel_cnt             | [U8]  | [50:50]    | 
V10Log.GPSE.decode_heading_cnt = GPSE(:,9);                      %   8. | er7      | decode_heading_cnt             | [U8]  | [50:50]    | 
V10Log.GPSE.rev1 = GPSE(:,10);                                   %   9. | er8      | rev1                           | [U32] | [50:50]    | 
V10Log.GPSE.rev2 = GPSE(:,11);                                   %  10. | er9      | rev2                           | [U32] | [50:50]    | 
V10Log.GPSE.gps_week = GPSE(:,13);                               %  11. | week     | gps_week                       | [U16] | [50:50]    | 
V10Log.GPSE.gps_time_ms = GPSE(:,14);                            %  12. | ms       | gps_time_ms                    | [U32] | [50:50]    | 
V10Log.GPSE.sol_status = GPSE(:,15);                             %  13. | stat     | sol_status                     | [U16] | [50:50]    | 
V10Log.GPSE.Sum = GPSE(:,16);                                    %  14. | Sum      | Sum                            | [U8]  | [50:50]    | 
catch ME
	disp(ME.message);
end
%% UBX
try
V10Log.UBX.TimeUS = UBX(:,1);                                    %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.UBX.lat = UBX(:,3);                                       %   2. | lat      | lat                            | [D]   | [100:100]  | le-7
V10Log.UBX.lon = UBX(:,4);                                       %   3. | lon      | lon                            | [D]   | [100:100]  | le-7
V10Log.UBX.height = UBX(:,5);                                    %   4. | hgt      | height                         | [F]   | [100:100]  | le-3
V10Log.UBX.velN = UBX(:,6);                                      %   5. | vN       | velN                           | [F]   | [100:100]  | le-3
V10Log.UBX.velE = UBX(:,7);                                      %   6. | vE       | velE                           | [F]   | [100:100]  | le-3
V10Log.UBX.velD = UBX(:,8);                                      %   7. | vD       | velD                           | [F]   | [100:100]  | le-3
V10Log.UBX.hAcc = UBX(:,9);                                      %   8. | hAc      | hAcc                           | [F]   | [100:100]  | le-3
V10Log.UBX.vAcc = UBX(:,10);                                     %   9. | vAc      | vAcc                           | [F]   | [100:100]  | le-3
V10Log.UBX.sAcc = UBX(:,11);                                     %  10. | sAc      | sAcc                           | [F]   | [100:100]  | le-3
V10Log.UBX.headAcc = UBX(:,12);                                  %  11. | hdAc     | headAcc                        | [F]   | [100:100]  | le-5
V10Log.UBX.pDOP = UBX(:,13);                                     %  12. | pDOP     | pDOP                           | [F]   | [100:100]  | le-2
V10Log.UBX.numSV = UBX(:,14);                                    %  13. | nSV      | numSV                          | [U8]  | [100:100]  | 
V10Log.UBX.Sum = UBX(:,17);                                      %  14. | Sum      | Sum                            | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% UBXE
try
V10Log.UBXE.TimeUS = UBXE(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.UBXE.decode_error_cnt = UBXE(:,3);                        %   2. | err1     | decode_error_cnt               | [U8]  | [100:100]  | 
V10Log.UBXE.decode_crc_error_cnt = UBXE(:,4);                    %   3. | err2     | decode_crc_error_cnt           | [U8]  | [100:100]  | 
V10Log.UBXE.decode_psrdop_cnt = UBXE(:,5);                       %   4. | err3     | decode_psrdop_cnt              | [U8]  | [100:100]  | 
V10Log.UBXE.nak_error = UBXE(:,6);                               %   5. | err4     | nak_error                      | [U8]  | [100:100]  | 
V10Log.UBXE.Sum = UBXE(:,7);                                     %   6. | Sum      | Sum                            | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% PWMO
try
V10Log.PWMO.TimeUS = PWMO(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.PWMO.start_count = PWMO(:,3);                             %   2. | SCT      | start_count                    | [U16] | [12:12]    | 
V10Log.PWMO.pwm_esc(:,1) = PWMO(:,4);                            %   3. | EC0      | pwm_esc[0]                     | [U16] | [12:12]    | 
V10Log.PWMO.pwm_esc(:,2) = PWMO(:,5);                            %   4. | EC1      | pwm_esc[1]                     | [U16] | [12:12]    | 
V10Log.PWMO.pwm_esc(:,3) = PWMO(:,6);                            %   5. | EC2      | pwm_esc[2]                     | [U16] | [12:12]    | 
V10Log.PWMO.pwm_esc(:,4) = PWMO(:,7);                            %   6. | EC3      | pwm_esc[3]                     | [U16] | [12:12]    | 
V10Log.PWMO.pwm_esc(:,5) = PWMO(:,8);                            %   7. | EC4      | pwm_esc[4]                     | [U16] | [12:12]    | 
V10Log.PWMO.pwm_servo(:,1) = PWMO(:,9);                          %   8. | SV0      | pwm_servo[0]                   | [U16] | [12:12]    | 
V10Log.PWMO.pwm_servo(:,2) = PWMO(:,10);                         %   9. | SV1      | pwm_servo[1]                   | [U16] | [12:12]    | 
V10Log.PWMO.pwm_servo(:,3) = PWMO(:,11);                         %  10. | SV2      | pwm_servo[2]                   | [U16] | [12:12]    | 
V10Log.PWMO.pwm_servo(:,4) = PWMO(:,12);                         %  11. | SV3      | pwm_servo[3]                   | [U16] | [12:12]    | 
V10Log.PWMO.pwm_servo(:,5) = PWMO(:,13);                         %  12. | SV4      | pwm_servo[4]                   | [U16] | [12:12]    | 
V10Log.PWMO.pwm_tilt = PWMO(:,14);                               %  13. | Tilt     | pwm_tilt                       | [U16] | [12:12]    | 
V10Log.PWMO.pwm_status = PWMO(:,15);                             %  14. | sta      | pwm_status                     | [U8]  | [12:12]    | 
V10Log.PWMO.Sum = PWMO(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% MCMD
try
V10Log.MCMD.TimeUS = MCMD(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.MCMD.log_exe_time = MCMD(:,3);                            %   2. | exe      | log_exe_time                   | [U32] | [100:100]  | 
V10Log.MCMD.test_send_cnt(:,1) = MCMD(:,4);                      %   3. | cnt0     | test_send_cnt[0]               | [U32] | [100:100]  | 
V10Log.MCMD.test_send_cnt(:,2) = MCMD(:,5);                      %   4. | cnt1     | test_send_cnt[1]               | [U32] | [100:100]  | 
V10Log.MCMD.Sum = MCMD(:,6);                                     %   5. | Sum      | Sum                            | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% ECS1
try
V10Log.ECS1.TimeUS = ECS1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.ECS1.state(:,1) = ECS1(:,3);                              %   2. | s1       | state[0]                       | [U8]  | [100:100]  | 
V10Log.ECS1.state(:,2) = ECS1(:,4);                              %   3. | s2       | state[1]                       | [U8]  | [100:100]  | 
V10Log.ECS1.state(:,3) = ECS1(:,5);                              %   4. | s3       | state[2]                       | [U8]  | [100:100]  | 
V10Log.ECS1.ecs_rpm(:,1) = ECS1(:,6);                            %   5. | r1       | ecs_rpm[0]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_rpm(:,2) = ECS1(:,7);                            %   6. | r2       | ecs_rpm[1]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_rpm(:,3) = ECS1(:,8);                            %   7. | r3       | ecs_rpm[2]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_imv(:,1) = ECS1(:,9);                            %   8. | i1       | ecs_imv[0]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_imv(:,2) = ECS1(:,10);                           %   9. | i2       | ecs_imv[1]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_imv(:,3) = ECS1(:,11);                           %  10. | i3       | ecs_imv[2]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_ppm(:,1) = ECS1(:,12);                           %  11. | p1       | ecs_ppm[0]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_ppm(:,2) = ECS1(:,13);                           %  12. | p2       | ecs_ppm[1]                     | [U16] | [100:100]  | 
V10Log.ECS1.ecs_ppm(:,3) = ECS1(:,14);                           %  13. | p3       | ecs_ppm[2]                     | [U16] | [100:100]  | 
V10Log.ECS1.Sum = ECS1(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% ECS2
try
V10Log.ECS2.TimeUS = ECS2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.ECS2.state(:,1) = ECS2(:,3);                              %   2. | s4       | state[0]                       | [U8]  | [100:100]  | 
V10Log.ECS2.state(:,2) = ECS2(:,4);                              %   3. | s5       | state[1]                       | [U8]  | [100:100]  | 
V10Log.ECS2.ecs_rpm(:,1) = ECS2(:,5);                            %   4. | r4       | ecs_rpm[0]                     | [U16] | [100:100]  | 
V10Log.ECS2.ecs_rpm(:,2) = ECS2(:,6);                            %   5. | r5       | ecs_rpm[1]                     | [U16] | [100:100]  | 
V10Log.ECS2.ecs_imv(:,1) = ECS2(:,7);                            %   6. | i4       | ecs_imv[0]                     | [U16] | [100:100]  | 
V10Log.ECS2.ecs_imv(:,2) = ECS2(:,8);                            %   7. | i5       | ecs_imv[1]                     | [U16] | [100:100]  | 
V10Log.ECS2.ecs_ppm(:,1) = ECS2(:,9);                            %   8. | p4       | ecs_ppm[0]                     | [U16] | [100:100]  | 
V10Log.ECS2.ecs_ppm(:,2) = ECS2(:,10);                           %   9. | p5       | ecs_ppm[1]                     | [U16] | [100:100]  | 
V10Log.ECS2.flag(:,1) = ECS2(:,11);                              %  10. | f1       | flag[0]                        | [U8]  | [100:100]  | 
V10Log.ECS2.flag(:,2) = ECS2(:,12);                              %  11. | f2       | flag[1]                        | [U8]  | [100:100]  | 
V10Log.ECS2.flag(:,3) = ECS2(:,13);                              %  12. | f3       | flag[2]                        | [U8]  | [100:100]  | 
V10Log.ECS2.flag(:,4) = ECS2(:,14);                              %  13. | f4       | flag[3]                        | [U8]  | [100:100]  | 
V10Log.ECS2.flag(:,5) = ECS2(:,15);                              %  14. | f5       | flag[4]                        | [U8]  | [100:100]  | 
V10Log.ECS2.Sum = ECS2(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% LASE
try
V10Log.LASE.TimeUS = LASE(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.LASE.laser1_valid = LASE(:,3);                            %   2. | l1_valid | laser1_valid                   | [U8]  | [100:100]  | 
V10Log.LASE.laser1_distance = LASE(:,4);                         %   3. | l1_data  | laser1_distance                | [U16] | [100:100]  | 
V10Log.LASE.laser2_valid = LASE(:,5);                            %   4. | l2_valid | laser2_valid                   | [U8]  | [100:100]  | 
V10Log.LASE.laser2_distance = LASE(:,6);                         %   5. | l2_data  | laser2_distance                | [U16] | [100:100]  | 
V10Log.LASE.laser_flag = LASE(:,7);                              %   6. | flag     | laser_flag                     | [U8]  | [100:100]  | 
V10Log.LASE.Sum = LASE(:,8);                                     %   7. | Sum      | Sum                            | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% H750
try
V10Log.H750.TimeUS = H750(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.H750.ntc_res = H750(:,1);                                 %   2. | res      | ntc_res                        | [U16] | [100:100]  | 
V10Log.H750.fan_feedback = H750(:,1);                            %   3. | fan      | fan_feedback                   | [U16] | [100:100]  | 
V10Log.H750.vcc_12 = H750(:,1);                                  %   4. | v0       | vcc_12                         | [U16] | [100:100]  | 
V10Log.H750.vcc_5v_1 = H750(:,1);                                %   5. | v1       | vcc_5v_1                       | [U16] | [100:100]  | 
V10Log.H750.vcc_5v_2 = H750(:,1);                                %   6. | v2       | vcc_5v_2                       | [U16] | [100:100]  | 
V10Log.H750.vcc_3_3v_1 = H750(:,1);                              %   7. | v3       | vcc_3.3v_1                     | [U16] | [100:100]  | 
V10Log.H750.vcc_3_3v_2 = H750(:,1);                              %   8. | v4       | vcc_3.3v_2                     | [U16] | [100:100]  | 
V10Log.H750.vcc_7_5v_1 = H750(:,1);                              %   9. | v5       | vcc_7.5v_1                     | [U16] | [100:100]  | 
V10Log.H750.vcc_7_5v_1 = H750(:,1);                              %  10. | v6       | vcc_7.5v_1                     | [U16] | [100:100]  | 
V10Log.H750.vcc_25v = H750(:,1);                                 %  11. | v7       | vcc_25v                        | [U16] | [100:100]  | 
V10Log.H750.angle0 = H750(:,1);                                  %  12. | an0      | angle0                         | [U8]  | [100:100]  | 
V10Log.H750.angle1 = H750(:,1);                                  %  13. | an1      | angle1                         | [U8]  | [100:100]  | 
V10Log.H750.angle2 = H750(:,1);                                  %  14. | an2      | angle2                         | [U8]  | [100:100]  | 
V10Log.H750.angle3 = H750(:,1);                                  %  15. | an3      | angle3                         | [U8]  | [100:100]  | 
V10Log.H750.angle4 = H750(:,1);                                  %  16. | an4      | angle4                         | [U8]  | [100:100]  | 
catch ME
	disp(ME.message);
end
%% BT00
try
V10Log.BT00.TimeUS = BT00(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT00.bat_pack_num = BT00(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT00.Design_Cap = BT00(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT00.Design_Volt = BT00(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT00.Manufacture_Date = BT00(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT00.Serial_Num = BT00(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT00.FW_Version = BT00(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT00.Run_Time_To_Empty = BT00(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT00.Average_Time_To_Empty = BT00(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT00.Rx_Count = BT00(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT00.Cycle_Count = BT00(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT00.Total_Cycles = BT00(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT00.SOH = BT00(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT00.Sum = BT00(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT01
try
V10Log.BT01.TimeUS = BT01(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT01.Temperature(:,1) = BT01(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT01.Temperature(:,2) = BT01(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT01.Temperature(:,3) = BT01(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT01.ASOC = BT01(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT01.RSOC = BT01(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT01.Rem_Cap = BT01(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT01.FCC = BT01(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT01.Safty_Status = BT01(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT01.Other_Status = BT01(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT01.Balance_Status = BT01(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT01.Power_State = BT01(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT01.flag = BT01(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT01.Sum = BT01(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT02
try
V10Log.BT02.TimeUS = BT02(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT02.Voltage(:,1) = BT02(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT02.Voltage(:,2) = BT02(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,1) = BT02(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,2) = BT02(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,3) = BT02(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,4) = BT02(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,5) = BT02(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,6) = BT02(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,7) = BT02(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT02.Cell_Volt(:,8) = BT02(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT02.Now_Current(:,1) = BT02(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT02.Now_Current(:,2) = BT02(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT02.Average_Current = BT02(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT02.Sum = BT02(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT10
try
V10Log.BT10.TimeUS = BT10(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT10.bat_pack_num = BT10(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT10.Design_Cap = BT10(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT10.Design_Volt = BT10(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT10.Manufacture_Date = BT10(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT10.Serial_Num = BT10(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT10.FW_Version = BT10(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT10.Run_Time_To_Empty = BT10(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT10.Average_Time_To_Empty = BT10(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT10.Rx_Count = BT10(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT10.Cycle_Count = BT10(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT10.Total_Cycles = BT10(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT10.SOH = BT10(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT10.Sum = BT10(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT11
try
V10Log.BT11.TimeUS = BT11(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT11.Temperature(:,1) = BT11(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT11.Temperature(:,2) = BT11(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT11.Temperature(:,3) = BT11(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT11.ASOC = BT11(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT11.RSOC = BT11(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT11.Rem_Cap = BT11(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT11.FCC = BT11(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT11.Safty_Status = BT11(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT11.Other_Status = BT11(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT11.Balance_Status = BT11(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT11.Power_State = BT11(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT11.flag = BT11(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT11.Sum = BT11(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT12
try
V10Log.BT12.TimeUS = BT12(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT12.Voltage(:,1) = BT12(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT12.Voltage(:,2) = BT12(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,1) = BT12(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,2) = BT12(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,3) = BT12(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,4) = BT12(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,5) = BT12(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,6) = BT12(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,7) = BT12(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT12.Cell_Volt(:,8) = BT12(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT12.Now_Current(:,1) = BT12(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT12.Now_Current(:,2) = BT12(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT12.Average_Current = BT12(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT12.Sum = BT12(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT20
try
V10Log.BT20.TimeUS = BT20(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT20.bat_pack_num = BT20(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT20.Design_Cap = BT20(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT20.Design_Volt = BT20(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT20.Manufacture_Date = BT20(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT20.Serial_Num = BT20(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT20.FW_Version = BT20(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT20.Run_Time_To_Empty = BT20(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT20.Average_Time_To_Empty = BT20(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT20.Rx_Count = BT20(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT20.Cycle_Count = BT20(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT20.Total_Cycles = BT20(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT20.SOH = BT20(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT20.Sum = BT20(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT21
try
V10Log.BT21.TimeUS = BT21(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT21.Temperature(:,1) = BT21(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT21.Temperature(:,2) = BT21(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT21.Temperature(:,3) = BT21(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT21.ASOC = BT21(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT21.RSOC = BT21(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT21.Rem_Cap = BT21(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT21.FCC = BT21(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT21.Safty_Status = BT21(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT21.Other_Status = BT21(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT21.Balance_Status = BT21(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT21.Power_State = BT21(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT21.flag = BT21(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT21.Sum = BT21(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT22
try
V10Log.BT22.TimeUS = BT22(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT22.Voltage(:,1) = BT22(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT22.Voltage(:,2) = BT22(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,1) = BT22(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,2) = BT22(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,3) = BT22(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,4) = BT22(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,5) = BT22(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,6) = BT22(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,7) = BT22(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT22.Cell_Volt(:,8) = BT22(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT22.Now_Current(:,1) = BT22(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT22.Now_Current(:,2) = BT22(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT22.Average_Current = BT22(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT22.Sum = BT22(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT30
try
V10Log.BT30.TimeUS = BT30(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT30.bat_pack_num = BT30(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT30.Design_Cap = BT30(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT30.Design_Volt = BT30(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT30.Manufacture_Date = BT30(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT30.Serial_Num = BT30(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT30.FW_Version = BT30(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT30.Run_Time_To_Empty = BT30(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT30.Average_Time_To_Empty = BT30(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT30.Rx_Count = BT30(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT30.Cycle_Count = BT30(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT30.Total_Cycles = BT30(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT30.SOH = BT30(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT30.Sum = BT30(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT31
try
V10Log.BT31.TimeUS = BT31(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT31.Temperature(:,1) = BT31(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT31.Temperature(:,2) = BT31(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT31.Temperature(:,3) = BT31(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT31.ASOC = BT31(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT31.RSOC = BT31(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT31.Rem_Cap = BT31(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT31.FCC = BT31(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT31.Safty_Status = BT31(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT31.Other_Status = BT31(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT31.Balance_Status = BT31(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT31.Power_State = BT31(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT31.flag = BT31(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT31.Sum = BT31(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT32
try
V10Log.BT32.TimeUS = BT32(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT32.Voltage(:,1) = BT32(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT32.Voltage(:,2) = BT32(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,1) = BT32(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,2) = BT32(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,3) = BT32(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,4) = BT32(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,5) = BT32(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,6) = BT32(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,7) = BT32(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT32.Cell_Volt(:,8) = BT32(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT32.Now_Current(:,1) = BT32(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT32.Now_Current(:,2) = BT32(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT32.Average_Current = BT32(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT32.Sum = BT32(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT40
try
V10Log.BT40.TimeUS = BT40(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT40.bat_pack_num = BT40(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT40.Design_Cap = BT40(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT40.Design_Volt = BT40(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT40.Manufacture_Date = BT40(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT40.Serial_Num = BT40(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT40.FW_Version = BT40(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT40.Run_Time_To_Empty = BT40(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT40.Average_Time_To_Empty = BT40(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT40.Rx_Count = BT40(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT40.Cycle_Count = BT40(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT40.Total_Cycles = BT40(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT40.SOH = BT40(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT40.Sum = BT40(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT41
try
V10Log.BT41.TimeUS = BT41(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT41.Temperature(:,1) = BT41(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT41.Temperature(:,2) = BT41(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT41.Temperature(:,3) = BT41(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT41.ASOC = BT41(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT41.RSOC = BT41(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT41.Rem_Cap = BT41(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT41.FCC = BT41(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT41.Safty_Status = BT41(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT41.Other_Status = BT41(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT41.Balance_Status = BT41(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT41.Power_State = BT41(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT41.flag = BT41(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT41.Sum = BT41(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT42
try
V10Log.BT42.TimeUS = BT42(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT42.Voltage(:,1) = BT42(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT42.Voltage(:,2) = BT42(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,1) = BT42(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,2) = BT42(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,3) = BT42(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,4) = BT42(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,5) = BT42(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,6) = BT42(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,7) = BT42(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT42.Cell_Volt(:,8) = BT42(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT42.Now_Current(:,1) = BT42(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT42.Now_Current(:,2) = BT42(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT42.Average_Current = BT42(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT42.Sum = BT42(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT50
try
V10Log.BT50.TimeUS = BT50(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT50.bat_pack_num = BT50(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT50.Design_Cap = BT50(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT50.Design_Volt = BT50(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT50.Manufacture_Date = BT50(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT50.Serial_Num = BT50(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT50.FW_Version = BT50(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT50.Run_Time_To_Empty = BT50(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT50.Average_Time_To_Empty = BT50(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT50.Rx_Count = BT50(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT50.Cycle_Count = BT50(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT50.Total_Cycles = BT50(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT50.SOH = BT50(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT50.Sum = BT50(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT51
try
V10Log.BT51.TimeUS = BT51(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT51.Temperature(:,1) = BT51(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT51.Temperature(:,2) = BT51(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT51.Temperature(:,3) = BT51(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT51.ASOC = BT51(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT51.RSOC = BT51(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT51.Rem_Cap = BT51(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT51.FCC = BT51(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT51.Safty_Status = BT51(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT51.Other_Status = BT51(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT51.Balance_Status = BT51(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT51.Power_State = BT51(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT51.flag = BT51(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT51.Sum = BT51(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT52
try
V10Log.BT52.TimeUS = BT52(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT52.Voltage(:,1) = BT52(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT52.Voltage(:,2) = BT52(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,1) = BT52(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,2) = BT52(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,3) = BT52(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,4) = BT52(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,5) = BT52(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,6) = BT52(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,7) = BT52(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT52.Cell_Volt(:,8) = BT52(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT52.Now_Current(:,1) = BT52(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT52.Now_Current(:,2) = BT52(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT52.Average_Current = BT52(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT52.Sum = BT52(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT60
try
V10Log.BT60.TimeUS = BT60(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT60.bat_pack_num = BT60(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT60.Design_Cap = BT60(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT60.Design_Volt = BT60(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT60.Manufacture_Date = BT60(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT60.Serial_Num = BT60(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT60.FW_Version = BT60(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT60.Run_Time_To_Empty = BT60(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT60.Average_Time_To_Empty = BT60(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT60.Rx_Count = BT60(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT60.Cycle_Count = BT60(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT60.Total_Cycles = BT60(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT60.SOH = BT60(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT60.Sum = BT60(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT61
try
V10Log.BT61.TimeUS = BT61(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT61.Temperature(:,1) = BT61(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT61.Temperature(:,2) = BT61(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT61.Temperature(:,3) = BT61(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT61.ASOC = BT61(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT61.RSOC = BT61(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT61.Rem_Cap = BT61(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT61.FCC = BT61(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT61.Safty_Status = BT61(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT61.Other_Status = BT61(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT61.Balance_Status = BT61(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT61.Power_State = BT61(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT61.flag = BT61(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT61.Sum = BT61(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT62
try
V10Log.BT62.TimeUS = BT62(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT62.Voltage(:,1) = BT62(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT62.Voltage(:,2) = BT62(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,1) = BT62(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,2) = BT62(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,3) = BT62(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,4) = BT62(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,5) = BT62(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,6) = BT62(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,7) = BT62(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT62.Cell_Volt(:,8) = BT62(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT62.Now_Current(:,1) = BT62(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT62.Now_Current(:,2) = BT62(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT62.Average_Current = BT62(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT62.Sum = BT62(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT70
try
V10Log.BT70.TimeUS = BT70(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT70.bat_pack_num = BT70(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT70.Design_Cap = BT70(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT70.Design_Volt = BT70(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT70.Manufacture_Date = BT70(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT70.Serial_Num = BT70(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT70.FW_Version = BT70(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT70.Run_Time_To_Empty = BT70(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT70.Average_Time_To_Empty = BT70(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT70.Rx_Count = BT70(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT70.Cycle_Count = BT70(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT70.Total_Cycles = BT70(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT70.SOH = BT70(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT70.Sum = BT70(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT71
try
V10Log.BT71.TimeUS = BT71(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT71.Temperature(:,1) = BT71(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT71.Temperature(:,2) = BT71(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT71.Temperature(:,3) = BT71(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT71.ASOC = BT71(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT71.RSOC = BT71(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT71.Rem_Cap = BT71(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT71.FCC = BT71(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT71.Safty_Status = BT71(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT71.Other_Status = BT71(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT71.Balance_Status = BT71(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT71.Power_State = BT71(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT71.flag = BT71(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT71.Sum = BT71(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT72
try
V10Log.BT72.TimeUS = BT72(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT72.Voltage(:,1) = BT72(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT72.Voltage(:,2) = BT72(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,1) = BT72(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,2) = BT72(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,3) = BT72(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,4) = BT72(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,5) = BT72(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,6) = BT72(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,7) = BT72(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT72.Cell_Volt(:,8) = BT72(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT72.Now_Current(:,1) = BT72(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT72.Now_Current(:,2) = BT72(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT72.Average_Current = BT72(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT72.Sum = BT72(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT80
try
V10Log.BT80.TimeUS = BT80(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT80.bat_pack_num = BT80(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT80.Design_Cap = BT80(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT80.Design_Volt = BT80(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT80.Manufacture_Date = BT80(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT80.Serial_Num = BT80(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT80.FW_Version = BT80(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT80.Run_Time_To_Empty = BT80(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT80.Average_Time_To_Empty = BT80(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT80.Rx_Count = BT80(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT80.Cycle_Count = BT80(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT80.Total_Cycles = BT80(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT80.SOH = BT80(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT80.Sum = BT80(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT81
try
V10Log.BT81.TimeUS = BT81(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT81.Temperature(:,1) = BT81(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT81.Temperature(:,2) = BT81(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT81.Temperature(:,3) = BT81(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT81.ASOC = BT81(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT81.RSOC = BT81(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT81.Rem_Cap = BT81(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT81.FCC = BT81(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT81.Safty_Status = BT81(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT81.Other_Status = BT81(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT81.Balance_Status = BT81(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT81.Power_State = BT81(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT81.flag = BT81(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT81.Sum = BT81(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT82
try
V10Log.BT82.TimeUS = BT82(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT82.Voltage(:,1) = BT82(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT82.Voltage(:,2) = BT82(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,1) = BT82(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,2) = BT82(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,3) = BT82(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,4) = BT82(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,5) = BT82(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,6) = BT82(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,7) = BT82(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT82.Cell_Volt(:,8) = BT82(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT82.Now_Current(:,1) = BT82(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT82.Now_Current(:,2) = BT82(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT82.Average_Current = BT82(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT82.Sum = BT82(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT90
try
V10Log.BT90.TimeUS = BT90(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT90.bat_pack_num = BT90(:,3);                            %   2. | num      | bat_pack_num                   | [U8]  | [100:1000] | 
V10Log.BT90.Design_Cap = BT90(:,4);                              %   3. | cap      | Design_Cap                     | [U16] | [100:1000] | 
V10Log.BT90.Design_Volt = BT90(:,5);                             %   4. | vol      | Design_Volt                    | [U16] | [100:1000] | 
V10Log.BT90.Manufacture_Date = BT90(:,6);                        %   5. | manu     | Manufacture_Date               | [U16] | [100:1000] | 
V10Log.BT90.Serial_Num = BT90(:,7);                              %   6. | ser      | Serial_Num                     | [U16] | [100:1000] | 
V10Log.BT90.FW_Version = BT90(:,8);                              %   7. | fw       | FW_Version                     | [U16] | [100:1000] | 
V10Log.BT90.Run_Time_To_Empty = BT90(:,9);                       %   8. | t1       | Run_Time_To_Empty              | [U16] | [100:1000] | 
V10Log.BT90.Average_Time_To_Empty = BT90(:,10);                  %   9. | t2       | Average_Time_To_Empty          | [U16] | [100:1000] | 
V10Log.BT90.Rx_Count = BT90(:,11);                               %  10. | rxc      | Rx_Count                       | [U16] | [100:1000] | 
V10Log.BT90.Cycle_Count = BT90(:,12);                            %  11. | cyc1     | Cycle_Count                    | [U16] | [100:1000] | 
V10Log.BT90.Total_Cycles = BT90(:,13);                           %  12. | cyc2     | Total_Cycles                   | [U16] | [100:1000] | 
V10Log.BT90.SOH = BT90(:,14);                                    %  13. | SOH      | SOH                            | [U16] | [100:1000] | 
V10Log.BT90.Sum = BT90(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT91
try
V10Log.BT91.TimeUS = BT91(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT91.Temperature(:,1) = BT91(:,3);                        %   2. | tp1      | Temperature[0]                 | [U16] | [100:1000] | 
V10Log.BT91.Temperature(:,2) = BT91(:,4);                        %   3. | tp2      | Temperature[1]                 | [U16] | [100:1000] | 
V10Log.BT91.Temperature(:,3) = BT91(:,5);                        %   4. | tp3      | Temperature[2]                 | [U16] | [100:1000] | 
V10Log.BT91.ASOC = BT91(:,6);                                    %   5. | ASOC     | ASOC                           | [U8]  | [100:1000] | 
V10Log.BT91.RSOC = BT91(:,7);                                    %   6. | RSOC     | RSOC                           | [U8]  | [100:1000] | 
V10Log.BT91.Rem_Cap = BT91(:,8);                                 %   7. | rcap     | Rem_Cap                        | [U16] | [100:1000] | 
V10Log.BT91.FCC = BT91(:,9);                                     %   8. | fcc      | FCC                            | [U16] | [100:1000] | 
V10Log.BT91.Safty_Status = BT91(:,10);                           %   9. | ss       | Safty_Status                   | [U16] | [100:1000] | 
V10Log.BT91.Other_Status = BT91(:,11);                           %  10. | os       | Other_Status                   | [U16] | [100:1000] | 
V10Log.BT91.Balance_Status = BT91(:,12);                         %  11. | bs       | Balance_Status                 | [U16] | [100:1000] | 
V10Log.BT91.Power_State = BT91(:,13);                            %  12. | ps       | Power_State                    | [U8]  | [100:1000] | 
V10Log.BT91.flag = BT91(:,14);                                   %  13. | flag     | flag                           | [U8]  | [100:1000] | 
V10Log.BT91.Sum = BT91(:,15);                                    %  14. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% BT92
try
V10Log.BT92.TimeUS = BT92(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:1000] | 
V10Log.BT92.Voltage(:,1) = BT92(:,3);                            %   2. | v1       | Voltage[0]                     | [U16] | [100:1000] | 
V10Log.BT92.Voltage(:,2) = BT92(:,4);                            %   3. | v2       | Voltage[1]                     | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,1) = BT92(:,5);                          %   4. | cv1      | Cell_Volt[0]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,2) = BT92(:,6);                          %   5. | cv2      | Cell_Volt[1]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,3) = BT92(:,7);                          %   6. | cv3      | Cell_Volt[2]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,4) = BT92(:,8);                          %   7. | cv4      | Cell_Volt[3]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,5) = BT92(:,9);                          %   8. | cv5      | Cell_Volt[4]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,6) = BT92(:,10);                         %   9. | cv6      | Cell_Volt[5]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,7) = BT92(:,11);                         %  10. | cv7      | Cell_Volt[6]                   | [U16] | [100:1000] | 
V10Log.BT92.Cell_Volt(:,8) = BT92(:,12);                         %  11. | cv8      | Cell_Volt[7]                   | [U16] | [100:1000] | 
V10Log.BT92.Now_Current(:,1) = BT92(:,13);                       %  12. | c1       | Now_Current[0]                 | [i32] | [100:1000] | 
V10Log.BT92.Now_Current(:,2) = BT92(:,14);                       %  13. | c2       | Now_Current[1]                 | [i32] | [100:1000] | 
V10Log.BT92.Average_Current = BT92(:,15);                        %  14. | ac       | Average_Current                | [i32] | [100:1000] | 
V10Log.BT92.Sum = BT92(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [100:1000] | 
catch ME
	disp(ME.message);
end
%% ALG0
try
V10Log.ALGO_STATE.TimeUS = ALG0(:,2);                            %   1. | TimeUS   | TimeUS                         | [U32] | [100:96]   | 
V10Log.ALGO_STATE.FC_Version = ALG0(:,3);                        %   2. | FcV      | FC_Version                     | [U16] | [100:96]   | 
V10Log.ALGO_STATE.Logic_Version = ALG0(:,4);                     %   3. | LogicV   | Logic_Version                  | [U16] | [100:96]   | 
V10Log.ALGO_STATE.Driver_Version = ALG0(:,5);                    %   4. | DriV     | Driver_Version                 | [U16] | [100:96]   | 
V10Log.ALGO_STATE.reset_status = ALG0(:,6);                      %   5. | Rst      | reset_status                   | [U16] | [100:96]   | 
V10Log.ALGO_STATE.Sum = ALG0(:,7);                               %   6. | Sum      | Sum                            | [U8]  | [100:96]   | 
catch ME
	disp(ME.message);
end
%% ALG1
try
V10Log.ALGO_STATE.TimeUS = ALG1(:,2);                            %   1. | Tim      | TimeUS                         | [U32] | [100:96]   | 
V10Log.ALGO_STATE.time_algo_imu = ALG1(:,3);                     %   2. | tImu     | time_algo_imu                  | [U32] | [100:96]   | 
V10Log.ALGO_STATE.time_algo_pwm = ALG1(:,4);                     %   3. | tPwm     | time_algo_pwm                  | [U32] | [100:96]   | 
V10Log.ALGO_STATE.time_algo_exe = ALG1(:,5);                     %   4. | tExe     | time_algo_exe                  | [U32] | [100:96]   | 
V10Log.ALGO_STATE.remote_lock = ALG1(:,7);                       %   5. | rk       | remote_lock                    | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.switch_lock_0 = ALG1(:,8);                     %   6. | sw0      | switch_lock_0                  | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.switch_lock_1 = ALG1(:,9);                     %   7. | sw1      | switch_lock_1                  | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.ground_station_lock = ALG1(:,10);              %   8. | gsk      | ground_station_lock            | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.extend_lock_status = ALG1(:,11);               %   9. | ek       | extend_lock_status             | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.fc_simulation = ALG1(:,12);                    %  10. | simu     | fc_simulation                  | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.ground_station_connect = ALG1(:,13);           %  11. | gsc      | ground_station_connect         | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.ground_station_timeout = ALG1(:,14);           %  12. | gst      | ground_station_timeout         | [U16] | [100:96]   | 
V10Log.ALGO_STATE.ground_station_count = ALG1(:,15);             %  13. | gsn      | ground_station_count           | [U16] | [100:96]   | 
V10Log.ALGO_STATE.flight_over = ALG1(:,16);                      %  14. | fv       | flight_over                    | [U8]  | [100:96]   | 
V10Log.ALGO_STATE.Sum = ALG1(:,17);                              %  15. | Sum      | Sum                            | [U8]  | [100:96]   | 
catch ME
	disp(ME.message);
end
%% ALG2
try
V10Log.ALGO_STATE.TimeUS = ALG2(:,2);                            %   1. | TimeUS   | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALGO_STATE.exe_time = ALG2(:,3);                          %   2. | exe      | exe_time                       | [U32] | [12:12]    | 
V10Log.ALGO_STATE.algo_remot_roll = ALG2(:,4);                   %   3. | rol      | algo_remot_roll                | [F]   | [12:12]    | 
V10Log.ALGO_STATE.algo_remot_pitch = ALG2(:,5);                  %   4. | pit      | algo_remot_pitch               | [F]   | [12:12]    | 
V10Log.ALGO_STATE.algo_remot_yaw = ALG2(:,6);                    %   5. | yaw      | algo_remot_yaw                 | [F]   | [12:12]    | 
V10Log.ALGO_STATE.algo_remot_throttle = ALG2(:,7);               %   6. | thr      | algo_remot_throttle            | [F]   | [12:12]    | 
V10Log.ALGO_STATE.algo_remot_tilt_angle_in = ALG2(:,8);          %   7. | tilt     | algo_remot_tilt_angle_in       | [F]   | [12:12]    | 
V10Log.ALGO_STATE.Sum = ALG2(:,9);                               %   8. | Sum      | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD1
try
V10Log.BUS_CTRL.TimeUS = ALD1(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.time_log = ALD1(:,3);                            %   2. | time     | time_log                       | [U32] | [12:12]    | 
V10Log.BUS_CTRL.time_exe = ALD1(:,4);                            %   3. | exe      | time_exe                       | [U32] | [12:12]    | 
V10Log.BUS_CTRL.mode = ALD1(:,5);                                %   4. | mode     | mode                           | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.palne_mode = ALD1(:,6);                          %   5. | plmod    | palne_mode                     | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.flightTaskMode = ALD1(:,7);                      %   6. | fmod     | flightTaskMode                 | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.PathMode = ALD1(:,8);                            %   7. | ptmod    | PathMode                       | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.limit_pos_up = ALD1(:,9);                        %   8. | posup    | limit_pos_up                   | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.throttle_upper = ALD1(:,10);                     %   9. | thup     | throttle_upper                 | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.throttle_lower = ALD1(:,11);                     %  10. | thlo     | throttle_lower                 | [U8]  | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD1(:,12);                                %  11. | Sum      | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD2
try
V10Log.BUS_CTRL.TimeUS = ALD2(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.roll = ALD2(:,3);                                %   2. | rol      | roll                           | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pitch = ALD2(:,4);                               %   3. | pit      | pitch                          | [F]   | [12:12]    | 
V10Log.BUS_CTRL.yaw = ALD2(:,5);                                 %   4. | yaw      | yaw                            | [F]   | [12:12]    | 
V10Log.BUS_CTRL.roll_in = ALD2(:,6);                             %   5. | rin      | roll_in                        | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pitch_in = ALD2(:,7);                            %   6. | pin      | pitch_in                       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.yaw_in = ALD2(:,8);                              %   7. | yin      | yaw_in                         | [F]   | [12:12]    | 
V10Log.BUS_CTRL.throttle_in = ALD2(:,9);                         %   8. | tin      | throttle_in                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pwm_out(:,1) = ALD2(:,10);                       %   9. | pw0      | pwm_out[0]                     | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pwm_out(:,2) = ALD2(:,11);                       %  10. | pw1      | pwm_out[1]                     | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pwm_out(:,3) = ALD2(:,12);                       %  11. | pw2      | pwm_out[2]                     | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pwm_out(:,4) = ALD2(:,13);                       %  12. | pw3      | pwm_out[3]                     | [F]   | [12:12]    | 
V10Log.BUS_CTRL.tail_tilt = ALD2(:,14);                          %  13. | til      | tail_tilt                      | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pwm_tail = ALD2(:,15);                           %  14. | pwm      | pwm_tail                       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD2(:,16);                                %  15. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD3
try
V10Log.BUS_CTRL.TimeUS = ALD3(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.yaw_out = ALD3(:,3);                             %   2. | yout     | yaw_out                        | [F]   | [12:12]    | 
V10Log.BUS_CTRL.k_flap = ALD3(:,4);                              %   3. | flap     | k_flap                         | [F]   | [12:12]    | 
V10Log.BUS_CTRL.current_loc(:,1) = ALD3(:,5);                    %   4. | cl0      | current_loc[0]                 | [F]   | [12:12]    | 
V10Log.BUS_CTRL.current_loc(:,2) = ALD3(:,6);                    %   5. | cl1      | current_loc[1]                 | [F]   | [12:12]    | 
V10Log.BUS_CTRL.curr_vel(:,1) = ALD3(:,7);                       %   6. | cv0      | curr_vel[0]                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.curr_vel(:,2) = ALD3(:,8);                       %   7. | cv1      | curr_vel[1]                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.curr_vel(:,3) = ALD3(:,9);                       %   8. | cv2      | curr_vel[2]                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.curr_pos(:,1) = ALD3(:,10);                      %   9. | cp0      | curr_pos[0]                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.curr_pos(:,2) = ALD3(:,11);                      %  10. | cp1      | curr_pos[1]                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.rate_target_ang_vel(:,1) = ALD3(:,12);           %  11. | rvl0     | rate_target_ang_vel[0]         | [F]   | [12:12]    | 
V10Log.BUS_CTRL.rate_target_ang_vel(:,2) = ALD3(:,13);           %  12. | rvl1     | rate_target_ang_vel[1]         | [F]   | [12:12]    | 
V10Log.BUS_CTRL.rate_target_ang_vel(:,3) = ALD3(:,14);           %  13. | rvl2     | rate_target_ang_vel[2]         | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD3(:,15);                                %  14. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD4
try
V10Log.BUS_CTRL.TimeUS = ALD4(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.attitude_target_euler_rate(:,1) = ALD4(:,3);     %   2. | er0      | attitude_target_euler_rate[0]  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_target_euler_rate(:,2) = ALD4(:,4);     %   3. | er1      | attitude_target_euler_rate[1]  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_target_euler_rate(:,3) = ALD4(:,5);     %   4. | er2      | attitude_target_euler_rate[2]  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_target_euler_angle(:,1) = ALD4(:,6);    %   5. | ea0      | attitude_target_euler_angle[0] | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_target_euler_angle(:,2) = ALD4(:,7);    %   6. | ea1      | attitude_target_euler_angle[1] | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_target_euler_angle(:,3) = ALD4(:,8);    %   7. | ea2      | attitude_target_euler_angle[2] | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pos_target(:,1) = ALD4(:,9);                     %   8. | ptg0     | pos_target[0]                  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pos_target(:,2) = ALD4(:,10);                    %   9. | ptg1     | pos_target[1]                  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pos_target(:,3) = ALD4(:,11);                    %  10. | ptg2     | pos_target[2]                  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.vel_target(:,1) = ALD4(:,12);                    %  11. | vtg0     | vel_target[0]                  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.vel_target(:,2) = ALD4(:,13);                    %  12. | vtg1     | vel_target[1]                  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.vel_target(:,3) = ALD4(:,14);                    %  13. | vtg2     | vel_target[2]                  | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD4(:,15);                                %  14. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD5
try
V10Log.BUS_CTRL.TimeUS = ALD5(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.accel_target(:,1) = ALD5(:,3);                   %   2. | acc0     | accel_target[0]                | [F]   | [12:12]    | 
V10Log.BUS_CTRL.accel_target(:,2) = ALD5(:,4);                   %   3. | acc1     | accel_target[1]                | [F]   | [12:12]    | 
V10Log.BUS_CTRL.accel_target(:,3) = ALD5(:,5);                   %   4. | acc2     | accel_target[2]                | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_error_vector(:,1) = ALD5(:,6);          %   5. | vect0    | attitude_error_vector[0]       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_error_vector(:,2) = ALD5(:,7);          %   6. | vect1    | attitude_error_vector[1]       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.attitude_error_vector(:,3) = ALD5(:,8);          %   7. | vect2    | attitude_error_vector[2]       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pos_error(:,1) = ALD5(:,9);                      %   8. | per0     | pos_error[0]                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pos_error(:,2) = ALD5(:,10);                     %   9. | per1     | pos_error[1]                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pos_error(:,3) = ALD5(:,11);                     %  10. | per2     | pos_error[2]                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.vel_desired(:,3) = ALD5(:,12);                   %  11. | veld2    | vel_desired[2]                 | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD5(:,13);                                %  12. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD6
try
V10Log.BUS_CTRL.TimeUS = ALD6(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.z_accel_meas = ALD6(:,3);                        %   2. | zacm     | z_accel_meas                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.climb_rate_cms = ALD6(:,4);                      %   3. | clrc     | climb_rate_cms                 | [F]   | [12:12]    | 
V10Log.BUS_CTRL.throttle_filter = ALD6(:,5);                     %   4. | tfil     | throttle_filter                | [F]   | [12:12]    | 
V10Log.BUS_CTRL.nav_pitch_cd = ALD6(:,6);                        %   5. | navcd    | nav_pitch_cd                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.vel_forward_last_pct = ALD6(:,7);                %   6. | vlpct    | vel_forward_last_pct           | [F]   | [12:12]    | 
V10Log.BUS_CTRL.k_rudder = ALD6(:,8);                            %   7. | krud     | k_rudder                       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.k_elevator = ALD6(:,9);                          %   8. | kele     | k_elevator                     | [F]   | [12:12]    | 
V10Log.BUS_CTRL.k_throttle = ALD6(:,10);                         %   9. | kthr     | k_throttle                     | [F]   | [12:12]    | 
V10Log.BUS_CTRL.k_aileron = ALD6(:,11);                          %  10. | kail     | k_aileron                      | [F]   | [12:12]    | 
V10Log.BUS_CTRL.curr_alt = ALD6(:,12);                           %  11. | curalt   | curr_alt                       | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD6(:,13);                                %  12. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD7
try
V10Log.BUS_CTRL.TimeUS = ALD7(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.weathervane_last_output = ALD7(:,3);             %   2. | weat     | weathervane_last_output        | [F]   | [12:12]    | 
V10Log.BUS_CTRL.roll_target = ALD7(:,4);                         %   3. | rotg     | roll_target                    | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pitch_target = ALD7(:,5);                        %   4. | pitg     | pitch_target                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.roll_target_pilot = ALD7(:,6);                   %   5. | rotp     | roll_target_pilot              | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pitch_dem = ALD7(:,7);                           %   6. | pitdm    | pitch_dem                      | [F]   | [12:12]    | 
V10Log.BUS_CTRL.hgt_dem = ALD7(:,8);                             %   7. | hgtdm    | hgt_dem                        | [F]   | [12:12]    | 
V10Log.BUS_CTRL.throttle_dem = ALD7(:,9);                        %   8. | thdm     | throttle_dem                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.latAccDem = ALD7(:,10);                          %   9. | accdm    | latAccDem                      | [F]   | [12:12]    | 
V10Log.BUS_CTRL.aspeed = ALD7(:,11);                             %  10. | aspd     | aspeed                         | [F]   | [12:12]    | 
V10Log.BUS_CTRL.pitch_target_pilot = ALD7(:,12);                 %  11. | pitpi    | pitch_target_pilot             | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD7(:,13);                                %  12. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALD8
try
V10Log.BUS_CTRL.TimeUS = ALD8(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.BUS_CTRL.WP_i = ALD8(:,3);                                %   2. | WP_i     | WP_i                           | [F]   | [12:12]    | 
V10Log.BUS_CTRL.sl_heightCmd = ALD8(:,4);                        %   3. | hgtcmd   | sl_heightCmd                   | [F]   | [12:12]    | 
V10Log.BUS_CTRL.sl_maxClimbSpeed = ALD8(:,5);                    %   4. | clmspd   | sl_maxClimbSpeed               | [F]   | [12:12]    | 
V10Log.BUS_CTRL.sl_flightTaskMode = ALD8(:,6);                   %   5. | fmode    | sl_flightTaskMode              | [F]   | [12:12]    | 
V10Log.BUS_CTRL.Sum = ALD8(:,7);                                 %   6. | Sm       | Sum                            | [F]   | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL1
try
V10Log.IN_MAVLINK.TimeUS = ALL1(:,2);                            %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,1) = ALL1(:,3);    %   2. | LLA0     | mavlink_msg_groundHomeLLA[0]   | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,2) = ALL1(:,4);    %   3. | LLA1     | mavlink_msg_groundHomeLLA[1]   | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,3) = ALL1(:,5);    %   4. | LLA2     | mavlink_msg_groundHomeLLA[2]   | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.Sum = ALL1(:,6);                               %   5. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL2
try
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.TimeUS = ALL2(:,2); %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.fullCapacity = ALL2(:,3); %   2. | cap      | fullCapacity                   | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.lifePercent = ALL2(:,4); %   3. | life     | lifePercent                    | [U8]  | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.cycleTime = ALL2(:,5); %   4. | cycle    | cycleTime                      | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.batteryId = ALL2(:,6); %   5. | batID    | batteryId                      | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.Sum = ALL2(:,7); %   6. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL3
try
V10Log.IN_MAVLINK.mavlink_mission_item_def.TimeUS = ALL3(:,2);   %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.seq = ALL3(:,3);      %   2. | seq      | seq                            | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.x = ALL3(:,4);        %   3. | x        | x                              | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.y = ALL3(:,5);        %   4. | y        | y                              | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.z = ALL3(:,6);        %   5. | z        | z                              | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.Sum = ALL3(:,7);      %   6. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL4
try
V10Log.SensorSelect.TimeUS = ALL4(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SensorSelect.IMU = ALL4(:,3);                             %   2. | IMU      | IMU                            | [F]   | [12:12]    | 
V10Log.SensorSelect.Mag = ALL4(:,4);                             %   3. | Mag      | Mag                            | [F]   | [12:12]    | 
V10Log.SensorSelect.GPS = ALL4(:,5);                             %   4. | GPS      | GPS                            | [F]   | [12:12]    | 
V10Log.SensorSelect.Baro = ALL4(:,6);                            %   5. | Bar      | Baro                           | [F]   | [12:12]    | 
V10Log.SensorSelect.Radar = ALL4(:,7);                           %   6. | Radr     | Radar                          | [F]   | [12:12]    | 
V10Log.SensorSelect.Camera = ALL4(:,8);                          %   7. | CAM      | Camera                         | [F]   | [12:12]    | 
V10Log.SensorSelect.Lidar = ALL4(:,9);                           %   8. | Lidr     | Lidar                          | [F]   | [12:12]    | 
V10Log.SensorSelect.Sum = ALL4(:,10);                            %   9. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL5
try
V10Log.SensorUpdateFlag.TimeUS = ALL5(:,2);                      %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SensorUpdateFlag.mag1 = ALL5(:,3);                        %   2. | mg1      | mag1                           | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.mag2 = ALL5(:,4);                        %   3. | mg2      | mag2                           | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.airspeed1 = ALL5(:,5);                   %   4. | ap1      | airspeed1                      | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.airspeed2 = ALL5(:,6);                   %   5. | ap2      | airspeed2                      | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.baro1 = ALL5(:,7);                       %   6. | br1      | baro1                          | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.baro2 = ALL5(:,8);                       %   7. | br2      | baro2                          | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.IMU1 = ALL5(:,9);                        %   8. | m1       | IMU1                           | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.IMU2 = ALL5(:,10);                       %   9. | m2       | IMU2                           | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.IMU3 = ALL5(:,11);                       %  10. | m3       | IMU3                           | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.IMU4 = ALL5(:,12);                       %  11. | m4       | IMU4                           | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.um482 = ALL5(:,13);                      %  12. | um482    | um482                          | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.ublox1 = ALL5(:,14);                     %  13. | ubx1     | ublox1                         | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.radar1 = ALL5(:,15);                     %  14. | radr1    | radar1                         | [U8]  | [12:12]    | 
V10Log.SensorUpdateFlag.Sum = ALL5(:,16);                        %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL6
try
V10Log.SensorLosttime.TimeUS = ALL6(:,2);                        %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SensorLosttime.mag1 = ALL6(:,3);                          %   2. | mg1      | mag1                           | [F]   | [12:12]    | 
V10Log.SensorLosttime.mag2 = ALL6(:,4);                          %   3. | mg2      | mag2                           | [F]   | [12:12]    | 
V10Log.SensorLosttime.airspeed1 = ALL6(:,5);                     %   4. | ap1      | airspeed1                      | [F]   | [12:12]    | 
V10Log.SensorLosttime.airspeed2 = ALL6(:,6);                     %   5. | ap2      | airspeed2                      | [F]   | [12:12]    | 
V10Log.SensorLosttime.baro1 = ALL6(:,7);                         %   6. | br1      | baro1                          | [F]   | [12:12]    | 
V10Log.SensorLosttime.baro2 = ALL6(:,8);                         %   7. | br2      | baro2                          | [F]   | [12:12]    | 
V10Log.SensorLosttime.IMU1 = ALL6(:,9);                          %   8. | m1       | IMU1                           | [F]   | [12:12]    | 
V10Log.SensorLosttime.IMU2 = ALL6(:,10);                         %   9. | m2       | IMU2                           | [F]   | [12:12]    | 
V10Log.SensorLosttime.IMU3 = ALL6(:,11);                         %  10. | m3       | IMU3                           | [F]   | [12:12]    | 
V10Log.SensorLosttime.IMU4 = ALL6(:,12);                         %  11. | m4       | IMU4                           | [F]   | [12:12]    | 
V10Log.SensorLosttime.um482 = ALL6(:,13);                        %  12. | um482    | um482                          | [F]   | [12:12]    | 
V10Log.SensorLosttime.ublox1 = ALL6(:,14);                       %  13. | ubx1     | ublox1                         | [F]   | [12:12]    | 
V10Log.SensorLosttime.radar1 = ALL6(:,15);                       %  14. | radr1    | radar1                         | [F]   | [12:12]    | 
V10Log.SensorLosttime.Sum = ALL6(:,16);                          %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL7
try
V10Log.SensorStatus.TimeUS = ALL7(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SensorStatus.mag1 = ALL7(:,3);                            %   2. | mg1      | mag1                           | [U8]  | [12:12]    | 
V10Log.SensorStatus.mag2 = ALL7(:,4);                            %   3. | mg2      | mag2                           | [U8]  | [12:12]    | 
V10Log.SensorStatus.airspeed1 = ALL7(:,5);                       %   4. | ap1      | airspeed1                      | [U8]  | [12:12]    | 
V10Log.SensorStatus.airspeed2 = ALL7(:,6);                       %   5. | ap2      | airspeed2                      | [U8]  | [12:12]    | 
V10Log.SensorStatus.baro1 = ALL7(:,7);                           %   6. | br1      | baro1                          | [U8]  | [12:12]    | 
V10Log.SensorStatus.baro2 = ALL7(:,8);                           %   7. | br2      | baro2                          | [U8]  | [12:12]    | 
V10Log.SensorStatus.IMU1 = ALL7(:,9);                            %   8. | m1       | IMU1                           | [U8]  | [12:12]    | 
V10Log.SensorStatus.IMU2 = ALL7(:,10);                           %   9. | m2       | IMU2                           | [U8]  | [12:12]    | 
V10Log.SensorStatus.IMU3 = ALL7(:,11);                           %  10. | m3       | IMU3                           | [U8]  | [12:12]    | 
V10Log.SensorStatus.IMU4 = ALL7(:,12);                           %  11. | m4       | IMU4                           | [U8]  | [12:12]    | 
V10Log.SensorStatus.um482 = ALL7(:,13);                          %  12. | um482    | um482                          | [U8]  | [12:12]    | 
V10Log.SensorStatus.ublox1 = ALL7(:,14);                         %  13. | ubx1     | ublox1                         | [U8]  | [12:12]    | 
V10Log.SensorStatus.radar1 = ALL7(:,15);                         %  14. | radr1    | radar1                         | [U8]  | [12:12]    | 
V10Log.SensorStatus.Sum = ALL7(:,16);                            %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL8
try
V10Log.CAMERA.TimeUS = ALL8(:,2);                                %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.CAMERA.time = ALL8(:,3);                                  %   2. | ctim     | time                           | [F]   | [12:12]    | 
V10Log.CAMERA.trigger = ALL8(:,4);                               %   3. | ctrg     | trigger                        | [F]   | [12:12]    | 
V10Log.CAMERA.LLA(:,1) = ALL8(:,5);                              %   4. | cLL0     | LLA[0]                         | [F]   | [12:12]    | 
V10Log.CAMERA.LLA(:,2) = ALL8(:,6);                              %   5. | cLL1     | LLA[1]                         | [F]   | [12:12]    | 
V10Log.CAMERA.LLA(:,3) = ALL8(:,7);                              %   6. | cLL2     | LLA[2]                         | [F]   | [12:12]    | 
V10Log.CAMERA.groundspeed = ALL8(:,8);                           %   7. | gspd     | groundspeed                    | [F]   | [12:12]    | 
V10Log.CAMERA.Sum = ALL8(:,9);                                   %   8. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% ALL9
try
V10Log.LIDAR.TimeUS = ALL9(:,2);                                 %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.LIDAR.time = ALL9(:,3);                                   %   2. | dtim     | time                           | [F]   | [12:12]    | 
V10Log.LIDAR.trigger = ALL9(:,4);                                %   3. | dtrg     | trigger                        | [F]   | [12:12]    | 
V10Log.LIDAR.LLA(:,1) = ALL9(:,5);                               %   4. | dLL0     | LLA[0]                         | [F]   | [12:12]    | 
V10Log.LIDAR.LLA(:,2) = ALL9(:,6);                               %   5. | dLL1     | LLA[1]                         | [F]   | [12:12]    | 
V10Log.LIDAR.LLA(:,3) = ALL9(:,7);                               %   6. | dLL2     | LLA[2]                         | [F]   | [12:12]    | 
V10Log.LIDAR.groundspeed = ALL9(:,8);                            %   7. | gspd     | groundspeed                    | [F]   | [12:12]    | 
V10Log.LIDAR.Sum = ALL9(:,10);                                   %   8. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL10
try
V10Log.PowerConsume.TimeUS = AL10(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.PowerConsume.AllTheTimeVoltage = AL10(:,3);               %   2. | vol      | AllTheTimeVoltage              | [U8]  | [12:12]    | 
V10Log.PowerConsume.AllTheTimeCurrent = AL10(:,4);               %   3. | cur      | AllTheTimeCurrent              | [U8]  | [12:12]    | 
V10Log.PowerConsume.AllTheTimePowerConsume = AL10(:,5);          %   4. | pow      | AllTheTimePowerConsume         | [U8]  | [12:12]    | 
V10Log.PowerConsume.GroundStandby = AL10(:,6);                   %   5. | std      | GroundStandby                  | [U8]  | [12:12]    | 
V10Log.PowerConsume.TakeOff = AL10(:,7);                         %   6. | take     | TakeOff                        | [U8]  | [12:12]    | 
V10Log.PowerConsume.HoverAdjust = AL10(:,8);                     %   7. | hva      | HoverAdjust                    | [U8]  | [12:12]    | 
V10Log.PowerConsume.Rotor2fix = AL10(:,9);                       %   8. | rot      | Rotor2fix                      | [U8]  | [12:12]    | 
V10Log.PowerConsume.HoverUp = AL10(:,10);                        %   9. | hvp      | HoverUp                        | [U8]  | [12:12]    | 
V10Log.PowerConsume.PathFollow = AL10(:,11);                     %  10. | pth      | PathFollow                     | [U8]  | [12:12]    | 
V10Log.PowerConsume.GoHome = AL10(:,12);                         %  11. | ghm      | GoHome                         | [U8]  | [12:12]    | 
V10Log.PowerConsume.HoverDown = AL10(:,13);                      %  12. | hvd      | HoverDown                      | [U8]  | [12:12]    | 
V10Log.PowerConsume.Fix2Rotor = AL10(:,14);                      %  13. | fix      | Fix2Rotor                      | [U8]  | [12:12]    | 
V10Log.PowerConsume.Land = AL10(:,15);                           %  14. | lan      | Land                           | [U8]  | [12:12]    | 
V10Log.PowerConsume.Sum = AL10(:,16);                            %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL11
try
V10Log.OUT_TASKMODE.TimeUS = AL11(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKMODE.currentPointNum = AL11(:,3);                 %   2. | cup      | currentPointNum                | [U16] | [12:12]    | 
V10Log.OUT_TASKMODE.prePointNum = AL11(:,4);                     %   3. | prp      | prePointNum                    | [U16] | [12:12]    | 
V10Log.OUT_TASKMODE.validPathNum = AL11(:,5);                    %   4. | vap      | validPathNum                   | [U16] | [12:12]    | 
V10Log.OUT_TASKMODE.headingCmd = AL11(:,6);                      %   5. | hcd      | headingCmd                     | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.distToGo = AL11(:,7);                        %   6. | dtg      | distToGo                       | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.dz = AL11(:,8);                              %   7. | dz       | dz                             | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.groundspeedCmd = AL11(:,9);                  %   8. | gsd      | groundspeedCmd                 | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.rollCmd = AL11(:,10);                        %   9. | rcd      | rollCmd                        | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.turnRadiusCmd = AL11(:,11);                  %  10. | tcd      | turnRadiusCmd                  | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.heightCmd = AL11(:,12);                      %  11. | gcd      | heightCmd                      | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.turnCenterLL(:,1) = AL11(:,13);              %  12. | LL0      | turnCenterLL[0]                | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.turnCenterLL(:,2) = AL11(:,14);              %  13. | LL1      | turnCenterLL[1]                | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.dR_turn = AL11(:,15);                        %  14. | dR       | dR_turn                        | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.Sum = AL11(:,16);                            %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL12
try
V10Log.OUT_TASKMODE.TimeUS = AL12(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKMODE.flightTaskMode = AL12(:,3);                  %   2. | tMd      | flightTaskMode                 | [U8]  | [12:12]    | 
V10Log.OUT_TASKMODE.flightControlMode = AL12(:,4);               %   3. | cMd      | flightControlMode              | [U8]  | [12:12]    | 
V10Log.OUT_TASKMODE.AutoManualMode = AL12(:,5);                  %   4. | mMd      | AutoManualMode                 | [U8]  | [12:12]    | 
V10Log.OUT_TASKMODE.comStatus = AL12(:,6);                       %   5. | com      | comStatus                      | [U8]  | [12:12]    | 
V10Log.OUT_TASKMODE.maxClimbSpeed = AL12(:,7);                   %   6. | mClp     | maxClimbSpeed                  | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.prePathPoint_LLA(:,1) = AL12(:,8);           %   7. | LL0      | prePathPoint_LLA[0]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.prePathPoint_LLA(:,2) = AL12(:,9);           %   8. | LL1      | prePathPoint_LLA[1]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.prePathPoint_LLA(:,3) = AL12(:,10);          %   9. | LL2      | prePathPoint_LLA[2]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.curPathPoint_LLA(:,1) = AL12(:,11);          %  10. | LL3      | curPathPoint_LLA[0]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.curPathPoint_LLA(:,2) = AL12(:,12);          %  11. | LL4      | curPathPoint_LLA[1]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.curPathPoint_LLA(:,3) = AL12(:,13);          %  12. | LL5      | curPathPoint_LLA[2]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.whereIsUAV = AL12(:,14);                     %  13. | UAV      | whereIsUAV                     | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.typeAutoMode = AL12(:,15);                   %  14. | aMd      | typeAutoMode                   | [U8]  | [12:12]    | 
V10Log.OUT_TASKMODE.Sum = AL12(:,16);                            %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL13
try
V10Log.OUT_TASKMODE.TimeUS = AL13(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKMODE.airspeedCmd = AL13(:,3);                     %   2. | aspcmd   | airspeedCmd                    | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.LLATaskInterrupt(:,1) = AL13(:,4);           %   3. | LL0      | LLATaskInterrupt[0]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.LLATaskInterrupt(:,2) = AL13(:,5);           %   4. | LL1      | LLATaskInterrupt[1]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.LLATaskInterrupt(:,3) = AL13(:,6);           %   5. | LL2      | LLATaskInterrupt[2]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.isTaskComplete = AL13(:,7);                  %   6. | comp     | isTaskComplete                 | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.numTakeOff = AL13(:,8);                      %   7. | take     | numTakeOff                     | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.isHeadingRotate_OnGround = AL13(:,9);        %   8. | onGd     | isHeadingRotate_OnGround       | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.isAllowedToPause = AL13(:,10);               %   9. | isPause  | isAllowedToPause               | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.lastTargetPathPoint = AL13(:,11);            %  10. | lPt      | lastTargetPathPoint            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.uavMode = AL13(:,12);                        %  11. | Mod      | uavMode                        | [U8]  | [12:12]    | 
V10Log.OUT_TASKMODE.Sum = AL13(:,13);                            %  12. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL14
try
V10Log.OUT_TASKFLIGHTPARAM.TimeUS = AL14(:,2);                   %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curHomeLLA(:,1) = AL14(:,3);          %   2. | LL0      | curHomeLLA[0]                  | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curHomeLLA(:,2) = AL14(:,4);          %   3. | LL1      | curHomeLLA[1]                  | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curHomeLLA(:,3) = AL14(:,5);          %   4. | LL2      | curHomeLLA[2]                  | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curVelNED(:,1) = AL14(:,6);           %   5. | ND0      | curVelNED[0]                   | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curVelNED(:,2) = AL14(:,7);           %   6. | ND1      | curVelNED[1]                   | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curVelNED(:,3) = AL14(:,8);           %   7. | ND2      | curVelNED[2]                   | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curSpeed = AL14(:,9);                 %   8. | aspd     | curSpeed                       | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curAirSpeed = AL14(:,10);             %   9. | caspd    | curAirSpeed                    | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curEuler(:,1) = AL14(:,11);           %  10. | Eul0     | curEuler[0]                    | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curEuler(:,2) = AL14(:,12);           %  11. | Eul1     | curEuler[1]                    | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curEuler(:,3) = AL14(:,13);           %  12. | Eul2     | curEuler[2]                    | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.Sum = AL14(:,14);                     %  13. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL15
try
V10Log.OUT_TASKFLIGHTPARAM.TimeUS = AL15(:,2);                   %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curWB(:,1) = AL15(:,3);               %   2. | WB0      | curWB[0]                       | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curWB(:,2) = AL15(:,4);               %   3. | WB1      | curWB[1]                       | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curWB(:,3) = AL15(:,5);               %   4. | WB2      | curWB[2]                       | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curPosNED(:,1) = AL15(:,6);           %   5. | ND0      | curPosNED[0]                   | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curPosNED(:,2) = AL15(:,7);           %   6. | ND1      | curPosNED[1]                   | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curPosNED(:,3) = AL15(:,8);           %   7. | ND2      | curPosNED[2]                   | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curLLA(:,1) = AL15(:,9);              %   8. | LL0      | curLLA[0]                      | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curLLA(:,2) = AL15(:,10);             %   9. | LL1      | curLLA[1]                      | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curLLA(:,3) = AL15(:,11);             %  10. | LL2      | curLLA[2]                      | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curGroundSpeed = AL15(:,12);          %  11. | gspd     | curGroundSpeed                 | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curAccZ = AL15(:,13);                 %  12. | cAcz     | curAccZ                        | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.Sum = AL15(:,14);                     %  13. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL16
try
V10Log.OUT_TASKFLIGHTPARAM.TimeUS = AL16(:,2);                   %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,1) = AL16(:,3);       %   2. | LL0      | groundHomeLLA[0]               | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,2) = AL16(:,4);       %   3. | LL1      | groundHomeLLA[1]               | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,3) = AL16(:,5);       %   4. | LL2      | groundHomeLLA[2]               | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curHeightForControl = AL16(:,6);      %   5. | ctl      | curHeightForControl            | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.isNavFilterGood = AL16(:,7);          %   6. | good     | isNavFilterGood                | [U8]  | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.uavModel = AL16(:,8);                 %   7. | mod      | uavModel                       | [U8]  | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.Sum = AL16(:,9);                      %   8. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL17
try
V10Log.OUT_FLIGHTPERF.TimeUS = AL17(:,2);                        %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_FLIGHTPERF.isAbleToCompleteTask = AL17(:,3);          %   2. | cmp      | isAbleToCompleteTask           | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.flagGoHomeNow = AL17(:,4);                 %   3. | ghm      | flagGoHomeNow                  | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.remainDistToGo_m = AL17(:,5);              %   4. | rdis     | remainDistToGo_m               | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.remainTimeToSpend_sec = AL17(:,6);         %   5. | rtm      | remainTimeToSpend_sec          | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.remainPowerWhenFinish_per = AL17(:,7);     %   6. | rpw      | remainPowerWhenFinish_per      | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.economicAirspeed = AL17(:,8);              %   7. | espd     | economicAirspeed               | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.remainPathPoint = AL17(:,9);               %   8. | rpnt     | remainPathPoint                | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.batteryLifeToCompleteTask = AL17(:,10);    %   9. | bcmp     | batteryLifeToCompleteTask      | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.batterylifeNeededToHome = AL17(:,11);      %  10. | bthm     | batterylifeNeededToHome        | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.batterylifeNeededToLand = AL17(:,12);      %  11. | btL      | batterylifeNeededToLand        | [F]   | [12:12]    | 
V10Log.OUT_FLIGHTPERF.Sum = AL17(:,13);                          %  12. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL18
try
V10Log.Debug_Task_RTInfo.TimeUS = AL18(:,2);                     %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_Task_RTInfo.Task = AL18(:,3);                       %   2. | tsk      | Task                           | [U16] | [12:12]    | 
V10Log.Debug_Task_RTInfo.Payload = AL18(:,4);                    %   3. | pld      | Payload                        | [U16] | [12:12]    | 
V10Log.Debug_Task_RTInfo.GSCmd = AL18(:,5);                      %   4. | GSd      | GSCmd                          | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.Warning = AL18(:,6);                    %   5. | Wrn      | Warning                        | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.ComStatus = AL18(:,7);                  %   6. | Com      | ComStatus                      | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.FenseStatus = AL18(:,8);                %   7. | Fen      | FenseStatus                    | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.StallStatus = AL18(:,9);                %   8. | Stl      | StallStatus                    | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.SensorStatus = AL18(:,10);              %   9. | Sen      | SensorStatus                   | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.BatteryStatus = AL18(:,11);             %  10. | Bat      | BatteryStatus                  | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.FixWingHeightStatus = AL18(:,12);       %  11. | Fix      | FixWingHeightStatus            | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.FindWind = AL18(:,13);                  %  12. | Fin      | FindWind                       | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.LandCond1_Acc_H = AL18(:,14);           %  13. | LAc      | LandCond1_Acc_H                | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.LandCond1_Vd_H = AL18(:,15);            %  14. | LVd      | LandCond1_Vd_H                 | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.Sum = AL18(:,16);                       %  15. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL19
try
V10Log.Debug_Task_RTInfo.TimeUS = AL19(:,2);                     %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_Task_RTInfo.LandCond3_near = AL19(:,3);             %   2. | L3n      | LandCond3_near                 | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.maxDist_Path2Home = AL19(:,4);          %   3. | hom      | maxDist_Path2Home              | [F]   | [12:12]    | 
V10Log.Debug_Task_RTInfo.realtimeFenseDist = AL19(:,5);          %   4. | dist     | realtimeFenseDist              | [F]   | [12:12]    | 
V10Log.Debug_Task_RTInfo.Sum = AL19(:,6);                        %   5. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL20
try
V10Log.Debug_WindParam.TimeUS = AL20(:,2);                       %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_WindParam.sailWindSpeed = AL20(:,3);                %   2. | wspd     | sailWindSpeed                  | [F]   | [12:12]    | 
V10Log.Debug_WindParam.sailWindHeading = AL20(:,4);              %   3. | swhd     | sailWindHeading                | [F]   | [12:12]    | 
V10Log.Debug_WindParam.windSpeedMax = AL20(:,5);                 %   4. | wmx      | windSpeedMax                   | [F]   | [12:12]    | 
V10Log.Debug_WindParam.windSpeedMin = AL20(:,6);                 %   5. | wmn      | windSpeedMin                   | [F]   | [12:12]    | 
V10Log.Debug_WindParam.maxWindHeading = AL20(:,7);               %   6. | mwhd     | maxWindHeading                 | [F]   | [12:12]    | 
V10Log.Debug_WindParam.Sum = AL20(:,8);                          %   7. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL21
try
V10Log.GlobalWindEst.TimeUS = AL21(:,2);                         %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.GlobalWindEst.oneCircleComplete = AL21(:,3);              %   2. | comp     | oneCircleComplete              | [F]   | [12:12]    | 
V10Log.GlobalWindEst.windSpeed_ms = AL21(:,4);                   %   3. | wspd     | windSpeed_ms                   | [F]   | [12:12]    | 
V10Log.GlobalWindEst.windHeading_rad = AL21(:,5);                %   4. | whrd     | windHeading_rad                | [F]   | [12:12]    | 
V10Log.GlobalWindEst.Sum = AL21(:,6);                            %   5. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL22
try
V10Log.Debug_TaskLogData.TimeUS = AL22(:,2);                     %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_TaskLogData.time_sec = AL22(:,3);                   %   2. | time     | time_sec                       | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.blockName = AL22(:,4);                  %   3. | name     | blockName                      | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.idx = AL22(:,5);                        %   4. | idx      | idx                            | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.message = AL22(:,6);                    %   5. | msg      | message                        | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.var1(:,1) = AL22(:,7);                  %   6. | var0     | var1[0]                        | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.var1(:,2) = AL22(:,8);                  %   7. | var1     | var1[1]                        | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.var1(:,3) = AL22(:,9);                  %   8. | var2     | var1[2]                        | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.var1(:,4) = AL22(:,10);                 %   9. | var3     | var1[3]                        | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.var1(:,5) = AL22(:,11);                 %  10. | var4     | var1[4]                        | [F]   | [12:12]    | 
V10Log.Debug_TaskLogData.Sum = AL22(:,12);                       %  11. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL23
try
V10Log.Debug_GroundStationShow.TimeUS = AL23(:,2);               %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_GroundStationShow.windSpeed_ms = AL23(:,3);         %   2. | wspd     | windSpeed_ms                   | [F]   | [12:12]    | 
V10Log.Debug_GroundStationShow.groundSpeed_ms = AL23(:,4);       %   3. | gspd     | groundSpeed_ms                 | [F]   | [12:12]    | 
V10Log.Debug_GroundStationShow.Sum = AL23(:,5);                  %   4. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL25
try
V10Log.Simulation_TaskAlgoParam.TimeUS = AL25(:,2);              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Simulation_TaskAlgoParam.isHoverDownToCenter = AL25(:,3); %   2. | hov      | isHoverDownToCenter            | [F]   | [12:12]    | 
V10Log.Simulation_TaskAlgoParam.runSingleTaskMode = AL25(:,4);   %   3. | mode     | runSingleTaskMode              | [F]   | [12:12]    | 
V10Log.Simulation_TaskAlgoParam.Sum = AL25(:,5);                 %   4. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL26
try
V10Log.OUT_NAVI2CONTROL.TimeUS = AL26(:,2);                      %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.yawd = AL26(:,3);                        %   2. | yad      | yawd                           | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.pitchd = AL26(:,4);                      %   3. | phd      | pitchd                         | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.rolld = AL26(:,5);                       %   4. | rod      | rolld                          | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.latd = AL26(:,6);                        %   5. | lad      | latd                           | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.lond = AL26(:,7);                        %   6. | lod      | lond                           | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.alt = AL26(:,8);                         %   7. | alt      | alt                            | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.Vn = AL26(:,9);                          %   8. | Vn       | Vn                             | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.Ve = AL26(:,10);                         %   9. | Ve       | Ve                             | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.Vd = AL26(:,11);                         %  10. | Vd       | Vd                             | [F]   | [12:12]    | 
V10Log.OUT_NAVI2CONTROL.Sum = AL26(:,12);                        %  11. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL27
try
V10Log.SystemHealthStatus.TimeUS = AL27(:,2);                    %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SystemHealthStatus.SystemHealthStatus = AL27(:,3);        %   2. | Health   | SystemHealthStatus             | [F]   | [12:12]    | 
V10Log.SystemHealthStatus.Sum = AL27(:,4);                       %   3. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL28
try
V10Log.Status.TimeUS = AL28(:,2);                                %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Status.isNavFilterGood = AL28(:,3);                       %   2. | good     | isNavFilterGood                | [U8]  | [12:12]    | 
V10Log.Status.Sum = AL28(:,4);                                   %   3. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL29
try
V10Log.OUT_SYSTEMINFO.TimeUS = AL29(:,2);                        %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_SYSTEMINFO.uavModel = AL29(:,3);                      %   2. | modl     | uavModel                       | [U8]  | [12:12]    | 
V10Log.OUT_SYSTEMINFO.Sum = AL29(:,4);                           %   3. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL31
try
V10Log.nChange1.TimeUS = AL31(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.nChange1.IMU1_Control_nChange = AL31(:,3);                %   2. | imc1     | IMU1_Control_nChange           | [U8]  | [12:12]    | 
V10Log.nChange1.IMU1_nChange = AL31(:,4);                        %   3. | im1      | IMU1_nChange                   | [U8]  | [12:12]    | 
V10Log.nChange1.IMU2_nChange = AL31(:,5);                        %   4. | im2      | IMU2_nChange                   | [U8]  | [12:12]    | 
V10Log.nChange1.IMU3_nChange = AL31(:,6);                        %   5. | im3      | IMU3_nChange                   | [U8]  | [12:12]    | 
V10Log.nChange1.IMU4_nChange = AL31(:,7);                        %   6. | im4      | IMU4_nChange                   | [U8]  | [12:12]    | 
V10Log.nChange1.airspeed1_nChange = AL31(:,8);                   %   7. | ar1      | airspeed1_nChange              | [U8]  | [12:12]    | 
V10Log.nChange1.airspeed2_nChange = AL31(:,9);                   %   8. | ar2      | airspeed2_nChange              | [U8]  | [12:12]    | 
V10Log.nChange1.mag1_nChange = AL31(:,10);                       %   9. | mg1      | mag1_nChange                   | [U8]  | [12:12]    | 
V10Log.nChange1.mag2_nChange = AL31(:,11);                       %  10. | mg2      | mag2_nChange                   | [U8]  | [12:12]    | 
V10Log.nChange1.baro1_nChange = AL31(:,12);                      %  11. | br1      | baro1_nChange                  | [U8]  | [12:12]    | 
V10Log.nChange1.baro2_nChange = AL31(:,13);                      %  12. | br2      | baro2_nChange                  | [U8]  | [12:12]    | 
V10Log.nChange1.laserDown1_nChange = AL31(:,14);                 %  13. | la1      | laserDown1_nChange             | [U8]  | [12:12]    | 
V10Log.nChange1.laserDown2_nChange = AL31(:,15);                 %  14. | la2      | laserDown2_nChange             | [U8]  | [12:12]    | 
V10Log.nChange1.um482_nChange = AL31(:,16);                      %  15. | gps      | um482_nChange                  | [U8]  | [12:12]    | 
V10Log.nChange1.Sum = AL31(:,17);                                %  16. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
%% AL32
try
V10Log.nChange2.TimeUS = AL32(:,2);                              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.nChange2.ublox1_nChange = AL32(:,3);                      %   2. | ubx      | ublox1_nChange                 | [U8]  | [12:12]    | 
V10Log.nChange2.radar1_nChange = AL32(:,4);                      %   3. | nra15    | radar1_nChange                 | [U8]  | [12:12]    | 
V10Log.nChange2.Sum = AL32(:,5);                                 %   4. | Sm       | Sum                            | [U8]  | [12:12]    | 
catch ME
	disp(ME.message);
end
