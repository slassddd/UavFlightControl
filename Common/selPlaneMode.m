function [uavMode,isCancel] = selPlaneMode(varargin)
global GLOBAL_PARAM
enumName = 'ENUM_plane_mode';
if length(varargin) == 1
    thisVar = varargin{1};
    if ~isempty(thisVar)
        if isa(thisVar,enumName)
            uavMode = thisVar;
            isCancel = false;
            printfInfo()
            return;
        else
            error('输入变量应为 %s 类型',enumName)
        end
    else
        % 执行正常的选择
    end
end
%% 获取机型变量并显示
idxValid = 1;
maxIdx = 1000;
fprintf('%s[WARNING]: 若机型枚举变量(%s)的值大于 %d, 则列表中的机型显示将不完全\n',...
    GLOBAL_PARAM.Print.lineHead,enumName,maxIdx);
for i = 0:maxIdx
    try
        str = sprintf('%s(%d)',enumName,i);
        var = eval(str);
        namePlaneMode{idxValid} = sprintf('%s',var);
        idxValid = idxValid + 1;
    end
end
%% 选择机型
selNum = listdlg(...
    'PromptString',{'Select Plane Mode'},...
    'SelectionMode','single',...
    'ListString',namePlaneMode);
if isempty(selNum)
    fprintf('\n%s[END] 未选择机型,退出仿真\n',GLOBAL_PARAM.Print.lineHead);
    isCancel = true;
    uavMode = [];
else
    isCancel = false;
    %% 生成提示信息
    planeMode_sel = namePlaneMode{selNum};
    str = sprintf('%s.(''%s'')',enumName,planeMode_sel);
    uavMode = eval(str); %ENUM_plane_mode.(planeMode_sel);
    printfInfo()
end
%% 子函数
function printfInfo()
    str = sprintf('uavMode = %s.%s',enumName,uavMode);
    fprintf('%s机型选择为  %s    （ %s ）\n',GLOBAL_PARAM.Print.lineHead,uavMode,str);
end
end