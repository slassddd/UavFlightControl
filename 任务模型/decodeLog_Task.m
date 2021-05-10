function [varname,isFind] = decodeLog_Task(message,vars)
nMessage = length(message);
varname = cell(nMessage,5);
isFind = true;
for i = 1:nMessage
    thisMessage = message(i);
    var = vars(i,:);
    switch thisMessage
        case ENUM_RTInfo_Task.HeightStatus
            varname(i,:) = {'高度测量','雷达高','激光1','激光2','isHeightAvailable'};
            % 数值规范化
%             var(3) = round(var(3),2);
%             var(5) = round(var(5),2);
            % 生成显示内容
            try
                str1_Cmd = sprintf('%s',ENUM_HeightMeasStatus(var(1)));
            catch
                str1_Cmd = sprintf('%.2f',var(1));
            end
%             str2_health = sprintf('%s',ENUM_SensorHealthStatus(var(2)));
            varname{i,1} = [varname{i,1},': ', str1_Cmd];
            varname{i,2} = [varname{i,2},': ',num2str(var(2))];
            varname{i,3} = [varname{i,3},': ',num2str(var(3))];
            varname{i,4} = [varname{i,4},': ',num2str(var(4))];
            varname{i,5} = [varname{i,5},': ',num2str(var(5))];            
        case ENUM_RTInfo_Task.TaskLog_Mav_CmdChange
            varname(i,:) = {'命令号','param1','','','电量'};
            % 数值规范化
            var(3) = round(var(3),2);
            var(5) = round(var(5),2);
            % 生成显示内容
            try
                str1_Cmd = sprintf('%s',ENUM_Mav76(var(1)));
            catch
                str1_Cmd = sprintf('%.2f',var(1));
            end
%             str2_health = sprintf('%s',ENUM_SensorHealthStatus(var(2)));
            varname{i,1} = [varname{i,1},': ', str1_Cmd];
            varname{i,2} = [varname{i,2},': ',num2str(var(2))];
            varname{i,3} = [varname{i,3},': ',num2str(var(3))];
            varname{i,4} = [varname{i,4},': ',num2str(var(4))];
            varname{i,5} = [varname{i,5},': ',num2str(100*var(5)),'%'];
        case ENUM_RTInfo_Task.TaskLog_Payload_Camera_Shot
            varname(i,:) = {'拍照数','纬度','经度','高度','电量'};
            % 数值规范化
            var(4) = round(var(5),2);
            % 生成显示内容
            varname{i,1} = [varname{i,1},': ',num2str(var(1))];
            varname{i,2} = [varname{i,2},': ',num2str(var(2)),'[deg]'];
            varname{i,3} = [varname{i,3},': ',num2str(var(3)),'[deg]'];
            varname{i,4} = [varname{i,4},': ',num2str(var(4))];
            varname{i,5} = [varname{i,5},': ',num2str(100*var(5)),'%'];
        case ENUM_RTInfo_Task.SystemTimeUpdate
            varname(i,:) = {'起飞时刻','','','',''};
            % 数值规范化
            var(4) = round(var(5),2);
            % 生成显示内容
            varname{i,1} = [varname{i,1},': ',num2str(var(1)),' 年'];
            varname{i,2} = [num2str(var(2)),' 月'];
            varname{i,3} = [num2str(var(3)),' 日'];
            varname{i,4} = [num2str(var(4)),' 时'];
            varname{i,5} = [num2str(var(4)),' 分'];  
        case ENUM_RTInfo_Task.SystemInfoUpdate
            varname(i,:) = {'机型','大模型版本','控制版本','',''};
            % 数值规范化
            % 生成显示内容
            varname{i,1} = [varname{i,1},': ',num2str(var(1))];
            varname{i,2} = [varname{i,2},': ',num2str(var(2))];
            varname{i,3} = [varname{i,3},': ',num2str(var(3))];
            varname{i,4} = [];
            varname{i,5} = [];            
        case ENUM_RTInfo_Task.FlightControlMode_Changed
            varname(i,:) = {'前置控制','当前控制','前置任务','当前任务',''};
            % 数值规范化
            % 生成显示内容
            str1_mode = sprintf('%s',ENUM_FlightControlMode(var(1)));
            str2_mode = sprintf('%s',ENUM_FlightControlMode(var(2)));
            str3_mode = sprintf('%s',ENUM_FlightTaskMode(var(3)));
            str4_mode = sprintf('%s',ENUM_FlightTaskMode(var(4)));            
            varname{i,1} = [varname{i,1},': ',str1_mode];
            varname{i,2} = [varname{i,2},': ',str2_mode];
            varname{i,3} = [varname{i,3},': ',str3_mode];
            varname{i,4} = [varname{i,4},': ',str4_mode];
            varname{i,5} = [];         
        case ENUM_RTInfo_Task.Land_Height_step
            varname(i,:) = {'阶段号','当前高度','区间下限','区间上限','着陆模式最大高度'};
            % 数值规范化
            var(2) = round(var(2),2);
            var(5) = round(var(5),2);
            % 生成显示内容
            varname{i,1} = [varname{i,1},': ',num2str(var(1))];
            varname{i,2} = [varname{i,2},': ',num2str(var(2)),' [m]'];
            varname{i,3} = [varname{i,3},': ',num2str(var(3)),' [m]'];
            varname{i,4} = [varname{i,4},': ',num2str(var(4)),' [m]'];
            varname{i,5} = [varname{i,5},': ',num2str(var(5)),' [m]']; 
        case {ENUM_RTInfo_Task.TaskLog_Protect_GoHome_BatteryLife,...
                ENUM_RTInfo_Task.TaskLog_Protect_GoHome_ActiveBatteryEst}
            varname(i,:) = {'触发返航','返航所需电量','着陆所需电量','预留电量','当前电量'};
            % 数值规范化
            % 生成显示内容
            if var(1) == 1
                str1_mode = 'true';
            else
                str1_mode = 'false';
            end                 
            varname{i,1} = [varname{i,1},': ',str1_mode];
            varname{i,2} = [varname{i,2},': ',num2str(var(2)),' [%]'];
            varname{i,3} = [varname{i,3},': ',num2str(var(3)),' [%]'];
            varname{i,4} = [varname{i,4},': ',num2str(var(4)),' [%]'];
            varname{i,5} = [varname{i,5},': ',num2str(100*var(5)),' [%]'];       
        case ENUM_RTInfo_Task.TaskLog_Protect_GoHome_EnforceFromPause
            varname(i,:) = {'暂停恢复返航次数','返航所需电量','着陆所需电量','预留电量','当前电量'};
            % 数值规范化
            % 生成显示内容              
            varname{i,1} = [varname{i,1},': ',num2str(var(1))];
            varname{i,2} = [varname{i,2},': ',num2str(var(2)),' [%]'];
            varname{i,3} = [varname{i,3},': ',num2str(var(3)),' [%]'];
            varname{i,4} = [varname{i,4},': ',num2str(var(4)),' [%]'];
            varname{i,5} = [varname{i,5},': ',num2str(100*var(5)),' [%]'];                 
        otherwise
            isFind = false;
            for j = 1:5
                varname{i,j} = num2str(var(j));
            end
    end
end