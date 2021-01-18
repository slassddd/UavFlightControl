function [VLSimParam,VISLANDING_PARAM_V1000,VISLANDING_PARAM_V10] = SetAlgoParam_VisualLanding()
global GLOBAL_PARAM
%% 载入Bus
evalin('base','load(''IOBusInfo_V1000'')');
%% 视觉着陆参数
VLSimParam.Ts_base = 0.012;
%% V1000参数
VISLANDING_PARAM_V1000 = Simulink.Bus.createMATLABStruct('BUS_VISUALLANDING_PARAM');
% 机体坐标系: 前-右-下
% 相机坐标系: 右-后-下
VISLANDING_PARAM_V1000.Rcb = Rz(pi/2); % Vc = Rcb*Vb;
VISLANDING_PARAM_V1000.enableStateEstimate = true; % 使能着陆标志状态估计
VISLANDING_PARAM_V1000.enableCompileInSystem = false; % 使能大模型中对该模块的编译
%% V10参数
VISLANDING_PARAM_V10 = VISLANDING_PARAM_V1000;
VISLANDING_PARAM_V10.enableCompileInSystem = true; % 使能大模型中对该模块的编译

%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,VLSimParam.Ts_base);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);