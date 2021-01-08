function [runMode,isCancel] = selectArchiSimMode()
global GLOBAL_PARAM
runMode = questdlg('选择仿真模式', ...
    '选择仿真模式', ...
    '飞行数据回放','仿真','取消','飞行数据回放');
if strcmp(runMode,'取消') || isempty(runMode)
    fprintf('\n[END] 未选择仿真模式,退出仿真\n');
    isCancel = true;
else
    isCancel = false;
end

%%
fprintf('%s数据源: %s\n',GLOBAL_PARAM.Print.lineHead,runMode);
