% 对框架模型中所有引用模型的Configuration进行统一设置
clear DependencySet
DependencySet.MainModelNameNoType = 'RefModel_SystemArchitecture';
DependencySet.MainModelName = [DependencySet.MainModelNameNoType,'.slx'];
DependencySet.FilePathNames = dependencies.fileDependencyAnalysis(DependencySet.MainModelNameNoType);
DependencySet.FilePathNames{end} = which(DependencySet.MainModelName);
clear DependencySet.RefModeFullNames DependencySet.RefModeNamesNoType
DependencySet.RefModeFullNames{1} = cell(1);
DependencySet.RefModeNamesNoType{1} = cell(1);
nRefModel = 0;
% 查找所有Refmodel
for i = 2:length(DependencySet.FilePathNames)
    iFilePathNames = DependencySet.FilePathNames{i};
    idx_dot = strfind(iFilePathNames,'.');
    idx_slash = strfind(iFilePathNames,'\');
    idx_lastDot = idx_dot(end);
    idx_slash = idx_slash(end);
    iFileType = iFilePathNames(idx_lastDot+1:end);
    iFileName = iFilePathNames(idx_slash+1:end);
    iFileNameNoType = iFilePathNames(idx_slash+1:idx_lastDot-1);
    if (contains(iFileType,'slx')&&~contains(iFileType,'slxc')) || contains(iFileType,'mdl')
        isSameMdlFound = false;
        for ii = 1:nRefModel
            if strcmp(iFileName,DependencySet.RefModeFullNames{ii})
                isSameMdlFound = true;
                break;
            end
        end
        if isSameMdlFound
            continue;
        end
        nRefModel = nRefModel + 1;
        DependencySet.RefModeFullNames{nRefModel} = iFileName;
        DependencySet.RefModeNamesNoType{nRefModel} = iFileNameNoType;
    end
end
for i = 1:length(DependencySet.RefModeNamesNoType)
    load_system(DependencySet.RefModeNamesNoType{i})
end
%% 模型原设置
disp('模型原属性');
DependencySet = getModelProp(DependencySet,nRefModel);
showModelProp(DependencySet);
%% 更新设置
for i = 1:nRefModel
    set_param(DependencySet.RefModeNamesNoType{i},'InheritedTsInSrcMsg','None'); % Source block specifies -1 sample time
    set_param(DependencySet.RefModeNamesNoType{i},'ParameterPrecisionLossMsg','None'); % Detect precision loss
    
    set_param(DependencySet.RefModeNamesNoType{i},'UnconnectedInputMsg','None'); % Unconnected block input ports
    set_param(DependencySet.RefModeNamesNoType{i},'UnconnectedOutputMsg','None'); % Unconnected block output ports
    set_param(DependencySet.RefModeNamesNoType{i},'UnconnectedLineMsg','None'); % Unconnected line
    set_param(DependencySet.RefModeNamesNoType{i},'MaxIdLength','48'); % Maximum identifier length
    
    set_param(DependencySet.RefModeNamesNoType{i},'CombineOutputUpdateFcns','on'); % Maximum identifier length
    set_param(DependencySet.RefModeNamesNoType{i},'ModelReferenceNumInstancesAllowed','Single'); % ModelReference\Total number of instances allowed per top model
    set_param(DependencySet.RefModeNamesNoType{i},'LogVarNameModifier','none'); % Code Generation\Interface\MAT-file variable name modifer
    set_param(DependencySet.RefModeNamesNoType{i},'MatFileLogging','off'); % Code Generation\Interface\MAT-file logging
    
    set_param(DependencySet.RefModeNamesNoType{i},'EnableMultiTasking','on'); % Treat each discrete rate as a separate task
    set_param(DependencySet.RefModeNamesNoType{i},'MultiTaskDSMMsg','warning'); % Detect data stores being read from and written to in multiple tasks
end
disp('模型新属性');
DependencySet = getModelProp(DependencySet,nRefModel);
showModelProp(DependencySet);
%% 保存设置
save_system(DependencySet.MainModelNameNoType,[],'SaveDirtyReferencedModels','on');
%% ------------------------------------------
function DependencySet = getModelProp(DependencySet,nRefModel)
for i = 1:nRefModel
    DependencySet.SolverType{i} = get_param(DependencySet.RefModeNamesNoType{i},'SolverType');
    DependencySet.Solver{i} = get_param(DependencySet.RefModeNamesNoType{i},'Solver');
    Ts = evalin('base',get_param(DependencySet.RefModeNamesNoType{i},'FixedStep'));
    DependencySet.SampleTime(i) = Ts;
    DependencySet.EnableMultiTasking{i} = get_param(DependencySet.RefModeNamesNoType{i},'EnableMultiTasking');
    DependencySet.DeviceVendor{i} = get_param(DependencySet.RefModeNamesNoType{i},'ProdHWDeviceType');
    DependencySet.SystemTargetFile{i} = get_param(DependencySet.RefModeNamesNoType{i},'SystemTargetFile');
    DependencySet.TargetLang{i} = get_param(DependencySet.RefModeNamesNoType{i},'TargetLang');
    DependencySet.ERTFilePackagingFormat{i} = get_param(DependencySet.RefModeNamesNoType{i},'ERTFilePackagingFormat');
    DependencySet.CombineOutputUpdateFcns{i} = get_param(DependencySet.RefModeNamesNoType{i},'CombineOutputUpdateFcns');
    DependencySet.MaxIdLength(i) = get_param(DependencySet.RefModeNamesNoType{i},'MaxIdLength');
    DependencySet.MultiTaskDSMMsg{i} = get_param(DependencySet.RefModeNamesNoType{i},'MultiTaskDSMMsg');
end
end
%
function showModelProp(DependencySet)
SolverType = DependencySet.SolverType';
Solver = DependencySet.Solver';
SampleTime = DependencySet.SampleTime';
EnableMultiTasking = DependencySet.EnableMultiTasking';
DeviceVendor = DependencySet.DeviceVendor';
SystemTargetFile = DependencySet.SystemTargetFile';
TargetLang = DependencySet.TargetLang';
ERTFilePackagingFormat = DependencySet.ERTFilePackagingFormat';
CombineOutputUpdateFcns = DependencySet.CombineOutputUpdateFcns';
MaxIdLength = DependencySet.MaxIdLength';
T = table(SolverType,Solver,SampleTime,EnableMultiTasking,DeviceVendor,SystemTargetFile,...
    TargetLang,ERTFilePackagingFormat,CombineOutputUpdateFcns,MaxIdLength,EnableMultiTasking);
T.Properties.RowNames = DependencySet.RefModeNamesNoType'
end