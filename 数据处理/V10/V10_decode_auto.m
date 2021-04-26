function V10Log = V10_decode_auto(logFile)
% example: V10Log = V10_decode_auto('ÿÿÿÿ.bin-5181860.mat')
% computer name: DESKTOP-QLU0EFU
% generate date: 25-Apr-2021
% Matlab version: 9.9.0.1467703 (R2020b)
% protocol file: V10_v20210416_11.txt
% data file: ÿÿÿÿ.bin-5181860.mat
% logFile: .mat log file
load(logFile);
%% ARP1
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
%% ARP2
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
%% MAG1
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
%% MAG2
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
%% MGC1
V10Log.MGC1.TimeUS = MGC1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.MGC1.A(:,1) = MGC1(:,3);                                  %   2. | A0       | A[0]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,2) = MGC1(:,4);                                  %   3. | A1       | A[1]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,3) = MGC1(:,5);                                  %   4. | A2       | A[2]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,4) = MGC1(:,6);                                  %   5. | A3       | A[3]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,5) = MGC1(:,7);                                  %   6. | A4       | A[4]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,6) = MGC1(:,8);                                  %   7. | A5       | A[5]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,7) = MGC1(:,9);                                  %   8. | A6       | A[6]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,8) = MGC1(:,10);                                 %   9. | A7       | A[7]                           | [F]   | [10:10]    | 
V10Log.MGC1.A(:,9) = MGC1(:,11);                                 %  10. | A8       | A[8]                           | [F]   | [10:10]    | 
V10Log.MGC1.B(:,1) = MGC1(:,12);                                 %  11. | B0       | B[0]                           | [F]   | [10:10]    | 
V10Log.MGC1.B(:,2) = MGC1(:,13);                                 %  12. | B1       | B[1]                           | [F]   | [10:10]    | 
V10Log.MGC1.B(:,3) = MGC1(:,14);                                 %  13. | B2       | B[2]                           | [F]   | [10:10]    | 
V10Log.MGC1.K = MGC1(:,15);                                      %  14. | K        | K                              | [F]   | [10:10]    | 
V10Log.MGC1.Sum = MGC1(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [10:10]    | 
%% MGC2
V10Log.MGC2.TimeUS = MGC2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.MGC2.A(:,1) = MGC2(:,3);                                  %   2. | A0       | A[0]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,2) = MGC2(:,4);                                  %   3. | A1       | A[1]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,3) = MGC2(:,5);                                  %   4. | A2       | A[2]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,4) = MGC2(:,6);                                  %   5. | A3       | A[3]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,5) = MGC2(:,7);                                  %   6. | A4       | A[4]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,6) = MGC2(:,8);                                  %   7. | A5       | A[5]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,7) = MGC2(:,9);                                  %   8. | A6       | A[6]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,8) = MGC2(:,10);                                 %   9. | A7       | A[7]                           | [F]   | [10:10]    | 
V10Log.MGC2.A(:,9) = MGC2(:,11);                                 %  10. | A8       | A[8]                           | [F]   | [10:10]    | 
V10Log.MGC2.B(:,1) = MGC2(:,12);                                 %  11. | B0       | B[0]                           | [F]   | [10:10]    | 
V10Log.MGC2.B(:,2) = MGC2(:,13);                                 %  12. | B1       | B[1]                           | [F]   | [10:10]    | 
V10Log.MGC2.B(:,3) = MGC2(:,14);                                 %  13. | B2       | B[2]                           | [F]   | [10:10]    | 
V10Log.MGC2.K = MGC2(:,15);                                      %  14. | K        | K                              | [F]   | [10:10]    | 
V10Log.MGC2.Sum = MGC2(:,16);                                    %  15. | Sum      | Sum                            | [U8]  | [10:10]    | 
%% BAR1
V10Log.BAR1.TimeUS = BAR1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.BAR1.ground_pressure = BAR1(:,3);                         %   2. | gP       | ground_pressure                | [F]   | [10:10]    | 
V10Log.BAR1.ground_temperature = BAR1(:,4);                      %   3. | gT       | ground_temperature             | [F]   | [10:10]    | 
V10Log.BAR1.pressure = BAR1(:,5);                                %   4. | pres     | pressure                       | [F]   | [10:10]    | 
V10Log.BAR1.altitude = BAR1(:,6);                                %   5. | alt      | altitude                       | [F]   | [10:10]    | 
V10Log.BAR1.temperature = BAR1(:,7);                             %   6. | temp     | temperature                    | [F]   | [10:10]    | 
V10Log.BAR1.Sum = BAR1(:,9);                                     %   7. | Sum      | Sum                            | [U8]  | [10:10]    | 
%% BAR2
V10Log.BAR2.TimeUS = BAR2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [10:10]    | 
V10Log.BAR2.ground_pressure = BAR2(:,3);                         %   2. | gP       | ground_pressure                | [F]   | [10:10]    | 
V10Log.BAR2.ground_temperature = BAR2(:,4);                      %   3. | gT       | ground_temperature             | [F]   | [10:10]    | 
V10Log.BAR2.pressure = BAR2(:,5);                                %   4. | pres     | pressure                       | [F]   | [10:10]    | 
V10Log.BAR2.altitude = BAR2(:,6);                                %   5. | alt      | altitude                       | [F]   | [10:10]    | 
V10Log.BAR2.temperature = BAR2(:,7);                             %   6. | temp     | temperature                    | [F]   | [10:10]    | 
V10Log.BAR2.Sum = BAR2(:,9);                                     %   7. | Sum      | Sum                            | [U8]  | [10:10]    | 
%% NRA
V10Log.NRA.TimeUS = NRA(:,2);                                    %   1. | TimeUS   | TimeUS                         | [U32] | [20:10]    | 
V10Log.NRA.lost_count = NRA(:,3);                                %   2. | lcnt     | lost_count                     | [U32] | [20:10]    | 
V10Log.NRA.Range = NRA(:,4);                                     %   3. | range    | Range                          | [F]   | [20:10]    | 
V10Log.NRA.Flag = NRA(:,5);                                      %   4. | flag     | Flag                           | [U8]  | [20:10]    | 
V10Log.NRA.SNR = NRA(:,6);                                       %   5. | snr      | SNR                            | [U8]  | [20:10]    | 
V10Log.NRA.Rcs = NRA(:,7);                                       %   6. | rcs      | Rcs                            | [U8]  | [20:10]    | 
V10Log.NRA.Sum = NRA(:,8);                                       %   7. | Sum      | Sum                            | [U8]  | [20:10]    | 
%% IMU1
V10Log.IMU1.TimeUS = IMU1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMU1.ax = IMU1(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMU1.ay = IMU1(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMU1.az = IMU1(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMU1.gx = IMU1(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMU1.gy = IMU1(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMU1.gz = IMU1(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMU1.temperature = IMU1(:,9);                             %   8. | temp     | temperature                    | [F]   | [1:4]      | 
V10Log.IMU1.temp_pwm = IMU1(:,11);                               %   9. | pwm      | temp_pwm                       | [F]   | [1:4]      | 
%% IMF1
V10Log.IMF1.TimeUS = IMF1(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF1.ax = IMF1(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF1.ay = IMF1(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF1.az = IMF1(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF1.gx = IMF1(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF1.gy = IMF1(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF1.gz = IMF1(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF1.Sum = IMF1(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
%% IMF5
V10Log.IMF5.TimeUS = IMF5(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF5.ax = IMF5(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF5.ay = IMF5(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF5.az = IMF5(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF5.gx = IMF5(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF5.gy = IMF5(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF5.gz = IMF5(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF5.Sum = IMF5(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
%% IMF6
V10Log.IMF6.TimeUS = IMF6(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF6.ax = IMF6(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF6.ay = IMF6(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF6.az = IMF6(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF6.gx = IMF6(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF6.gy = IMF6(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF6.gz = IMF6(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF6.Sum = IMF6(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
%% IMF7
V10Log.IMF7.TimeUS = IMF7(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF7.ax = IMF7(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF7.ay = IMF7(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF7.az = IMF7(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF7.gx = IMF7(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF7.gy = IMF7(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF7.gz = IMF7(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF7.Sum = IMF7(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
%% IMF8
V10Log.IMF8.TimeUS = IMF8(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [1:4]      | 
V10Log.IMF8.ax = IMF8(:,3);                                      %   2. | ax       | ax                             | [F]   | [1:4]      | 
V10Log.IMF8.ay = IMF8(:,4);                                      %   3. | ay       | ay                             | [F]   | [1:4]      | 
V10Log.IMF8.az = IMF8(:,5);                                      %   4. | az       | az                             | [F]   | [1:4]      | 
V10Log.IMF8.gx = IMF8(:,6);                                      %   5. | gx       | gx                             | [F]   | [1:4]      | 
V10Log.IMF8.gy = IMF8(:,7);                                      %   6. | gy       | gy                             | [F]   | [1:4]      | 
V10Log.IMF8.gz = IMF8(:,8);                                      %   7. | gz       | gz                             | [F]   | [1:4]      | 
V10Log.IMF8.Sum = IMF8(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [1:4]      | 
%% GPS
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
%% GPSE
V10Log.GPSE.TimeUS = GPSE(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [50:50]    | 
V10Log.GPSE.decode_error_cnt = GPSE(:,13);                       %   2. | err1     | decode_error_cnt               | [U8]  | [50:50]    | 
V10Log.GPSE.decode_crc_error_cnt = GPSE(:,14);                   %   3. | err2     | decode_crc_error_cnt           | [U8]  | [50:50]    | 
V10Log.GPSE.decode_psrdop_cnt = GPSE(:,15);                      %   4. | err3     | decode_psrdop_cnt              | [U8]  | [50:50]    | 
V10Log.GPSE.oem718d_decode_status = GPSE(:,16);                  %   5. | err4     | oem718d_decode_status          | [U8]  | [50:50]    | 
%% UBX
V10Log.UBX.TimeUS = UBX(:,2);                                    %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
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
V10Log.UBX.Sum = UBX(:,15);                                      %  14. | Sum      | Sum                            | [U8]  | [100:100]  | 
%% UBXE
V10Log.UBXE.TimeUS = UBXE(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.UBXE.decode_error_cnt = UBXE(:,3);                        %   2. | err1     | decode_error_cnt               | [U8]  | [100:100]  | 
V10Log.UBXE.decode_crc_error_cnt = UBXE(:,4);                    %   3. | err2     | decode_crc_error_cnt           | [U8]  | [100:100]  | 
V10Log.UBXE.decode_psrdop_cnt = UBXE(:,5);                       %   4. | err3     | decode_psrdop_cnt              | [U8]  | [100:100]  | 
V10Log.UBXE.nak_error = UBXE(:,6);                               %   5. | err4     | nak_error                      | [U8]  | [100:100]  | 
V10Log.UBXE.Sum = UBXE(:,7);                                     %   6. | Sum      | Sum                            | [U8]  | [100:100]  | 
%% RCIN
V10Log.RCIN.TimeUS = RCIN(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [7:7]      | 
V10Log.RCIN.frame_lost_cnt = RCIN(:,3);                          %   2. | LCNT     | frame_lost_cnt                 | [U32] | [7:7]      | 
V10Log.RCIN.channel_1_roll = RCIN(:,4);                          %   3. | C1       | channel_1_roll                 | [U16] | [7:7]      | 
V10Log.RCIN.channel_2_pitch = RCIN(:,5);                         %   4. | C2       | channel_2_pitch                | [U16] | [7:7]      | 
V10Log.RCIN.channel_3_throttle = RCIN(:,6);                      %   5. | C3       | channel_3_throttle             | [U16] | [7:7]      | 
V10Log.RCIN.channel_4_yaw = RCIN(:,7);                           %   6. | C4       | channel_4_yaw                  | [U16] | [7:7]      | 
V10Log.RCIN.channel_5_Auto = RCIN(:,8);                          %   7. | C5       | channel_5_Auto                 | [U16] | [7:7]      | 
V10Log.RCIN.channel_6_tilt = RCIN(:,9);                          %   8. | C6       | channel_6_tilt                 | [U16] | [7:7]      | 
V10Log.RCIN.channel_7_D = RCIN(:,10);                            %   9. | C7       | channel_7_D                    | [U16] | [7:7]      | 
V10Log.RCIN.channel_8_C = RCIN(:,11);                            %  10. | C8       | channel_8_C                    | [U16] | [7:7]      | 
V10Log.RCIN.channel_9_Lock = RCIN(:,12);                         %  11. | C9       | channel_9_Lock                 | [U16] | [7:7]      | 
V10Log.RCIN.channel_F = RCIN(:,13);                              %  12. | C10      | channel_F                      | [U16] | [7:7]      | 
V10Log.RCIN.Sum = RCIN(:,14);                                    %  13. | Sum      | Sum                            | [U8]  | [7:7]      | 
%% PWMO
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
%% MCMD
V10Log.MCMD.TimeUS = MCMD(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.MCMD.log_exe_time = MCMD(:,3);                            %   2. | exe      | log_exe_time                   | [U32] | [100:100]  | 
V10Log.MCMD.test_send_cnt(:,1) = MCMD(:,4);                      %   3. | cnt0     | test_send_cnt[0]               | [U32] | [100:100]  | 
V10Log.MCMD.test_send_cnt(:,2) = MCMD(:,5);                      %   4. | cnt1     | test_send_cnt[1]               | [U32] | [100:100]  | 
V10Log.MCMD.Sum = MCMD(:,6);                                     %   5. | Sum      | Sum                            | [U8]  | [100:100]  | 
%% ECS1
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
%% ECS2
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
%% LASE
V10Log.LASE.TimeUS = LASE(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:100]  | 
V10Log.LASE.laser1_valid = LASE(:,3);                            %   2. | l1_valid | laser1_valid                   | [U8]  | [100:100]  | 
V10Log.LASE.laser1_distance = LASE(:,4);                         %   3. | l1_data  | laser1_distance                | [U16] | [100:100]  | 
V10Log.LASE.laser2_valid = LASE(:,5);                            %   4. | l2_valid | laser2_valid                   | [U8]  | [100:100]  | 
V10Log.LASE.laser2_distance = LASE(:,6);                         %   5. | l2_data  | laser2_distance                | [U16] | [100:100]  | 
V10Log.LASE.laser_flag = LASE(:,7);                              %   6. | flag     | laser_flag                     | [U8]  | [100:100]  | 
V10Log.LASE.Sum = LASE(:,8);                                     %   7. | Sum      | Sum                            | [U8]  | [100:100]  | 
%% ALG0
V10Log.ALG0.TimeUS = ALG0(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:96]   | 
V10Log.ALG0.FC_Version = ALG0(:,3);                              %   2. | FcV      | FC_Version                     | [U16] | [100:96]   | 
V10Log.ALG0.Logic_Version = ALG0(:,4);                           %   3. | LogicV   | Logic_Version                  | [U16] | [100:96]   | 
V10Log.ALG0.Driver_Version = ALG0(:,5);                          %   4. | DriV     | Driver_Version                 | [U16] | [100:96]   | 
V10Log.ALG0.reset_status = ALG0(:,6);                            %   5. | Rst      | reset_status                   | [U16] | [100:96]   | 
V10Log.ALG0.Sum = ALG0(:,7);                                     %   6. | Sum      | Sum                            | [U8]  | [100:96]   | 
%% ALG1
V10Log.ALG1.TimeUS = ALG1(:,3);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [100:96]   | 
V10Log.ALG1.time_algo_imu = ALG1(:,4);                           %   2. | tImu     | time_algo_imu                  | [U32] | [100:96]   | 
V10Log.ALG1.time_algo_pwm = ALG1(:,5);                           %   3. | tPwm     | time_algo_pwm                  | [U32] | [100:96]   | 
V10Log.ALG1.time_algo_exe = ALG1(:,7);                           %   4. | tExe     | time_algo_exe                  | [U32] | [100:96]   | 
V10Log.ALG1.remote_lock = ALG1(:,8);                             %   5. | rk       | remote_lock                    | [U8]  | [100:96]   | 
V10Log.ALG1.switch_lock_0 = ALG1(:,9);                           %   6. | sw0      | switch_lock_0                  | [U8]  | [100:96]   | 
V10Log.ALG1.switch_lock_1 = ALG1(:,10);                          %   7. | sw1      | switch_lock_1                  | [U8]  | [100:96]   | 
V10Log.ALG1.ground_station_lock = ALG1(:,11);                    %   8. | gsk      | ground_station_lock            | [U8]  | [100:96]   | 
V10Log.ALG1.extend_lock_status = ALG1(:,12);                     %   9. | ek       | extend_lock_status             | [U8]  | [100:96]   | 
V10Log.ALG1.fc_simulation = ALG1(:,13);                          %  10. | simu     | fc_simulation                  | [U8]  | [100:96]   | 
V10Log.ALG1.ground_station_connect = ALG1(:,14);                 %  11. | gsc      | ground_station_connect         | [U8]  | [100:96]   | 
V10Log.ALG1.ground_station_timeout = ALG1(:,16);                 %  12. | gst      | ground_station_timeout         | [U16] | [100:96]   | 
V10Log.ALG1.ground_station_count = ALG1(:,17);                   %  13. | gscn     | ground_station_count           | [U16] | [100:96]   | 
%% ALG2
V10Log.ALG2.TimeUS = ALG2(:,2);                                  %   1. | TimeUS   | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALG2.exe_time = ALG2(:,3);                                %   2. | exe      | exe_time                       | [U32] | [12:12]    | 
V10Log.ALG2.algo_remot_roll = ALG2(:,4);                         %   3. | rol      | algo_remot_roll                | [F]   | [12:12]    | 
V10Log.ALG2.algo_remot_pitch = ALG2(:,5);                        %   4. | pit      | algo_remot_pitch               | [F]   | [12:12]    | 
V10Log.ALG2.algo_remot_yaw = ALG2(:,6);                          %   5. | yaw      | algo_remot_yaw                 | [F]   | [12:12]    | 
V10Log.ALG2.algo_remot_throttle = ALG2(:,7);                     %   6. | thr      | algo_remot_throttle            | [F]   | [12:12]    | 
V10Log.ALG2.algo_remot_tilt_angle_in = ALG2(:,8);                %   7. | tilt     | algo_remot_tilt_angle_in       | [F]   | [12:12]    | 
V10Log.ALG2.Sum = ALG2(:,9);                                     %   8. | Sum      | Sum                            | [U8]  | [12:12]    | 
%% ALD1
V10Log.ALD1.TimeUS = ALD1(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD1.time_log = ALD1(:,3);                                %   2. | time     | time_log                       | [U32] | [12:12]    | 
V10Log.ALD1.time_exe = ALD1(:,4);                                %   3. | exe      | time_exe                       | [U32] | [12:12]    | 
V10Log.ALD1.mode = ALD1(:,5);                                    %   4. | mode     | mode                           | [U8]  | [12:12]    | 
V10Log.ALD1.palne_mode = ALD1(:,6);                              %   5. | plmod    | palne_mode                     | [U8]  | [12:12]    | 
V10Log.ALD1.flightTaskMode = ALD1(:,7);                          %   6. | fmod     | flightTaskMode                 | [U8]  | [12:12]    | 
V10Log.ALD1.PathMode = ALD1(:,8);                                %   7. | ptmod    | PathMode                       | [U8]  | [12:12]    | 
V10Log.ALD1.limit_pos_up = ALD1(:,9);                            %   8. | posup    | limit_pos_up                   | [U8]  | [12:12]    | 
V10Log.ALD1.throttle_upper = ALD1(:,10);                         %   9. | thup     | throttle_upper                 | [U8]  | [12:12]    | 
V10Log.ALD1.throttle_lower = ALD1(:,11);                         %  10. | thlo     | throttle_lower                 | [U8]  | [12:12]    | 
V10Log.ALD1.Sum = ALD1(:,12);                                    %  11. | Sum      | Sum                            | [U8]  | [12:12]    | 
%% ALD2
V10Log.ALD2.TimeUS = ALD2(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD2.roll = ALD2(:,3);                                    %   2. | rol      | roll                           | [F]   | [12:12]    | 
V10Log.ALD2.pitch = ALD2(:,4);                                   %   3. | pit      | pitch                          | [F]   | [12:12]    | 
V10Log.ALD2.yaw = ALD2(:,5);                                     %   4. | yaw      | yaw                            | [F]   | [12:12]    | 
V10Log.ALD2.roll_in = ALD2(:,6);                                 %   5. | rin      | roll_in                        | [F]   | [12:12]    | 
V10Log.ALD2.pitch_in = ALD2(:,7);                                %   6. | pin      | pitch_in                       | [F]   | [12:12]    | 
V10Log.ALD2.yaw_in = ALD2(:,8);                                  %   7. | yin      | yaw_in                         | [F]   | [12:12]    | 
V10Log.ALD2.throttle_in = ALD2(:,9);                             %   8. | tin      | throttle_in                    | [F]   | [12:12]    | 
V10Log.ALD2.pwm_out(:,1) = ALD2(:,10);                           %   9. | pw0      | pwm_out[0]                     | [F]   | [12:12]    | 
V10Log.ALD2.pwm_out(:,2) = ALD2(:,11);                           %  10. | pw1      | pwm_out[1]                     | [F]   | [12:12]    | 
V10Log.ALD2.pwm_out(:,3) = ALD2(:,12);                           %  11. | pw2      | pwm_out[2]                     | [F]   | [12:12]    | 
V10Log.ALD2.pwm_out(:,4) = ALD2(:,13);                           %  12. | pw3      | pwm_out[3]                     | [F]   | [12:12]    | 
V10Log.ALD2.tail_tilt = ALD2(:,14);                              %  13. | til      | tail_tilt                      | [F]   | [12:12]    | 
V10Log.ALD2.pwm_tail = ALD2(:,15);                               %  14. | pwm      | pwm_tail                       | [F]   | [12:12]    | 
V10Log.ALD2.Sum = ALD2(:,16);                                    %  15. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALD3
V10Log.ALD3.TimeUS = ALD3(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD3.yaw_out = ALD3(:,3);                                 %   2. | yout     | yaw_out                        | [F]   | [12:12]    | 
V10Log.ALD3.k_flap = ALD3(:,4);                                  %   3. | flap     | k_flap                         | [F]   | [12:12]    | 
V10Log.ALD3.current_loc(:,1) = ALD3(:,5);                        %   4. | cl0      | current_loc[0]                 | [F]   | [12:12]    | 
V10Log.ALD3.current_loc(:,2) = ALD3(:,6);                        %   5. | cl1      | current_loc[1]                 | [F]   | [12:12]    | 
V10Log.ALD3.curr_vel(:,1) = ALD3(:,7);                           %   6. | cv0      | curr_vel[0]                    | [F]   | [12:12]    | 
V10Log.ALD3.curr_vel(:,2) = ALD3(:,8);                           %   7. | cv1      | curr_vel[1]                    | [F]   | [12:12]    | 
V10Log.ALD3.curr_vel(:,3) = ALD3(:,9);                           %   8. | cv2      | curr_vel[2]                    | [F]   | [12:12]    | 
V10Log.ALD3.curr_pos(:,1) = ALD3(:,10);                          %   9. | cp0      | curr_pos[0]                    | [F]   | [12:12]    | 
V10Log.ALD3.curr_pos(:,2) = ALD3(:,11);                          %  10. | cp1      | curr_pos[1]                    | [F]   | [12:12]    | 
V10Log.ALD3.rate_target_ang_vel(:,1) = ALD3(:,12);               %  11. | rvl0     | rate_target_ang_vel[0]         | [F]   | [12:12]    | 
V10Log.ALD3.rate_target_ang_vel(:,2) = ALD3(:,13);               %  12. | rvl1     | rate_target_ang_vel[1]         | [F]   | [12:12]    | 
V10Log.ALD3.rate_target_ang_vel(:,3) = ALD3(:,14);               %  13. | rvl2     | rate_target_ang_vel[2]         | [F]   | [12:12]    | 
V10Log.ALD3.Sum = ALD3(:,15);                                    %  14. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALD4
V10Log.ALD4.TimeUS = ALD4(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD4.attitude_target_euler_rate(:,1) = ALD4(:,3);         %   2. | er0      | attitude_target_euler_rate[0]  | [F]   | [12:12]    | 
V10Log.ALD4.attitude_target_euler_rate(:,2) = ALD4(:,4);         %   3. | er1      | attitude_target_euler_rate[1]  | [F]   | [12:12]    | 
V10Log.ALD4.attitude_target_euler_rate(:,3) = ALD4(:,5);         %   4. | er2      | attitude_target_euler_rate[2]  | [F]   | [12:12]    | 
V10Log.ALD4.attitude_target_euler_angle(:,1) = ALD4(:,6);        %   5. | ea0      | attitude_target_euler_angle[0] | [F]   | [12:12]    | 
V10Log.ALD4.attitude_target_euler_angle(:,2) = ALD4(:,7);        %   6. | ea1      | attitude_target_euler_angle[1] | [F]   | [12:12]    | 
V10Log.ALD4.attitude_target_euler_angle(:,3) = ALD4(:,8);        %   7. | ea2      | attitude_target_euler_angle[2] | [F]   | [12:12]    | 
V10Log.ALD4.pos_target(:,1) = ALD4(:,9);                         %   8. | ptg0     | pos_target[0]                  | [F]   | [12:12]    | 
V10Log.ALD4.pos_target(:,2) = ALD4(:,10);                        %   9. | ptg1     | pos_target[1]                  | [F]   | [12:12]    | 
V10Log.ALD4.pos_target(:,3) = ALD4(:,11);                        %  10. | ptg2     | pos_target[2]                  | [F]   | [12:12]    | 
V10Log.ALD4.vel_target(:,1) = ALD4(:,12);                        %  11. | vtg0     | vel_target[0]                  | [F]   | [12:12]    | 
V10Log.ALD4.vel_target(:,2) = ALD4(:,13);                        %  12. | vtg1     | vel_target[1]                  | [F]   | [12:12]    | 
V10Log.ALD4.vel_target(:,3) = ALD4(:,14);                        %  13. | vtg2     | vel_target[2]                  | [F]   | [12:12]    | 
V10Log.ALD4.Sum = ALD4(:,15);                                    %  14. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALD5
V10Log.ALD5.TimeUS = ALD5(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD5.accel_target(:,1) = ALD5(:,3);                       %   2. | acc0     | accel_target[0]                | [F]   | [12:12]    | 
V10Log.ALD5.accel_target(:,2) = ALD5(:,4);                       %   3. | acc1     | accel_target[1]                | [F]   | [12:12]    | 
V10Log.ALD5.accel_target(:,3) = ALD5(:,5);                       %   4. | acc2     | accel_target[2]                | [F]   | [12:12]    | 
V10Log.ALD5.attitude_error_vector(:,1) = ALD5(:,6);              %   5. | vect0    | attitude_error_vector[0]       | [F]   | [12:12]    | 
V10Log.ALD5.attitude_error_vector(:,2) = ALD5(:,7);              %   6. | vect1    | attitude_error_vector[1]       | [F]   | [12:12]    | 
V10Log.ALD5.attitude_error_vector(:,3) = ALD5(:,8);              %   7. | vect2    | attitude_error_vector[2]       | [F]   | [12:12]    | 
V10Log.ALD5.pos_error(:,1) = ALD5(:,9);                          %   8. | per0     | pos_error[0]                   | [F]   | [12:12]    | 
V10Log.ALD5.pos_error(:,2) = ALD5(:,10);                         %   9. | per1     | pos_error[1]                   | [F]   | [12:12]    | 
V10Log.ALD5.pos_error(:,3) = ALD5(:,11);                         %  10. | per2     | pos_error[2]                   | [F]   | [12:12]    | 
V10Log.ALD5.vel_desired(:,3) = ALD5(:,12);                       %  11. | veld2    | vel_desired[2]                 | [F]   | [12:12]    | 
V10Log.ALD5.Sum = ALD5(:,13);                                    %  12. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALD6
V10Log.ALD6.TimeUS = ALD6(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD6.z_accel_meas = ALD6(:,3);                            %   2. | zacm     | z_accel_meas                   | [F]   | [12:12]    | 
V10Log.ALD6.climb_rate_cms = ALD6(:,4);                          %   3. | clrc     | climb_rate_cms                 | [F]   | [12:12]    | 
V10Log.ALD6.throttle_filter = ALD6(:,5);                         %   4. | tfil     | throttle_filter                | [F]   | [12:12]    | 
V10Log.ALD6.nav_pitch_cd = ALD6(:,6);                            %   5. | navcd    | nav_pitch_cd                   | [F]   | [12:12]    | 
V10Log.ALD6.vel_forward_last_pct = ALD6(:,7);                    %   6. | vlpct    | vel_forward_last_pct           | [F]   | [12:12]    | 
V10Log.ALD6.k_rudder = ALD6(:,8);                                %   7. | krud     | k_rudder                       | [F]   | [12:12]    | 
V10Log.ALD6.k_elevator = ALD6(:,9);                              %   8. | kele     | k_elevator                     | [F]   | [12:12]    | 
V10Log.ALD6.k_throttle = ALD6(:,10);                             %   9. | kthr     | k_throttle                     | [F]   | [12:12]    | 
V10Log.ALD6.k_aileron = ALD6(:,11);                              %  10. | kail     | k_aileron                      | [F]   | [12:12]    | 
V10Log.ALD6.curr_alt = ALD6(:,12);                               %  11. | curalt   | curr_alt                       | [F]   | [12:12]    | 
V10Log.ALD6.Sum = ALD6(:,13);                                    %  12. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALD7
V10Log.ALD7.TimeUS = ALD7(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD7.weathervane_last_output = ALD7(:,3);                 %   2. | weat     | weathervane_last_output        | [F]   | [12:12]    | 
V10Log.ALD7.roll_target = ALD7(:,4);                             %   3. | rotg     | roll_target                    | [F]   | [12:12]    | 
V10Log.ALD7.pitch_target = ALD7(:,5);                            %   4. | pitg     | pitch_target                   | [F]   | [12:12]    | 
V10Log.ALD7.roll_target_pilot = ALD7(:,6);                       %   5. | rotp     | roll_target_pilot              | [F]   | [12:12]    | 
V10Log.ALD7.pitch_dem = ALD7(:,7);                               %   6. | pitdm    | pitch_dem                      | [F]   | [12:12]    | 
V10Log.ALD7.hgt_dem = ALD7(:,8);                                 %   7. | hgtdm    | hgt_dem                        | [F]   | [12:12]    | 
V10Log.ALD7.throttle_dem = ALD7(:,9);                            %   8. | thdm     | throttle_dem                   | [F]   | [12:12]    | 
V10Log.ALD7.latAccDem = ALD7(:,10);                              %   9. | accdm    | latAccDem                      | [F]   | [12:12]    | 
V10Log.ALD7.aspeed = ALD7(:,11);                                 %  10. | aspd     | aspeed                         | [F]   | [12:12]    | 
V10Log.ALD7.pitch_target_pilot = ALD7(:,12);                     %  11. | pitpi    | pitch_target_pilot             | [F]   | [12:12]    | 
V10Log.ALD7.Sum = ALD7(:,13);                                    %  12. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALD8
V10Log.ALD8.TimeUS = ALD8(:,2);                                  %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.ALD8.WP_i = ALD8(:,3);                                    %   2. | WP_i     | WP_i                           | [F]   | [12:12]    | 
V10Log.ALD8.sl_heightCmd = ALD8(:,4);                            %   3. | hgtcmd   | sl_heightCmd                   | [F]   | [12:12]    | 
V10Log.ALD8.sl_maxClimbSpeed = ALD8(:,5);                        %   4. | clmspd   | sl_maxClimbSpeed               | [F]   | [12:12]    | 
V10Log.ALD8.sl_flightTaskMode = ALD8(:,6);                       %   5. | fmode    | sl_flightTaskMode              | [F]   | [12:12]    | 
V10Log.ALD8.Sum = ALD8(:,7);                                     %   6. | Sm       | Sum                            | [F]   | [12:12]    | 
%% ALL1
V10Log.IN_MAVLINK.TimeUS = ALL1(:,2);                            %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,1) = ALL1(:,3);    %   2. | LLA0     | mavlink_msg_groundHomeLLA[0]   | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,2) = ALL1(:,4);    %   3. | LLA1     | mavlink_msg_groundHomeLLA[1]   | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_groundHomeLLA(:,3) = ALL1(:,5);    %   4. | LLA2     | mavlink_msg_groundHomeLLA[2]   | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.Sum = ALL1(:,6);                               %   5. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% ALL2
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.TimeUS = ALL2(:,2); %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.fullCapacity = ALL2(:,3); %   2. | cap      | fullCapacity                   | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.lifePercent = ALL2(:,4); %   3. | life     | lifePercent                    | [U8]  | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.cycleTime = ALL2(:,5); %   4. | cycle    | cycleTime                      | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.batteryId = ALL2(:,6); %   5. | batID    | batteryId                      | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_msg_command_battery_data.Sum = ALL2(:,7); %   6. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% ALL3
V10Log.IN_MAVLINK.mavlink_mission_item_def.TimeUS = ALL3(:,2);   %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.seq = ALL3(:,3);      %   2. | seq      | seq                            | [U16] | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.x = ALL3(:,4);        %   3. | x        | x                              | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.y = ALL3(:,5);        %   4. | y        | y                              | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.z = ALL3(:,6);        %   5. | z        | z                              | [F]   | [12:12]    | 
V10Log.IN_MAVLINK.mavlink_mission_item_def.Sum = ALL3(:,7);      %   6. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% ALL4
V10Log.SensorSelect.TimeUS = ALL4(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SensorSelect.IMU = ALL4(:,3);                             %   2. | IMU      | IMU                            | [F]   | [12:12]    | 
V10Log.SensorSelect.Mag = ALL4(:,4);                             %   3. | Mag      | Mag                            | [F]   | [12:12]    | 
V10Log.SensorSelect.GPS = ALL4(:,5);                             %   4. | GPS      | GPS                            | [F]   | [12:12]    | 
V10Log.SensorSelect.Baro = ALL4(:,6);                            %   5. | Bar      | Baro                           | [F]   | [12:12]    | 
V10Log.SensorSelect.Radar = ALL4(:,7);                           %   6. | Radr     | Radar                          | [F]   | [12:12]    | 
V10Log.SensorSelect.Camera = ALL4(:,8);                          %   7. | CAM      | Camera                         | [F]   | [12:12]    | 
V10Log.SensorSelect.Lidar = ALL4(:,9);                           %   8. | Lidr     | Lidar                          | [F]   | [12:12]    | 
V10Log.SensorSelect.Sum = ALL4(:,10);                            %   9. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% ALL5
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
%% ALL6
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
%% ALL7
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
%% ALL8
V10Log.CAMERA.TimeUS = ALL8(:,2);                                %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.CAMERA.time = ALL8(:,3);                                  %   2. | ctim     | time                           | [F]   | [12:12]    | 
V10Log.CAMERA.trigger = ALL8(:,4);                               %   3. | ctrg     | trigger                        | [F]   | [12:12]    | 
V10Log.CAMERA.LLA(:,1) = ALL8(:,5);                              %   4. | cLL0     | LLA[0]                         | [F]   | [12:12]    | 
V10Log.CAMERA.LLA(:,2) = ALL8(:,6);                              %   5. | cLL1     | LLA[1]                         | [F]   | [12:12]    | 
V10Log.CAMERA.LLA(:,3) = ALL8(:,7);                              %   6. | cLL2     | LLA[2]                         | [F]   | [12:12]    | 
V10Log.CAMERA.groundspeed = ALL8(:,8);                           %   7. | gspd     | groundspeed                    | [F]   | [12:12]    | 
V10Log.CAMERA.Sum = ALL8(:,9);                                   %   8. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% ALL9
V10Log.LIDAR.TimeUS = ALL9(:,2);                                 %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.LIDAR.time = ALL9(:,3);                                   %   2. | dtim     | time                           | [F]   | [12:12]    | 
V10Log.LIDAR.trigger = ALL9(:,4);                                %   3. | dtrg     | trigger                        | [F]   | [12:12]    | 
V10Log.LIDAR.LLA(:,1) = ALL9(:,5);                               %   4. | dLL0     | LLA[0]                         | [F]   | [12:12]    | 
V10Log.LIDAR.LLA(:,2) = ALL9(:,6);                               %   5. | dLL1     | LLA[1]                         | [F]   | [12:12]    | 
V10Log.LIDAR.LLA(:,3) = ALL9(:,7);                               %   6. | dLL2     | LLA[2]                         | [F]   | [12:12]    | 
V10Log.LIDAR.groundspeed = ALL9(:,8);                            %   7. | gspd     | groundspeed                    | [F]   | [12:12]    | 
V10Log.LIDAR.Sum = ALL9(:,9);                                    %   8. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL10
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
%% AL11
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
%% AL12
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
%% AL13
V10Log.OUT_TASKMODE.TimeUS = AL13(:,2);                          %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKMODE.airspeedCmd = AL13(:,4);                     %   2. | aspCmd   | airspeedCmd                    | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.LLATaskInterrupt(:,1) = AL13(:,5);           %   3. | LL0      | LLATaskInterrupt[0]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.LLATaskInterrupt(:,2) = AL13(:,6);           %   4. | LL1      | LLATaskInterrupt[1]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.LLATaskInterrupt(:,3) = AL13(:,7);           %   5. | LL2      | LLATaskInterrupt[2]            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.isTaskComplete = AL13(:,8);                  %   6. | comp     | isTaskComplete                 | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.numTakeOff = AL13(:,9);                      %   7. | take     | numTakeOff                     | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.isHeadingRotate_OnGround = AL13(:,10);       %   8. | onGd     | isHeadingRotate_OnGround       | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.isAllowedToPause = AL13(:,11);               %   9. | isPause  | isAllowedToPause               | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.lastTargetPathPoint = AL13(:,12);            %  10. | lPt      | lastTargetPathPoint            | [F]   | [12:12]    | 
V10Log.OUT_TASKMODE.uavMode = AL13(:,13);                        %  11. | Mod      | uavMode                        | [U8]  | [12:12]    | 
%% AL14
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
%% AL15
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
%% AL16
V10Log.OUT_TASKFLIGHTPARAM.TimeUS = AL16(:,2);                   %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,1) = AL16(:,3);       %   2. | LL0      | groundHomeLLA[0]               | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,2) = AL16(:,4);       %   3. | LL1      | groundHomeLLA[1]               | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.groundHomeLLA(:,3) = AL16(:,5);       %   4. | LL2      | groundHomeLLA[2]               | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.curHeightForControl = AL16(:,6);      %   5. | ctl      | curHeightForControl            | [F]   | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.isNavFilterGood = AL16(:,7);          %   6. | good     | isNavFilterGood                | [U8]  | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.uavModel = AL16(:,8);                 %   7. | mod      | uavModel                       | [U8]  | [12:12]    | 
V10Log.OUT_TASKFLIGHTPARAM.Sum = AL16(:,9);                      %   8. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL17
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
%% AL18
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
%% AL19
V10Log.Debug_Task_RTInfo.TimeUS = AL19(:,2);                     %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_Task_RTInfo.LandCond3_near = AL19(:,3);             %   2. | L3n      | LandCond3_near                 | [U8]  | [12:12]    | 
V10Log.Debug_Task_RTInfo.maxDist_Path2Home = AL19(:,4);          %   3. | hom      | maxDist_Path2Home              | [F]   | [12:12]    | 
V10Log.Debug_Task_RTInfo.realtimeFenseDist = AL19(:,5);          %   4. | dist     | realtimeFenseDist              | [F]   | [12:12]    | 
V10Log.Debug_Task_RTInfo.Sum = AL19(:,6);                        %   5. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL20
V10Log.Debug_WindParam.TimeUS = AL20(:,2);                       %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_WindParam.sailWindSpeed = AL20(:,3);                %   2. | wspd     | sailWindSpeed                  | [F]   | [12:12]    | 
V10Log.Debug_WindParam.sailWindHeading = AL20(:,4);              %   3. | swhd     | sailWindHeading                | [F]   | [12:12]    | 
V10Log.Debug_WindParam.windSpeedMax = AL20(:,5);                 %   4. | wmx      | windSpeedMax                   | [F]   | [12:12]    | 
V10Log.Debug_WindParam.windSpeedMin = AL20(:,6);                 %   5. | wmn      | windSpeedMin                   | [F]   | [12:12]    | 
V10Log.Debug_WindParam.maxWindHeading = AL20(:,7);               %   6. | mwhd     | maxWindHeading                 | [F]   | [12:12]    | 
V10Log.Debug_WindParam.Sum = AL20(:,8);                          %   7. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL21
V10Log.GlobalWindEst.TimeUS = AL21(:,2);                         %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.GlobalWindEst.oneCircleComplete = AL21(:,3);              %   2. | comp     | oneCircleComplete              | [F]   | [12:12]    | 
V10Log.GlobalWindEst.windSpeed_ms = AL21(:,4);                   %   3. | wspd     | windSpeed_ms                   | [F]   | [12:12]    | 
V10Log.GlobalWindEst.windHeading_rad = AL21(:,5);                %   4. | whrd     | windHeading_rad                | [F]   | [12:12]    | 
V10Log.GlobalWindEst.Sum = AL21(:,6);                            %   5. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL22
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
%% AL23
V10Log.Debug_GroundStationShow.TimeUS = AL23(:,2);               %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Debug_GroundStationShow.windSpeed_ms = AL23(:,3);         %   2. | wspd     | windSpeed_ms                   | [F]   | [12:12]    | 
V10Log.Debug_GroundStationShow.groundSpeed_ms = AL23(:,5);       %   3. | gsPd     | groundSpeed_ms                 | [F]   | [12:12]    | 
%% AL25
V10Log.Simulation_TaskAlgoParam.TimeUS = AL25(:,2);              %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Simulation_TaskAlgoParam.isHoverDownToCenter = AL25(:,3); %   2. | hov      | isHoverDownToCenter            | [F]   | [12:12]    | 
V10Log.Simulation_TaskAlgoParam.runSingleTaskMode = AL25(:,4);   %   3. | mode     | runSingleTaskMode              | [F]   | [12:12]    | 
V10Log.Simulation_TaskAlgoParam.Sum = AL25(:,5);                 %   4. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL26
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
%% AL27
V10Log.SystemHealthStatus.TimeUS = AL27(:,2);                    %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.SystemHealthStatus.SystemHealthStatus = AL27(:,3);        %   2. | Health   | SystemHealthStatus             | [F]   | [12:12]    | 
V10Log.SystemHealthStatus.Sum = AL27(:,4);                       %   3. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL28
V10Log.Status.TimeUS = AL28(:,2);                                %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.Status.isNavFilterGood = AL28(:,3);                       %   2. | good     | isNavFilterGood                | [U8]  | [12:12]    | 
V10Log.Status.Sum = AL28(:,4);                                   %   3. | Sm       | Sum                            | [U8]  | [12:12]    | 
%% AL29
V10Log.OUT_SYSTEMINFO.TimeUS = AL29(:,2);                        %   1. | Tim      | TimeUS                         | [U32] | [12:12]    | 
V10Log.OUT_SYSTEMINFO.uavModel = AL29(:,3);                      %   2. | modl     | uavModel                       | [U8]  | [12:12]    | 
V10Log.OUT_SYSTEMINFO.Sum = AL29(:,4);                           %   3. | Sm       | Sum                            | [U8]  | [12:12]    | 
