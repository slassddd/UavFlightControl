function Plot_NaviSimData(SimRes,SimDataSet,dataFileNames,varargin)
global GLOBAL_PARAM
idxSel = [];
if length(varargin) == 1
    idxSel = varargin{1}; % 选择进行指定数据的绘制  [2,3]
end
% 仿真数据绘制
nSim = SimDataSet.nFlightDataFile;
nColor = length(GLOBAL_PARAM.plotOpt.color);
nStyle = length(GLOBAL_PARAM.plotOpt.linestyle);
fprintf('[%s] 仿真曲线\n',mfilename);
%
if isempty(idxSel)
    fprintf('%s绘制全部数据（%d）\n',GLOBAL_PARAM.Print.lineHead,nSim);
    idxToPlot = 1:nSim;
else
    fprintf('%s绘制指定数据',GLOBAL_PARAM.Print.lineHead);
    for i = 1:length(idxSel)
        fprintf(' %d ',idxSel(i));
    end
    fprintf('\n');
    idxToPlot = idxSel;
end
for i_sim = idxToPlot
    fprintf('%s%s数据%d %s\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,i_sim,dataFileNames{i_sim});
    navFilterMARGRes = SimRes.Navi.MARG(i_sim);
    navFilterMARGRes_OnLine = SimDataSet.FlightLog_Original(i_sim).Filter;
    IN_SENSOR = SimDataSet.IN_SENSOR(i_sim);
    idx_color = rem(i_sim,nColor)+1;
    idx_style = ceil(i_sim/nColor);
    idx_color = rem(idx_color,nColor) + 1;
    idx_style = rem(idx_style,nStyle) + 1;
    % 导航初始化完成时间
    if isempty(SimRes.Navi.timeInit(i_sim))
        fprintf('%s%s[WARNING] 未能成功完成初对准\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead)
    else
        fprintf('%s%s初对准完成时间: %.2f \n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,SimRes.Navi.timeInit(i_sim))
    end
    % 传感器数据 ---------------
    fig = figure(102);
    GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2;IMU3','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR,2,2,fig)
    if 0
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR,'XY',2,2,fig);
    end
    % MARG滤波器
    SinglePlot_MARG();
    if 1
        % 时间戳
        figure;
        plot(IN_SENSOR.IMU1.time(1:end-1),diff(IN_SENSOR.IMU1.time),'-');
        xlabel('time (sec)')
        ylabel('IMU1的数据记录间隔');
        grid on;
    end
    if 1
        SinglePlot_Online_Vs_Offline
    end
    % 绘制方差
    if 0
        SinglePlot_Pcov
    end
end