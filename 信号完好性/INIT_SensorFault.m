function [SFSimParam,SENSOR_FAULT] = INIT_SensorFault()
global GLOBAL_PARAM
%% 传感器故障
% Ts_SensorFault.Ts_base = 0.012;
SFSimParam.Ts_base = 0.012;
SENSOR_FAULT.ublox1.zeroStartTime = [-1];
SENSOR_FAULT.ublox1.zeroEndTime = [-1];
SENSOR_FAULT.ublox1.jumpStartTime = [-1];
SENSOR_FAULT.ublox1.jumpEndTime = [-1];
SENSOR_FAULT.ublox1.lostStartTime = [450];
SENSOR_FAULT.ublox1.lostEndTime = [500];

%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,SFSimParam.Ts_base);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);