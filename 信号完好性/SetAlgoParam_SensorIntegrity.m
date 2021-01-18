function [SISimParam,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = SetAlgoParam_SensorIntegrity()
global GLOBAL_PARAM
SISimParam.Ts_base = 0.012;
SISimParam.Ts_integrityCheck = 30*SISimParam.Ts_base;
%% V1000参数
[SENSOR_INTEGRITY_PARAM_V1000] = INIT_SensorIntegrity_V1000();
%% V10参数
SENSOR_INTEGRITY_PARAM_V10 = INIT_SensorIntegrity_V10();
%% 基础参数
SENSOR_INTEGRITY_PARAM_BASE.magCalibMagitude0 = 54; % 磁力计矫正参考模值[uT]该值为宝坻地磁数值
SENSOR_INTEGRITY_PARAM_BASE.kSmoothMean_IMUAlign = 0.8; % 对IMU零偏修正值的平滑滤波系数,[0,1)
%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,SISimParam.Ts_base);
fprintf('%s核心功能周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,SISimParam.Ts_integrityCheck);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);