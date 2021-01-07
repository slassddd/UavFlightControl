function [mode_architechure,isCancel] = selectArchiSimMode()
mode_architechure = questdlg('选择仿真模式', ...
    '选择仿真模式', ...
    '飞行数据回放','仿真','取消','飞行数据回放');
if strcmp(mode_architechure,'取消') || isempty(mode_architechure)
    fprintf('\n[END] 未选择仿真模式,退出仿真\n');
    isCancel = true;
else
    isCancel = false;
end