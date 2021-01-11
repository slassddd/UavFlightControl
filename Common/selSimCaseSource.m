function [out,select,isCancel] = selSimCaseSource(subSystem)
global GLOBAL_PARAM
% 定义选择列表
switch lower(subSystem)
    case 'task'
        struct = dir([GLOBAL_PARAM.project.RootFolder{1},'\任务模型\TEST_CASE_TASK\*.m']);
        for i = 1:length(struct)
            [~,namePlaneMode{i}] = fileparts(struct(i).name);
        end
        namePlaneMode = [{'Manual'},namePlaneMode];
        defaultCase = 'TaskTestCase_Default';
    otherwise
        error('');
end
% 选择
selNum = listdlg(...
    'PromptString',{'Select Plane Mode'},...
    'SelectionMode','single',...
    'ListString',namePlaneMode);
if isempty(selNum)
    fprintf('\n%s[END] 未选择,退出仿真\n',GLOBAL_PARAM.Print.lineHead);
    isCancel = true;
    out = [];
else
    isCancel = false;
    %% 生成提示信息
    if selNum == 1
        fprintf('%s不使用批量测试用例,手动进行仿真\n',GLOBAL_PARAM.Print.lineHead);
        nameTestCase = [];
    else
        nameTestCase = namePlaneMode{selNum};
        fprintf('%s选择测试用例 %s\n',GLOBAL_PARAM.Print.lineHead,nameTestCase);
    end
    %% 输出
    out = nameTestCase;
end
if isempty(nameTestCase)
    out = defaultCase;
    select = 1;
else
    select = 2;
end