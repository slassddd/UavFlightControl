%% 根据所选机型进行参数初始化
mode_navi = questdlg('Navi——选择机型', ...
    '选择机型', ...
    'V1000','V10','V10s','V1000');
if strcmp(mode_navi,'取消')
    return;
end
%%
switch mode_navi
    case {'V1000','V10s'}
        INIT_Navi_V1000
    case 'V10'
        INIT_Navi_V10
    otherwise
        error('组合导航模块机型选择错误.')
end