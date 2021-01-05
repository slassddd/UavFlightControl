function out = selParamForPlaneMode()
%% 生成机型变量
% planeMode_sel = questdlg('选择机型', ...
%     '选择机型', ...
%     'V1000','V10','V10_1','V1000');
% if strcmp(planeMode_sel,'取消')
%     return;
% end
idxValid = 1;
maxIdx = 1000;
fprintf('警告: 若机型枚举变量(ENUM_plane_mode)的值大于 %d, 则列表中的机型显示将不完全\n',maxIdx);
for i = 0:maxIdx
    try 
        namePlaneMode{idxValid} = sprintf('%s',ENUM_plane_mode(i));
        idxValid = idxValid + 1;
    end
end
selNum = listdlg(...
    'PromptString',{'Select Plane Mode'},...
    'SelectionMode','single',...
    'ListString',namePlaneMode);
% if isempty(selNum)
%     error('');
%     return; 
% end
planeMode_sel = namePlaneMode{selNum};
PlaneMode.mode = ENUM_plane_mode.(planeMode_sel);
str = sprintf('PlaneMode.mode = ENUM_plane_mode.%s',planeMode_sel);
fprintf('机型选择为  %s     （ %s ）\n',planeMode_sel,str);

out = PlaneMode.mode;