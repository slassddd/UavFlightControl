function [varname,isFind] = decodeLog_Navi(message,vars)
nMessage = length(message);
varname = cell(nMessage,5);
isFind = true;
for i = 1:nMessage
    thisMessage = message(i);
    var = vars(i,:);
    switch thisMessage
        case ENUM_RTInfo_Navi.RTIN_Filter_GPSVelErrorLarge
            varname(i,:) = {'周期','速度差','ublox速度','星数','BESTPOS'};
            % 数值规范化
            var(2) = round(var(2),2);
            var(3) = round(var(3),2);
            var(5) = round(var(5),2);
            % 生成显示内容
            str1_Ts = sprintf('%.3f[s]',var(1));
            str1_bestpos = sprintf('%s',ENUM_BESTPOS(var(5)));
            varname{i,1} = [varname{i,1},': ', str1_Ts];
            varname{i,2} = [varname{i,2},': ', num2str(var(2)),'[m/s]'];
            varname{i,3} = [varname{i,3},': ', num2str(var(3)),'[m/s]'];
            varname{i,4} = [varname{i,4},': ', num2str(var(4))];
            varname{i,5} = [varname{i,5},': ', str1_bestpos];        
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Ublox
            varname(i,:) = {'周期','状态','pdop','星数','速度标准差'};
            % 数值规范化
            var(3) = round(var(3),2);
            var(5) = round(var(5),2);
            % 生成显示内容
            str1_Ts = sprintf('%.3f[s]',var(1));
            str2_health = sprintf('%s',ENUM_SensorHealthStatus(var(2)));
            varname{i,1} = [varname{i,1},': ', str1_Ts];
            varname{i,2} = [varname{i,2},': ', str2_health];
            varname{i,3} = [varname{i,3},': ',num2str(var(3))];
            varname{i,4} = [varname{i,4},': ',num2str(var(4))];
            varname{i,5} = [varname{i,5},': ',num2str(var(5)),'[m/s]'];
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Um482
            varname(i,:) = {'周期','状态','pdop','星数','BESTPOS'};
            % 数值规范化
            var(3) = round(var(3),2);
            % 生成显示内容
            str1_Ts = sprintf('%.3f[s]',var(1));
            str2_health = sprintf('%s',ENUM_SensorHealthStatus(var(2)));
            str5_bestpos = sprintf('%s',ENUM_BESTPOS(round(var(5))));
            
            varname{i,1} = [varname{i,1},': ', str1_Ts];
            varname{i,2} = [varname{i,2},': ', str2_health];
            varname{i,3} = [varname{i,3},': ',num2str(var(3))];
            varname{i,4} = [varname{i,4},': ',num2str(var(4))];
            varname{i,5} = [varname{i,5},': ', str5_bestpos];
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Mag
            varname(i,:) = {'周期','当前设备号','1号mag','2号mag','地磁模值'};
            % 数值规范化
            var(5) = round(var(5),2);
            % 生成显示内容
            str1_Ts = sprintf('%.3f[s]',var(1));
            str3_health = sprintf('%s',ENUM_SensorHealthStatus(var(3)));
            str4_health = sprintf('%s',ENUM_SensorHealthStatus(var(4)));
            
            varname{i,1} = [varname{i,1},': ', str1_Ts];
            varname{i,2} = [varname{i,2},': ',num2str(var(2))];
            varname{i,3} = [varname{i,3},': ', str3_health];
            varname{i,4} = [varname{i,4},': ', str4_health];
            varname{i,5} = [varname{i,5},': ',num2str(var(5)),'[uT]'];
        case ENUM_RTInfo_Navi.RTIN_Filter_Fuse_Baro
            varname(i,:) = {'周期','状态','气压高','ublox高','um482高'};
            % 数值规范化
            var(3) = round(var(3),2);
            var(4) = round(var(4),2);
            var(5) = round(var(5),2);
            % 生成显示内容
            str1_Ts = sprintf('%.3f[s]',var(1));
            str2_health = sprintf('%s',ENUM_SensorHealthStatus(var(2)));
            
            varname{i,1} = [varname{i,1},': ', str1_Ts];
            varname{i,2} = [varname{i,2},': ', str2_health];
            varname{i,3} = [varname{i,3},': ',num2str(var(3)),'[m]'];
            varname{i,4} = [varname{i,4},': ',num2str(var(4)),'[m]'];
            varname{i,5} = [varname{i,5},': ',num2str(var(5)),'[m]'];
        case ENUM_RTInfo_Navi.RTIN_Filter_Param1
            varname(i,:) = {'KF状态','激活Az幅值补偿','激活Az模式补偿','激活零速矫正','激活Vd再融合'};
            % 数值规范化
            % 生成显示内容
            varname{i,1} = [varname{i,1},': ', num2str(var(1))];
            for j = 2:5
                if var(j) == 1
                    str{j} = 'true';
                else
                    str{j} = 'false';
                end
                varname{i,j} = [varname{i,j},': ', str{j}];
            end         
        otherwise
            isFind = false;
            for j = 1:5
                varname{i,j} = num2str(var(j));
            end
    end
end