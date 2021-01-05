if 0
    % 执行指定数据文件
    clear,clc
    proj = currentProject;
    dataFileNames{1} = [proj.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_9 大风 人为观察飞机姿态晃动严重，人为点击返航 2020-12-24 12-39-34.mat'];    
    dataFileNames{2} = [proj.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_3 着陆不加锁 2020-12-24 11-24-02.mat'];
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
%% 通用参数设置
SetGlobalParam();
%%
Ts_Compass.Ts_base = 0.012;
%%
%% 载入飞行数据并生成仿真格式数据
tspan0 = [0,inf]; % sec   [0,inf]
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR_SET(i),IN_SENSOR_SIM_SET(i),tspan_SET{i},timeSpanValidflag,SL(i)] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    if ~timeSpanValidflag
        str = sprintf('时间设置错误: 中止时间(%d) < 起始时间(%d)',int64(tspan_SET{i}(2)),int64(tspan_SET{i}(1)));
        warndlg(str)
        return;
    else
        fprintf('仿真数据的IMU时间范围 [%.2f, %.2f]\n',tspan_SET{i}(1),tspan_SET{i}(2))
    end
end
%% 设置机型变量
PlaneMode.mode = selParamForPlaneMode();
%% 设置滤波参数
INIT_Navi;
%% 设置飞机参数
% INIT_UAV
%% 任务初始化
% INIT_TASK
%% 地面站指令
% INIT_GROUNDSTATION
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
% modelname = 'TESTENV_NAVI_12ms';
simMode = 'serial';  % parallel serial
switch simMode
    case 'parallel'
        tic
%         SIM_FLIGHTDATA_IN(nFlightDataFile) = Simulink.SimulationInput(modelname);
        for i = 1:nFlightDataFile
            SIM_FLIGHTDATA_IN(i) = Simulink.SimulationInput(modelname);
            IN_TASK = SL(i).OUT_TASKMODE;
            IN_SENSOR = IN_SENSOR_SET(i);
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('IN_SENSOR',IN_SENSOR_SET(i));
            SIM_FLIGHTDATA_IN(i) = SIM_FLIGHTDATA_IN(i).setVariable('tspan',tspan_SET{i});
        end
        out = parsim(SIM_FLIGHTDATA_IN,...
            'UseFastRestart','off',...
            'TransferBaseWorkspaceVariables','on');
        %             'RunInBackground','on',...
        for i = 1:nFlightDataFile
            [navFilterMARGRes_SET(i),t_alignment(i)] = PostDataHandle_SimulinkModel(out(i),Ts_Compass.Ts_base);
        end
        timeSpend = toc;
        fprintf('仿真完成, 耗时 %.2f [s]\n',timeSpend);
    case 'serial'
        for i = 1:nFlightDataFile
            IN_TASK = SL(i).OUT_TASKMODE;
            IN_SENSOR = IN_SENSOR_SET(i);
            tspan = tspan_SET{i};
            % 仿真
            tic,out(i) = sim(modelname);timeSpend = toc;
            % 数据后处理
            [navFilterMARGRes_SET(i),t_alignment(i)] = PostDataHandle_SimulinkModel(out(i),Ts_Compass.Ts_base);
            fprintf('第%d组数据的仿真完成, 耗时 %.2f [s]\n',i,timeSpend);
        end
end
%% 仿真绘图
Plot_NaviSimData();
% Plot_NaviLogTable();