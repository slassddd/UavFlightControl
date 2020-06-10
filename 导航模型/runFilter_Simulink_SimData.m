SimulinkRunMode = 2;
for i_sim = 1:nSim
    [ALGO_SET,sensorFs] = step2_setALGOparam_simData(PARALLEL_PARAM_SET(i_sim));
    %% ���˻���ز�����ʼ��
    INIT_UAV
    %% �����ʼ��
    INIT_TASK
    %% ���������ϲ���
    INIT_SensorFault
    %% ��������װ����
    INIT_SensorAlignment
    %% �źż��
    INIT_SensorIntegrity    
    %% ����
    tspan = [0,30];
    out(i_sim) = sim('model_navfilter');
    %% ���ݺ���
    [navFilterMARGRes(i_sim),t_alignment(i_sim)] = PostDataHandle_SimulinkModel(out(i_sim),sensorFs);
    %% �����ͼ
    plotOpt = setPlotOpt;
    stepSpace = 1;
    plotEnable = 1;
    % ------------  ԭ�㷨���� ---------------
    if 1
        figure(103)
        myplot_navfilter(navFilterMARGRes(i_sim),plotOpt,2,2,stepSpace); % ��ʾ��ϵ�������
    end
end
