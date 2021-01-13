function [nameTestCase,select,isCancel] = selSimCaseSource(subSystem)
global GLOBAL_PARAM
% 定义选择列表
flagTestCase_Task = 'TaskTestCase';
switch lower(subSystem)
    case 'task'
        struct = dir([GLOBAL_PARAM.project.RootFolder{1},'\任务模型\TEST_CASE_TASK\',flagTestCase_Task,'*.m']);
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
    'SelectionMode','multiple',...
    'ListString',namePlaneMode);
if isempty(selNum)
    fprintf('\n%s[END] 未选择测试用例,退出仿真\n',GLOBAL_PARAM.Print.lineHead);
    isCancel = true;
    nameTestCase = [];
else
    isCancel = false;
    %% 生成提示信息
    if selNum == 1
        fprintf('%s不使用批量测试用例,手动进行仿真\n',GLOBAL_PARAM.Print.lineHead);
        nameTestCase = [];
    else
        for i = 1:length(selNum)
            nameTestCase{i} = namePlaneMode{selNum(i)};
            fprintf('%s选择测试用例 %s\n',GLOBAL_PARAM.Print.lineHead,nameTestCase{i});
        end
    end
end
if isempty(nameTestCase)
    nameTestCase = defaultCase;
    select = 1;
else
    select = 2;
end