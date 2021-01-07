function [out,isCancel] = selPlaneMode()
%% 生成机型变量
% planeMode_sel = questdlg('选择机型', ...
%     '选择机型', ...
%     'V1000','V10','V10_1','V1000');
% if strcmp(planeMode_sel,'取消')
%     return;
% end
%% 获取机型变量并显示
idxValid = 1;
maxIdx = 1000;
fprintf('警告: 若机型枚举变量(ENUM_plane_mode)的值大于 %d, 则列表中的机型显示将不完全\n',maxIdx);
for i = 0:maxIdx
    try
        namePlaneMode{idxValid} = sprintf('%s',ENUM_plane_mode(i));
        idxValid = idxValid + 1;
    end
end
%% 选择机型
selNum = listdlg(...
    'PromptString',{'Select Plane Mode'},...
    'SelectionMode','single',...
    'ListString',namePlaneMode);
if isempty(selNum)
    fprintf('\n[END] 未选择机型,退出仿真\n');
    isCancel = true;
    out = [];
else
    isCancel = false;
    %% 生成提示信息
    planeMode_sel = namePlaneMode{selNum};
    uavMode = ENUM_plane_mode.(planeMode_sel);
    str = sprintf('uavMode = ENUM_plane_mode.%s',planeMode_sel);
    fprintf('机型选择为  %s     （ %s ）\n',planeMode_sel,str);
    %% 输出
    out = uavMode;
end
