plotmode = '3d';
homeLLA = [STRUCT_mavlink_mission_item_def_ARRAY(1).x,...
    STRUCT_mavlink_mission_item_def_ARRAY(1).y,...
    STRUCT_mavlink_mission_item_def_ARRAY(1).z];
switch plotmode
    case '2d' 
        figure(1)
        lat = out.LLA.Data(:,1);
        lon = out.LLA.Data(:,2);
        shot_lat = out.Payload.CAMERA.LLA.Data(:,1); shot_lat(shot_lat==0)=nan;
        shot_lon = out.Payload.CAMERA.LLA.Data(:,2); shot_lon(shot_lon==0)=nan;
        shot_height = out.Payload.CAMERA.LLA.Data(:,3);        
        plot(lon,lat,'b');hold on;
        plot(shot_lon,shot_lat,'b*');hold on;
        plot(homeLLA(2),homeLLA(1),'r+');hold on;
        for i = 1:TASK_SET.PATH.maxNum
            curlat = STRUCT_mavlink_mission_item_def_ARRAY(i).x;
            curlon = STRUCT_mavlink_mission_item_def_ARRAY(i).y;
            if curlat ~= TASK_SET.PATH.nanFlag
                plot(curlon,curlat,'ro');hold on;
                if STRUCT_mavlink_mission_item_def_ARRAY(i+1).x ~= TASK_SET.PATH.nanFlag && i > 1
                    nextlat = STRUCT_mavlink_mission_item_def_ARRAY(i+1).x;
                    nextlon = STRUCT_mavlink_mission_item_def_ARRAY(i+1).y;
                    plot([curlon,nextlon],...
                        [curlat,nextlat],'r--');hold on;
                else
                    
                end
            end
        end
        xlabel('lon')
        ylabel('lat')
        grid on;
        axis equal;
    case '3d' 
        figure(1)
        lat = out.LLA.Data(:,1);
        lon = out.LLA.Data(:,2);
        shot_lat = out.Payload.CAMERA.LLA.Data(:,1); shot_lat(shot_lat==0)=nan;
        shot_lon = out.Payload.CAMERA.LLA.Data(:,2); shot_lon(shot_lon==0)=nan;
        shot_height = out.Payload.CAMERA.LLA.Data(:,3);
        height = out.LLA.Data(:,3);
        plot3(lon,lat,height,'b');hold on;
        plot3(shot_lon,shot_lat,shot_height,'b*');hold on;
        plot(homeLLA(2),homeLLA(1),'r+');hold on;
        for i = 1:TASK_SET.PATH.maxNum-1
            curlat = STRUCT_mavlink_mission_item_def_ARRAY(i).x;
            curlon = STRUCT_mavlink_mission_item_def_ARRAY(i).y;
            curheight = STRUCT_mavlink_mission_item_def_ARRAY(i).z;
            if curlat ~= TASK_SET.PATH.nanFlag
                plot3(curlon,curlat,curheight,'ro');hold on;
                if STRUCT_mavlink_mission_item_def_ARRAY(i+1).x ~= TASK_SET.PATH.nanFlag && i > 1
                    nextlat = STRUCT_mavlink_mission_item_def_ARRAY(i+1).x;
                    nextlon = STRUCT_mavlink_mission_item_def_ARRAY(i+1).y;
                    nextheight = STRUCT_mavlink_mission_item_def_ARRAY(i+1).z;
                    plot3([curlon,nextlon],...
                        [curlat,nextlat],[curheight,nextheight],'r--');hold on;
                else
                    
                end
            end
        end        
%         for i = 1:TASK_SET.PATH.maxNum
%             if TASK_SET.PATH.paths_m(i,1) ~= TASK_SET.PATH.nanFlag
%                 plot3(TASK_SET.PATH.paths_ddm(i,2),TASK_SET.PATH.paths_ddm(i,1),TASK_SET.PATH.paths_ddm(i,3),'ro');hold on;
%                 if TASK_SET.PATH.paths_m(i+1,1) ~= TASK_SET.PATH.nanFlag && i > 1
%                     plot3([TASK_SET.PATH.paths_ddm(i,2),TASK_SET.PATH.paths_ddm(i+1,2)],...
%                           [TASK_SET.PATH.paths_ddm(i,1),TASK_SET.PATH.paths_ddm(i+1,1)],...
%                           [TASK_SET.PATH.paths_ddm(i,3),TASK_SET.PATH.paths_ddm(i+1,3)],'r--');hold on;
%                 end
%             end
%         end
        xlabel('lon')
        ylabel('lat')
        grid on;
        set(gca,'DataAspectRatio' ,[1 1 1e4])
end
%% 模式曲线
res_TaskMode = out.PathModeOut.flightTaskMode.Data;
res_RTInfo = out.RTInfo.Task.Data;
res_ControlMode = out.PathModeOut.flightControlMode.Data;
res_uavMode = out.PathModeOut.uavMode.Data;
if 0
figure
% 任务模式作图
subplot(221)
data = res_TaskMode;
plotEnum(data);
legend('flightTaskMode')
% 控制模式
subplot(222)
data = res_ControlMode;
plotEnum(data);
legend('flightControlMode')
% 飞机模式
subplot(223)
data = res_uavMode;
plotEnum(data);
legend('uavMode')
% RT information Task
subplot(224)
data = res_RTInfo;
plotEnum(data);
legend('RTinfo')
end
%% 
tempPre = permute(out.PathModeOut.prePathPoint_LLA.Data,[3,2,1]);
tempPre(tempPre(:,1) == 0,:) = [];
tempCur = permute(out.PathModeOut.curPathPoint_LLA.Data,[3,2,1]);
tempCur(tempCur(:,1) == 0,:) = [];
if 1
figure(1);
plot(tempPre(:,2),tempPre(:,1),'r*');hold on;
plot(tempCur(:,2),tempCur(:,1),'ko');hold on;
end
if 0
prePathPoint_LLA1(prePathPoint_LLA1==0) = [];
prePathPoint_LLA0(prePathPoint_LLA0==0) = [];
curPathPoint_LLA1(curPathPoint_LLA1==0) = [];
curPathPoint_LLA0(curPathPoint_LLA0==0) = [];
figure;
plot(prePathPoint_LLA1,prePathPoint_LLA0,'ro');hold on;
plot(curPathPoint_LLA1,curPathPoint_LLA0,'b*');hold on;
grid on;
axis equal
legend('前置航点','当前航点')
end

% 盘旋点
plot(out.PathModeOut.turnCenterLL.Data(out.PathModeOut.turnCenterLL.Data(:,2)~=0,2),out.PathModeOut.turnCenterLL.Data(out.PathModeOut.turnCenterLL.Data(:,2)~=0,1),'ko');