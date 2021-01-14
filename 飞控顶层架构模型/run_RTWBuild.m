clear,clc
setGlobalParams;
%% 模型参数初始化
INIT_SystemArchitecture
%%
modelname = 'RefModel_SystemArchitecture';
infofilename = 'SystemInfo.mat';
%% 模型参数配置
stepMode = questdlg('选择代码生成的任务模式(V10新固件选择''多step'',其他机型固件选择''单step'')','模式','单step','多step','取消','单step');
if isempty(stepMode) || strcmp(stepMode,'取消')
    disp('未选择stepmode');
    return;
end
setRefModelConfiguration(modelname,stepMode);
%%
temp_old_pathname = cd;
temp_pathname = mfilename('fullpath');
temp = strfind(temp_pathname,'\');
temp_pathname = temp_pathname(1:temp(end));
cd(temp_pathname)
%% 载入模型
load_system(modelname);
open_system([modelname,'/SystemInfo/']);
%% 更新版本参数
try
    load(infofilename);
    SystemInfo.version = num2str(str2num(SystemInfo.version) + 0.001);
    SystemInfo.task_version = num2str(str2num(SystemInfo.task_version) + 0.001);
    SystemInfo.control_version = num2str(str2num(SystemInfo.control_version) + 0.001);
catch
    SystemInfo.version = '';
    SystemInfo.date = '';
    SystemInfo.task_version = '';
    SystemInfo.control_version = '';
end
tempTime = clock;
SystemInfo.date = [ num2str(tempTime(1)),...年
                    num2str(tempTime(2)),...月
                    num2str(tempTime(3));];%日
prompt = {'飞控版本号','时间','任务等模型版本号','控制模型版本号'};
dlgtitle = '系统信息';
dims = [1 55];

definput = {SystemInfo.version,SystemInfo.date,SystemInfo.task_version,SystemInfo.control_version};
answer = inputdlg(prompt,dlgtitle,dims,definput);
if isempty(answer)
    return;
end
%%
SystemInfo.version = answer{1};
SystemInfo.date = answer{2};
SystemInfo.task_version = answer{3};
SystemInfo.control_version = answer{4};
set_param([modelname,'/SystemInfo/version'],'value',SystemInfo.version)
set_param([modelname,'/SystemInfo/date'],'value',SystemInfo.date)
set_param([modelname,'/SystemInfo/task_version'],'value',SystemInfo.task_version)
set_param([modelname,'/SystemInfo/control_version'],'value',SystemInfo.control_version)
set_param(modelname,'CombineOutputUpdateFcns','on');
save_system(modelname);
pause(2);
%% 编译
rtwbuild(modelname)
%% 保存系统信息
save(infofilename,'SystemInfo')
% %% 跳转到生成代码的路径
%% 跳转回原目录
cd(temp_old_pathname)
