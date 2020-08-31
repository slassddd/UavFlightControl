plotOpt = setPlotOpt;
stepSpace = 1;
plotEnable = 1;
if plotEnable
    % ------------  原算法数据 ---------------
    if 0
        figure(103)
        myplot_navfilter(sensors,plotOpt,1,1,stepSpace); % 显示组合导航数据
        myplot_navfilter(navFilterMARGRes(1),plotOpt,2,2,stepSpace); % 显示组合导航数据
    end
    % ------------  mag反算 ---------------
    if 0
        figure;
        time_m = IN_SENSOR.mag2.time;
        time_est = navFilterMARGRes(1).Algo.time_algo;
        euler_temp = [navFilterMARGRes(1).Algo.algo_yaw,navFilterMARGRes(1).Algo.algo_pitch,navFilterMARGRes(1).Algo.algo_roll];
        quat_temp = quaternion(euler_temp,'eulerd','ZYX','frame');
        magBody_m = -[sensors.Mag.mag2calib_y_magFrame,sensors.Mag.mag2calib_x_magFrame,sensors.Mag.mag2calib_z_magFrame];
        magNED_true = ones(size(quat_temp,1),1)*[30.15,0,44.98];
        magBody_est = rotateframe(quat_temp,magNED_true);
        plot(time_m,1e2*magBody_m,'r');hold on;
        plot(time_est,magBody_est,'b');hold on;
    end
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
        %
        if 1
            fig = figure(222);
            fig.Name = '滤波值 vs 测量值';
            myplot_sensor_filter_compare(sensors,navFilterMARGRes(i_sim),plotOpt,idx_color,idx_style,stepSpace);
        end
        if 0
            load([GLOBAL_PARAM.SubFolderName.FlightData,'\','仿真数据_log0_0107_PX4'])
            % 姿态
            figure(33)
            subplot(321)
            PX4yaw = NKF1(1:end-1,5);
            PX4yaw(PX4yaw>180) = PX4yaw(PX4yaw>180)-360;
            plot(NKF1(1:end-1,2)*1e-6,PX4yaw);hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_yaw);hold on;
            subplot(323)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,4));hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_pitch);hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_curr_vel_2,'k--');hold on;
            subplot(325)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,3));hold on;
            plot(navFilterMARGRes.Algo.time_algo,navFilterMARGRes.Algo.algo_roll);hold on;
            % 位置
            subplot(322)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,10));hold on;
            plot(navFilterMARGRes.Algo.time_algo,out.NavFilterRes.state.Data(:,5));hold on;
            subplot(324)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,11));hold on;
            plot(navFilterMARGRes.Algo.time_algo,out.NavFilterRes.state.Data(:,6));hold on;
            subplot(326)
            plot(NKF1(1:end-1,2)*1e-6,NKF1(1:end-1,12));hold on;
            plot(navFilterMARGRes.Algo.time_algo,out.NavFilterRes.state.Data(:,7));hold on;
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