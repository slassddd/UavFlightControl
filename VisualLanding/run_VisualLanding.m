clear,clc
VLAND.frametime = 8*0.012;
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
INIT_VisualLanding;