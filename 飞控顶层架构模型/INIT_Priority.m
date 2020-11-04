% 数值越低优先级越高，可为负值
ArchiModelName = 'RefModel_SystemArchitecture';
load_system(ArchiModelName);
FlightManagerName = 'FlightManager';
ControllerName = 'Controller';
core_Model = [ArchiModelName,'/FlightControlFirmware'];
sub_ManagerModel = [ArchiModelName,'/FlightControlFirmware/',FlightManagerName];
sub_ControlModel = [ArchiModelName,'/FlightControlFirmware/',ControllerName];
allblocks = get_param(core_Model,'blocks');
exist_flightmanager = 0;
exist_controller = 0;
for i = 1:length(allblocks)
    if strmatch(allblocks{i},FlightManagerName) 
        exist_flightmanager = 1;
    end
    if strmatch(allblocks{i},ControllerName) 
        exist_controller = 1;
    end    
end
if exist_controller == 0
    msgstr = sprintf('%s 中没有 %s 模块',ArchiModelName,ControllerName);
    errordlg(msgstr) 
    error(msgstr)
end
if exist_flightmanager == 0
    msgstr = sprintf('%s 中没有 %s 模块',ArchiModelName,FlightManagerName);
    errordlg(msgstr) 
    error(msgstr)
end
SystemPriority.FlightManager = 1;
SystemPriority.Controller = 2;
set_param(sub_ManagerModel,'priority',num2str(SystemPriority.FlightManager));
set_param(sub_ControlModel,'priority',num2str(SystemPriority.Controller));
fprintf('优先级设置 (数值越低优先级越高):\n\t任务相关模块 (%s)\t %2d\n\t控制模块 (%s)\t%2d\n',sub_ManagerModel,SystemPriority.FlightManager,sub_ControlModel,SystemPriority.Controller);