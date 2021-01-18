function FlightDataSimParam = SetSimParam_FlightData()
global GLOBAL_PARAM
FlightDataSimParam.Ts_base = 0.004; % 该值为log中记录的IMU数据频率 [sec]

%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,FlightDataSimParam.Ts_base);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);