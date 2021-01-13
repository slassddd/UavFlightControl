function Plot_TaskSimData(out_set,TASK_PARAM_V1000,SimParam_GroundStation,SimParam_TestCase)
%% 任务模块仿真数据绘图
for i = 1:length(out_set)
    out = out_set(i);
    nameTestCase = SimParam_TestCase.filename(i);
    %% 任务模式绘图
    SinglePlot_TaskMode(out,nameTestCase);
    %% 绘制飞行轨迹地图
    SinglePlot_Position(out,TASK_PARAM_V1000,SimParam_GroundStation,nameTestCase);
end