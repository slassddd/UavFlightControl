function out = selParamForPlaneMode()
%% 生成机型变量
planeMode_sel = questdlg('选择机型', ...
    '选择机型', ...
    'V1000','V10','V10s','V1000');
if strcmp(planeMode_sel,'取消')
    return;
end
switch planeMode_sel
    case {'V1000','V10s'}
        PlaneMode.mode = ENUM_plane_mode.V1000;
        disp('机型选择为 V1000')
    case 'V10'
        PlaneMode.mode = ENUM_plane_mode.V10;
        disp('机型选择为 V10')
    otherwise
        error('组合导航模块机型选择错误.')
end
out = PlaneMode.mode;