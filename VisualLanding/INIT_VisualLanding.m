%% 载入Bus
load('IOBusInfo_V1000') 
%% 视觉着陆参数
Ts_VisualLanding.Ts_Base = 0.012;
%% V1000参数
VISLANDING_PARAM_V1000 = Simulink.Bus.createMATLABStruct('BUS_VISUALLANDING_PARAM');
% 机体坐标系: 前-右-下
% 相机坐标系: 右-后-下
VISLANDING_PARAM_V1000.Rcb = Rz(pi/2); % Vc = Rcb*Vb;
VISLANDING_PARAM_V1000.enableStateEstimate = true; % 使能着陆标志状态估计
%% V10参数
VISLANDING_PARAM_V10 = VISLANDING_PARAM_V1000;