% 仿真数据绘制
nSim = nFlightDataFile;
plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    navFilterMARGRes = navFilterMARGRes_SET(1);    
    % ------------  传感器数据 ---------------
    fig = figure(102);
    GLOBAL_PARAM.hPlot.PlotSensor({'IMU1;IMU2;IMU3','mag1;mag2','ublox1','baro1','radar1','airspeed1'},IN_SENSOR(1),2,2,fig)
    if 0
        fig = figure(103);
        GLOBAL_PARAM.hPlot.PlotPosition({'ublox1;um482'},IN_SENSOR(1),'XY',2,2,fig);
    end
    % ------------  MARG滤波器 ---------------
    plotOpt.hold = 'on';
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    for i_sim = 1:nSim
        navFilterMARGRes = navFilterMARGRes_SET(i_sim);
        navFilterMARGRes_OnLine = SL(i_sim).Filter;
        IN_SENSOR = IN_SENSOR_SET(i_sim);
        idx_color = rem(i_sim,nColor)+1;
        idx_style = ceil(i_sim/nColor);
        idx_color = rem(idx_color,nColor) + 1;
        idx_style = rem(idx_style,nStyle) + 1;
        
        SinglePlot_MARG
        
        if isempty(t_alignment(i_sim))
            fprintf('未能成功完成初对准\n')
        else
            fprintf('初对准完成时间: %.2f \n',t_alignment(i_sim))
        end
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
end