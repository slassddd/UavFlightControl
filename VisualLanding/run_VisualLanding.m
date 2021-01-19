clear,clc
VLAND.frametime = 8*0.012;
%%
SimParam.Basic.selDefaultPlaneMode = [] ; % [] ENUM_plane_mode.V1000 
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode(SimParam.Basic.selDefaultPlaneMode);if isCancel,return;end % 选择机型
[SimParam.VLand,VISLANDING_PARAM_V1000,VISLANDING_PARAM_V10] = SetAlgoParam_VisualLanding();