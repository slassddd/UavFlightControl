function Plot_TaskSimData(out_set,TASK_PARAM_V1000,SimParam_GroundStation,TestCase)
%% 任务模块仿真数据绘图
for i = 1:length(out_set)
    this_out = out_set(i);
    if length(SimParam_GroundStation) == 1
        this_SimParam_GroundStation = SimParam_GroundStation(1);
    else
        this_SimParam_GroundStation = SimParam_GroundStation(i);
    end
    if length(TestCase.filename) == 1
        this_nameTestCase = TestCase.filename(1);
    else
        this_nameTestCase = TestCase.filename(i);
    end
    %% 任务模式绘图
    SinglePlot_TaskMode(this_out,this_nameTestCase);
    %% 绘制飞行轨迹地图
    SinglePlot_Position(this_out,TASK_PARAM_V1000,this_SimParam_GroundStation,this_nameTestCase);
end