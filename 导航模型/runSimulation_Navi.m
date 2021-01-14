tic_all = tic;
SimParam.Basic.parallelMode = 'serial';  % parallel serial auto
SimParam.Basic.modelname = 'TESTENV_NAVI';
IN_TASK = SimDataSet.FlightLog_Original(1).OUT_TASKMODE;
IN_SENSOR = SimDataSet.IN_SENSOR(1);
tspan = SimDataSet.tspan{1};
% 设置仿真数据
for i = 1:SimDataSet.nFlightDataFile
    SimInput(i) = Simulink.SimulationInput(SimParam.Basic.modelname);
    SimInput(i) = SimInput(i).setVariable('IN_TASK',SimDataSet.FlightLog_Original(i).OUT_TASKMODE);
    SimInput(i) = SimInput(i).setVariable('IN_SENSOR',SimDataSet.IN_SENSOR(i));
    SimInput(i) = SimInput(i).setVariable('tspan',SimDataSet.tspan{i});
end
% 进行仿真
switch SimParam.Basic.parallelMode
    case 'parallel'
        fprintf('%s开始并行仿真\n',GLOBAL_PARAM.Print.lineHead);
        out = doParSim(SimInput);
    case 'serial'
        fprintf('%s开始串行仿真\n',GLOBAL_PARAM.Print.lineHead);
        out = doSerialSim(SimInput);
        %         for i = 1:SimDataSet.nFlightDataFile
        %             %             SimInput(i) = Simulink.SimulationInput(modelname);
        %             %             SimInput(i) = SimInput(i).setVariable('tspan',[0,200]); % setVariable 优先级大于工作空间
        %             %             tic,out(i) = sim(SimInput(i));timeSpend = toc;
        %             IN_TASK = SimDataSet.FlightLog_Original(i).OUT_TASKMODE;
        %             IN_SENSOR = SimDataSet.IN_SENSOR(i);
        %             tspan = SimDataSet.tspan{i};
        %             tic,out(i) = sim(SimParam.Basic.modelname);SimParam.Basic.timeSpend = toc;
        %             fprintf('第%d组数据的仿真完成, 耗时 %.2f [s]\n',i,SimParam.Basic.timeSpend);
        %         end
    case 'auto'
        if SimDataSet.nFlightDataFile > 4
            fprintf('%s开始并行仿真\n',GLOBAL_PARAM.Print.lineHead);
            out = doParSim(SimInput);
        else
            fprintf('%s开始串行仿真\n',GLOBAL_PARAM.Print.lineHead);
            out = doSerialSim(SimInput);
        end
end
SimParam.Basic.timeSpend = toc(tic_all);
fprintf('%s仿真完成, 耗时 %.2f [s]\n',GLOBAL_PARAM.Print.lineHead,SimParam.Basic.timeSpend);
%% 子函数
% 并行仿真
function out = doParSim(in)
out = parsim(in,'UseFastRestart','off','TransferBaseWorkspaceVariables','off');
%             'RunInBackground','on',...
end
% 串行仿真
function out = doSerialSim(in)
out = sim(in);
end