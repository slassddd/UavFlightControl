%% ������ѡ���ͽ��в�����ʼ��
mode_navi = questdlg('Navi����ѡ�����', ...
    'ѡ�����', ...
    'V1000','V10','V10s','V1000');
if strcmp(mode_navi,'ȡ��')
    return;
end
switch mode_navi
    case {'V1000','V10s'}
        PlaneMode.navi = ENUM_plane_mode.V1000;
    case 'V10'
        PlaneMode.navi = ENUM_plane_mode.V10;
    otherwise
        error('��ϵ���ģ�����ѡ�����.')
end
%%
INIT_Navi_V1000
INIT_Navi_V10
