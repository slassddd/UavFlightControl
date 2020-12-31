plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    % ------------  MARG滤波器 ---------------
    plotOpt.hold = 'on';
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    for i_sim = 1:nSim
        idx_color = rem(i_sim,nColor)+1;
        idx_style = ceil(i_sim/nColor);
        idx_color = rem(idx_color,nColor) + 1;
        idx_style = rem(idx_style,nStyle) + 1;
        
        fid = figure(2);
        fid.Name = 'MARG';
        postplot_marg_flightdata(navFilterMARGRes(i_sim),plotOpt,idx_color,idx_style,stepSpace) %显示组合导航数据
        
        if isempty(t_alignment(i_sim))
            fprintf('未能成功完成初对准\n')
        else
            fprintf('初对准完成时间: %.2f \n',t_alignment(i_sim))
        end
        if 1
            % 算法对比： 离线 vs 在线
            SinglePlot_Online_Vs_Offline
        end
        % 绘制方差
        if 0
            SinglePlot_Pcov
        end        
    end
end