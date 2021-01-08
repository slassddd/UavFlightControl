%% 通用参数设置
setGlobalParam();
%% 载入数据
if 1
    % 执行指定数据文件
    dataFileNames{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_9 大风 人为观察飞机姿态晃动严重，人为点击返航 2020-12-24 12-39-34.mat'];
%     dataFileNames{2} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_3 着陆不加锁 2020-12-24 11-24-02.mat'];
else
    try
        dataFileNames = saveFileName;
        [naviPath,name] = fileparts(which(mfilename));% 在文件所在目录保存.mat文件
        curPath = cd;
        cd(naviPath);
        save lastFlightDataFileLoadedForNavi.mat dataFileNames
        cd(curPath);
        clear curPath naviPath name
    catch
        load('lastFlightDataFileLoadedForNavi');
        fprintf('\n当前工作空间没有 dataFileNames, 读取最后一次载入的数据文件: %s\n\n',dataFileNames{1});
    end
end
%%
tspan0 = [0,300]; % sec   [0,inf]
%% 载入飞行数据并生成仿真格式数据
SimDataSet = loadFlightData(tspan0,dataFileNames,BUS_SENSOR);if ~SimDataSet.validflag,return;end
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
%% 设置滤波参数
INIT_Navi;
%% 传感器故障参数
INIT_SensorFault
%% 传感器安装参数
INIT_SensorAlignment
%% 信号检测
INIT_SensorIntegrity
%% 视觉着陆
INIT_VisualLanding
%% 运行仿真
modelname = 'TESTENV_NAVI';
simMode = 'serial';  % parallel serial
tic
switch simMode
    case 'parallel'
        for i = 1:SimDataSet.nFlightDataFile
            SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('IN_TASK',SimDataSet.SL(i).OUT_TASKMODE);
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('IN_SENSOR',SimDataSet.IN_SENSOR(i));
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('tspan',SimDataSet.tspan{i});
        end
        out = parsim(SIM_FLIGHTDATA_IN,'UseFastRestart','off','TransferBaseWorkspaceVariables','off');
        %             'RunInBackground','on',...
    case 'serial'
        for i = 1:SimDataSet.nFlightDataFile
            IN_TASK = SimDataSet.SL(i).OUT_TASKMODE;
            IN_SENSOR = SimDataSet.IN_SENSOR(i);
            tspan = SimDataSet.tspan{i};
            tic,out(i) = sim(modelname);timeSpend = toc;
            fprintf('第%d组数据的仿真完成, 耗时 %.2f [s]\n',i,timeSpend);
        end
end
timeSpend = toc;
fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
%% 数据后处理
for i = 1:SimDataSet.nFlightDataFile
    [navFilterMARGRes_SET(i),t_alignment(i)] = PostDataHandle_SimulinkModel(out(i),Ts_Navi.Ts_Base);
end
%% 仿真绘图
Plot_NaviSimData();
% Plot_NaviLogTable();