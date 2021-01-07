%% V1000参数
INIT_Navi_V1000
%% V10参数
INIT_Navi_V10
%% 型号无关参数
% 磁场模型
dateyear = 2020;
NAVI_PARAM_BASE.magneticData_igrfmagm = NAVI_calMagneticDec(dateyear,'igrfmagm');
NAVI_PARAM_BASE.nStateMARG = 22;
NAVI_PARAM_BASE.nStateMARG24 = 24;