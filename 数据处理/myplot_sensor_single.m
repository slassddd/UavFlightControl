function [meandata,stddata] = myplot_sensor_single(sensorInput,sensorType,plotOpt,stepSpace)
%% ----------  传感器输出  ----------
for i_sensor = 1:length(sensorInput)
    sensors = sensorInput(i_sensor);
    nColor = length(plotOpt.color);
    nStyle = length(plotOpt.linestyle);
    idx_color = rem(i_sensor,nColor)+1;
    idx_style = ceil(i_sensor/nColor);
    idx_color = rem(idx_color,nColor) + 1;
    idx_style = rem(idx_style,nStyle) + 1;
    switch lower(sensorType)
        case 'gyro'
            fid.Name = 'Gyro陀螺';
            % 加速度
            data = [sensors.IMU.gx,sensors.IMU.gy,sensors.IMU.gz];
            time = sensors.IMU.time_imu;
            thisYlabel = plotOpt.ylabel_omegad;  % ylabel
            thisYlim = plotOpt.ylim_omegad;        % ylim            
        case 'acc'
            fid.Name = 'ACC加速度计';
            % 加速度
            data = [sensors.IMU.ax,sensors.IMU.ay,sensors.IMU.az];
            time = sensors.IMU.time_imu;
            thisYlabel = plotOpt.ylabel_AB_ms2;  % ylabel
            thisYlim = plotOpt.ylim_AB_ms2;        % ylim
        case 'mag1'
            fid.Name = 'Mag1磁力计';
            % 加速度
            data = [sensors.Mag.mag1_x,sensors.Mag.mag1_y,sensors.Mag.mag1_z];
            time = sensors.IMU.time_imu;
            thisYlabel = plotOpt.ylabel_magB_Gs;  % ylabel
            thisYlim = plotOpt.ylim_magB_Gs;        % ylim   
        case 'mag2'
            fid.Name = 'Mag2磁力计';
            % 加速度
            data = [sensors.Mag.mag2_x,sensors.Mag.mag2_y,sensors.Mag.mag2_z];
            time = sensors.IMU.time_imu;
            thisYlabel = plotOpt.ylabel_magB_Gs;  % ylabel
            thisYlim = plotOpt.ylim_magB_Gs;        % ylim   
        case 'mag3'
            fid.Name = 'Mag3磁力计';
            % 加速度
            data = [sensors.Mag.mag3_x,sensors.Mag.mag3_y,sensors.Mag.mag3_z];
            time = sensors.IMU.time_imu;
            thisYlabel = plotOpt.ylabel_magB_Gs;  % ylabel
            thisYlim = plotOpt.ylim_magB_Gs;        % ylim               
        case 'gpspos'
            fid.Name = 'GPS位置';
            % 加速度
            data = sensors.GPS.posmNED;
            time = sensors.GPS.time_ublox;
            thisYlabel = plotOpt.ylabel_posm;  % ylabel
            thisYlim = plotOpt.ylim_posm;        % ylim       
        case 'gpsvel'
            fid.Name = 'GPS速度';
            % 加速度
            data = [sensors.GPS.ublox_velN,sensors.GPS.ublox_velE,sensors.GPS.ublox_velD];
            time = sensors.GPS.time_ublox;
            thisYlabel = plotOpt.ylabel_velm;  % ylabel
            thisYlim = plotOpt.ylim_velm;        % ylim
        case 'baro'
            fid.Name = 'Baro气压高度计';
            % 加速度
            data = [sensors.Baro.altitue];
            time = sensors.Baro.time_baro;
            thisYlabel = plotOpt.ylabel_posm;  % ylabel
            thisYlim = plotOpt.ylim_posm;        % ylim
        case 'radar'
            fid.Name = 'Radar无线电高度计';
            % 加速度
            data = [sensors.Radar.radar_Range];
            time = sensors.Radar.time_radar;
            thisYlabel = plotOpt.ylabel_posm;  % ylabel
            thisYlim = plotOpt.ylim_posm;        % ylim            
        otherwise
            error('传感器类型设置错误！')
    end
    stepNum = size(data,1);
    idxspan = [1:stepSpace:stepNum];
    meandata(i_sensor,:) = round(mean(data),4);
    stddata(i_sensor,:) = round(std(data),4);
    nData = size(data,2);
    for i = 1:nData
        subplot(nData,1,i)
        plot(time(idxspan),data(idxspan,i),'color',plotOpt.color{idx_color},'linewidth',plotOpt.linewidth(1),'linestyle',plotOpt.linestyle{idx_style});
        hold(plotOpt.hold);
        grid(plotOpt.grid);
        xlabel(plotOpt.xlabel)
        ylabel(thisYlabel{i})  % ylabel
        ylim(thisYlim);        % ylim
        xlim(plotOpt.xlim_time);          % xlim
        str = '';
        if i_sensor == length(sensorInput)
            for j = 1:size(meandata,1)
                if j ~= size(meandata,1)
                    str = [str,'mean:',num2str(meandata(j,i)),'  std:',num2str(stddata(j,i)),''','''];
                else
                    str = [str,'mean:',num2str(meandata(j,i)),'  std:',num2str(stddata(j,i))];
                end
            end
            eval(['legend(''',str,''')'])
        end
    end
end