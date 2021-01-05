if 0
    % ִ��ָ�������ļ�
    clear,clc
    proj = currentProject;
    dataFileNames{1} = [proj.RootFolder{1},'\','SubFolder_��������\20201224\��������_9 ��� ��Ϊ�۲�ɻ���̬�ζ����أ���Ϊ������� 2020-12-24 12-39-34.mat'];    
    dataFileNames{2} = [proj.RootFolder{1},'\','SubFolder_��������\20201224\��������_3 ��½������ 2020-12-24 11-24-02.mat'];
else
    try
        dataFileNames = saveFileName;        
        [naviPath,name] = fileparts(which(mfilename));% ���ļ�����Ŀ¼����.mat�ļ�
        curPath = cd;   
        cd(naviPath);
        save lastFlightDataFileLoadedForNavi.mat dataFileNames
        cd(curPath);
        clear curPath naviPath name
    catch
        load('lastFlightDataFileLoadedForNavi');
        fprintf('\n��ǰ�����ռ�û�� dataFileNames, ��ȡ���һ������������ļ�: %s\n\n',dataFileNames{1});
    end
end
%% ͨ�ò�������
SetGlobalParam();
%%
Ts_Compass.Ts_base = 0.012;
%%
%% ����������ݲ����ɷ����ʽ����
tspan0 = [0,inf]; % sec   [0,inf]
nFlightDataFile = length(dataFileNames);
for i = 1:nFlightDataFile
    [IN_SENSOR_SET(i),IN_SENSOR_SIM_SET(i),tspan_SET{i},timeSpanValidflag,SL(i)] = step1_loadFlightData(tspan0,dataFileNames{i},BUS_SENSOR);
    if ~timeSpanValidflag
        str = sprintf('ʱ�����ô���: ��ֹʱ��(%d) < ��ʼʱ��(%d)',int64(tspan_SET{i}(2)),int64(tspan_SET{i}(1)));
        warndlg(str)
        return;
    else
        fprintf('�������ݵ�IMUʱ�䷶Χ [%.2f, %.2f]\n',tspan_SET{i}(1),tspan_SET{i}(2))
    end
end
%% ���û��ͱ���
PlaneMode.mode = selParamForPlaneMode();
%% �����˲�����
INIT_Navi;
%% ���÷ɻ�����
% INIT_UAV
%% �����ʼ��
% INIT_TASK
%% ����վָ��
% INIT_GROUNDSTATION
%% ���������ϲ���
INIT_SensorFault
%% ��������װ����
INIT_SensorAlignment
%% �źż��
INIT_SensorIntegrity
%% �Ӿ���½
INIT_VisualLanding
%% ���з���
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
        fprintf('�������, ��ʱ %.2f [s]\n',timeSpend);
    case 'serial'
        for i = 1:nFlightDataFile
            IN_TASK = SL(i).OUT_TASKMODE;
            IN_SENSOR = IN_SENSOR_SET(i);
            tspan = tspan_SET{i};
            % ����
            tic,out(i) = sim(modelname);timeSpend = toc;
            % ���ݺ���
            [navFilterMARGRes_SET(i),t_alignment(i)] = PostDataHandle_SimulinkModel(out(i),Ts_Compass.Ts_base);
            fprintf('��%d�����ݵķ������, ��ʱ %.2f [s]\n',i,timeSpend);
        end
end
%% �����ͼ
Plot_NaviSimData();
% Plot_NaviLogTable();