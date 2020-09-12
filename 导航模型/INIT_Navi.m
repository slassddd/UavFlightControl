%% V1000参数
INIT_Navi_V1000
%% V10参数
INIT_Navi_V10
%% 型号无关参数
% 磁场模型
dateyear = 2020;
magneticData_igrfmagm = NAVI_calMagneticDec(dateyear,'igrfmagm');
NAVIParam.InvarParam.magneticData_igrfmagm = magneticData_igrfmagm;