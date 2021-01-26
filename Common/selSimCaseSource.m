function [out,isCancel] = selSimCaseSource(subSystem,varargin)
global GLOBAL_PARAM
mode = 'list'; % 选择模式
if length(varargin) == 1
    thisVar = varargin{1};
    if thisVar
        mode = 'setmanual';
    else
        % 执行正常的选择
    end
elseif length(varargin) == 2
    mode = 'appointname';
    for i = 1:length(varargin)/2
        varname = varargin{2*i-1};
        varvalue = varargin{2*i};
        switch lower(varname)
            case 'casefilename'
                if ~isempty(varvalue)
                    appointTestCaseName = {varvalue};
                else
                    mode = 'list';
                end
        end
    end
end
%% 选择测试用例
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
% 执行选择
switch mode
    case 'list'
        select = 2;
        % 选择
        showname = sprintf('[%s] 测试用例选择',subSystem);
        selNum = listdlg(...
            'PromptString',{showname},...
            'SelectionMode','multiple',...
            'ListString',namePlaneMode);
        
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
    case 'setmanual'
        nameTestCase = defaultCase;
        isCancel = false;
        select = 1;
        fprintf('%s%s选择测试用例 %s\n',GLOBAL_PARAM.Print.lineHead,subSystem,nameTestCase{1});
    case 'appointname'
        nameTestCase = appointTestCaseName;
        isCancel = false;
        select = 2;
        fprintf('%s%s选择测试用例 %s\n',GLOBAL_PARAM.Print.lineHead,subSystem,nameTestCase{1});
end
%%
out.filename = nameTestCase;
out.sel = select; % 在模型中进行测试用例数据源选择