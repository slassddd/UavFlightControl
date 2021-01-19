function [out,isCancel] = selSimCaseSource(subSystem,varargin)
global GLOBAL_PARAM
skipSelect = false; % 跳过选择
if length(varargin) == 1
    thisVar = varargin{1};
    if thisVar
        skipSelect = true;
        selNum = 1;
    else
        % 执行正常的选择
    end
end
% 定义选择列表
flagTestCase_Task = 'GSTestCase';
flagTestCase_SensorFault = 'SensorFaultTestCase';
manualString = 'Manual';
switch lower(subSystem)
    case 'task'
        tempName = flagTestCase_Task;
        struct = dir([GLOBAL_PARAM.project.RootFolder{1},'\任务模型\TEST_CASE_TASK\',tempName,'*.m']);
        for i = 1:length(struct)
            [~,namePlaneMode{i}] = fileparts(struct(i).name);
        end
        namePlaneMode = [{manualString},namePlaneMode];
        defaultCase = {[tempName,'_Default']};
    case 'sensorfaultpanel'
        tempName = flagTestCase_SensorFault;
        struct = dir([GLOBAL_PARAM.project.RootFolder{1},'\信号完好性\TEST_CASE_SIGNALINTEGRITY\',tempName,'*.m']);
        for i = 1:length(struct)
            [~,namePlaneMode{i}] = fileparts(struct(i).name);
        end
        namePlaneMode = [{manualString},namePlaneMode];
        defaultCase = {[tempName,'_Default']};
    otherwise
        error('');
end
if ~skipSelect
    % 选择
    showname = sprintf('[%s] 测试用例选择',subSystem);
    selNum = listdlg(...
        'PromptString',{showname},...
        'SelectionMode','multiple',...
        'ListString',namePlaneMode);
end
if isempty(selNum) % 未选择测试用例，结束仿真
    fprintf('\n%s%s[END] 未选择测试用例,退出仿真\n',GLOBAL_PARAM.Print.lineHead,subSystem);
    isCancel = true;
    nameTestCase = [];
else %
    isCancel = false;
    %% 生成提示信息
    if selNum == 1
        fprintf('%s%s不使用批量测试用例,手动进行仿真\n',GLOBAL_PARAM.Print.lineHead,subSystem);
        nameTestCase = [];
    else
        selNum(selNum==1) = []; % 当选择多个测试用例时，若包含1号（manual）,则删除manual项
        for i = 1:length(selNum)
            nameTestCase{i} = namePlaneMode{selNum(i)};
            fprintf('%s%s选择测试用例 %s\n',GLOBAL_PARAM.Print.lineHead,subSystem,nameTestCase{i});
        end
    end
end
if isempty(nameTestCase)
    nameTestCase = defaultCase;
    select = 1;
else
    select = 2;
end
out.filename = nameTestCase;
out.sel = select;