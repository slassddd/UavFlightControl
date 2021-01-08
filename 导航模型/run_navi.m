%% 通用参数设置
setGlobalParam();
%% 载入数据
if 0
    % 执行指定数据文件
    dataFileNames{1} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_9 大风 人为观察飞机姿态晃动严重，人为点击返航 2020-12-24 12-39-34.mat'];
%     dataFileNames{2} = [GLOBAL_PARAM.project.RootFolder{1},'\','SubFolder_飞行数据\20201224\仿真数据_3 着陆不加锁 2020-12-24 11-24-02.mat'];
else
    try
        dataFileNames = saveFileName;
        saveMatFileName(dataFileNames);
    catch
        load('lastFlightDataFileLoadedForNavi');
        fprintf('\n当前工作空间没有 dataFileNames, 读取最后一次载入的数据文件: %s\n\n',dataFileNames{1});
    end
end
%%
tspan0 = [0,100]; % sec   [0,inf]
%% 载入飞行数据并生成仿真格式数据
SimDataSet = loadFlightData(tspan0,dataFileNames,BUS_SENSOR);if ~SimDataSet.validflag,return;end
%% 设置机型变量
[SimParam.SystemInfo.planeMode,isCancel] = selPlaneMode();if isCancel,return;end % 选择机型 
%% 设置flight data模型参数
SimParam.FlightDataSimParam = INIT_FlightData();
%% 设置滤波参数
[SimParam.Navi,NAVI_PARAM_V10,NAVI_PARAM_V1000,NAVI_PARAM_BASE] = INIT_Navi( SimParam.SystemInfo.planeMode );
%% 传感器故障参数
[SimParam.SensorFault,SENSOR_FAULT] = INIT_SensorFault();
%% 传感器安装参数
[SENSOR_ALIGNMENT_PARAM_V1000,SENSOR_ALIGNMENT_PARAM_V10,SENSOR_ALIGNMENT_PARAM_V10_1] = INIT_SensorAlignment();
%% 信号检测
[SimParam.SensorIntegrity,SENSOR_INTEGRITY_PARAM_V1000,SENSOR_INTEGRITY_PARAM_V10,SENSOR_INTEGRITY_PARAM_BASE] = ...
    INIT_SensorIntegrity();
%% 视觉着陆
[SimParam.VLand,VISLANDING_PARAM_V1000,VISLANDING_PARAM_V10] = INIT_VisualLanding();
%% 运行仿真
modelname = 'TESTENV_NAVI';
simMode = 'serial';  % parallel serial
tic
switch simMode
    case 'parallel'
        for i = 1:SimDataSet.nFlightDataFile
            SimInput(i) = Simulink.SimulationInput(modelname);
            SimInput(i) = SimInput(i).setVariable('IN_TASK',SimDataSet.FlightLog_Original(i).OUT_TASKMODE);
            SimInput(i) = SimInput(i).setVariable('IN_SENSOR',SimDataSet.IN_SENSOR(i));
            SimInput(i) = SimInput(i).setVariable('tspan',SimDataSet.tspan{i});
        end
        out = parsim(SimInput,'UseFastRestart','off','TransferBaseWorkspaceVariables','off');
        %             'RunInBackground','on',...
    case 'serial'
        for i = 1:SimDataSet.nFlightDataFile
%             SimInput(i) = Simulink.SimulationInput(modelname); 
%             SimInput(i) = SimInput(i).setVariable('tspan',[0,200]); % setVariable 优先级大于工作空间
%             tic,out(i) = sim(SimInput(i));timeSpend = toc;
            IN_TASK = SimDataSet.FlightLog_Original(i).OUT_TASKMODE;
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
    [SimRes.Navi.MARG(i),SimRes.Navi.timeInit(i)] = getSimRes_Navi(out(i),SimParam.Navi.Ts_Base);
end
%% 仿真绘图
Plot_NaviSimData(SimRes,SimDataSet,GLOBAL_PARAM,dataFileNames)
% Plot_NaviLogTable();