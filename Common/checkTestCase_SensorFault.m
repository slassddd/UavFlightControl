function checkTestCase_SensorFault(TestCase)
global GLOBAL_PARAM
nCase = length(TestCase);
fprintf('%s测试用例检测（共%d个用例）\n',GLOBAL_PARAM.Print.lineHead,nCase);
for i_case = 1:nCase
    thisCase = TestCase(i_case);
    fprintf('%s%d %s \n',GLOBAL_PARAM.Print.lineHead,i_case,thisCase.casename);
    %% TimeTrigger
    fprintf('%s%sTimeTrigger\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
    % 时间升序检测
    time = thisCase.TimeTrigger.time;
    flagTimeAscend = checkTime(time);
    if ~isempty(flagTimeAscend)
        str = sprintf('%s[WARNING] TimeTrigger 时序检测失败，请保证时间为升序\n',...
            GLOBAL_PARAM.Print.lineHead);
        fprintf(str);
        warning(str);
    end
    % 信息显示
    for i = 1:length(thisCase.TimeTrigger.info)
        context = thisCase.TimeTrigger.info{i};
        fprintf('%s%s%s%s\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,context);
    end
    
    %% EventTrigger
    fprintf('%s%sEventTrigger\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
end
%% 子函数
function flag = checkTime(time)
diffValue = diff(time);
flag = diffValue(diffValue<0);
if ~isempty(flag)
    error('必须保持时间升序');
end
