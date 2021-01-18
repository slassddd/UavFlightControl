function [SFSimParam] = SetAlgoParam_SensorFault()
global GLOBAL_PARAM
%% 传感器故障
SFSimParam.Ts_base = 0.012;
%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,SFSimParam.Ts_base);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);