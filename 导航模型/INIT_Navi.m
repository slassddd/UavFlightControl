function [NaviSimParam,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = INIT_Navi(planeMode)
switch planeMode
    case  {ENUM_plane_mode.V1000, ENUM_plane_mode.V10}
        NaviSimParam.Ts_Base = 0.012;
    case  ENUM_plane_mode.V10_1
        NaviSimParam.Ts_Base = 0.012;
    otherwise
        error('����ѡ�����')
end
global GLOBAL_PARAM
fprintf('[%s]\n',mfilename);
fprintf('%s����: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,NaviSimParam.Ts_Base);

%% V1000����
NAVI_PARAM_V1000 = INIT_Navi_V1000(NaviSimParam.Ts_Base);
%% V10����
NAVI_PARAM_V10 = INIT_Navi_V10(NaviSimParam.Ts_Base);
%% �ͺ��޹ز���
% �ų�ģ��
dateyear = 2020;
NAVI_PARAM_BASE.magneticData_igrfmagm = NAVI_calMagneticDec(dateyear,'igrfmagm');
NAVI_PARAM_BASE.nStateMARG = 22;
NAVI_PARAM_BASE.nStateMARG24 = 24;

fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
