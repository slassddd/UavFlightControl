%% ������ѡ���ͽ��в�����ʼ��
mode_navi = questdlg('Navi����ѡ�����', ...
    'ѡ�����', ...
    'V1000','V10','V10s','V1000');
if strcmp(mode_navi,'ȡ��')
    return;
end
%%
switch mode_navi
    case {'V1000','V10s'}
        INIT_Navi_V1000
    case 'V10'
        INIT_Navi_V10
    otherwise
        error('��ϵ���ģ�����ѡ�����.')
end