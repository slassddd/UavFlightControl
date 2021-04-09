function SinglePlot_Position(out,TASK_PARAM_V1000,SimParam_GroundStation,nameTestCase)
% 航点信息
plotmode = '3d';
maxPathNum = TASK_PARAM_V1000.maxPathPointNum;
nanFlag = TASK_PARAM_V1000.nanFlag;
mavlinkPathData = SimParam_GroundStation.mavlinkPathPoints;
for i = 1:length(mavlinkPathData)
    if mavlinkPathData(i).x == 0 || mavlinkPathData(i).y == 0
        mavlinkPathData(i).x = nan;
        mavlinkPathData(i).y = nan;
    end
end
homeLLh = [mavlinkPathData(1).x,...
    mavlinkPathData(1).y,...
    mavlinkPathData(1).z];
breakLLh = unique( out.Task_TaskModeData.LLATaskInterrupt.Data, 'rows' );
breakLLh(breakLLh(:,1)==0,:) = [];
% 拍照位置
shot_lat = out.Task_payload.CAMERA.LLA.Data(:,1); shot_lat(shot_lat==0)=nan;
shot_lon = out.Task_payload.CAMERA.LLA.Data(:,2); shot_lon(shot_lon==0)=nan;
shot_height = out.Task_payload.CAMERA.LLA.Data(:,3);
% 飞行状态
% LLh = permute(out.Task_FlightData.curLLA.Data,[3,2,1]);
LLh = out.UavDyn_LLA.Data;
LLh(:,3) = LLh(:,3) - SimParam_GroundStation.groundAltitude;
% LLh(:,3) = out.Task_FlightData.curHeightForControl.Data;
zeroIdxLLh = find(LLh(:,1)<1e-5);
LLh(zeroIdxLLh,:) = nan*zeros(length(zeroIdxLLh),3);
lat = LLh(:,1);
lon = LLh(:,2);
height = LLh(:,3);
figure('Name',[nameTestCase{1},' —— TaskData']);
switch plotmode
    case '2d'
        plot(lon,lat,'b');hold on;
        plot(shot_lon,shot_lat,'b*');hold on;
        plot(homeLLh(2),homeLLh(1),'r+');hold on;
        if ~isempty(breakLLh)
            plot(breakLLh(end,2),breakLLh(end,1),'Marker','diamond','color','g');hold on;
        end
        for i = 1:maxPathNum
            curlat = mavlinkPathData(i).x;
            curlon = mavlinkPathData(i).y;
            if curlat ~= nanFlag
                plot(curlon,curlat,'ro');hold on;
                if mavlinkPathData(i+1).x ~= nanFlag && i > 1
                    nextlat = mavlinkPathData(i+1).x;
                    nextlon = mavlinkPathData(i+1).y;
                    plot([curlon,nextlon],...
                        [curlat,nextlat],'r--');hold on;
                else
                    
                end
            else
                validPathNum = i - 1;
                break;
            end
        end
        xlabel('lon')
        ylabel('lat')
        grid on;
        axis equal;
    case '3d'
        plot3(lon,lat,height,'b');hold on;
        plot3(shot_lon,shot_lat,shot_height,'b*');hold on;
        if ~isempty(breakLLh)
            plot3(breakLLh(end,2),breakLLh(end,1),breakLLh(end,3),'Marker','diamond','color','g');hold on;
        end
        plot(homeLLh(2),homeLLh(1),'r+');hold on;
        for i = 1:maxPathNum-1
            curlat = mavlinkPathData(i).x;
            curlon = mavlinkPathData(i).y;
            curheight = mavlinkPathData(i).z;
            if curlat ~= nanFlag
                plot3(curlon,curlat,curheight,'ro');hold on;
                if mavlinkPathData(i+1).x ~= nanFlag && i > 1
                    nextlat = mavlinkPathData(i+1).x;
                    nextlon = mavlinkPathData(i+1).y;
                    nextheight = mavlinkPathData(i+1).z;
                    plot3([curlon,nextlon],...
                        [curlat,nextlat],[curheight,nextheight],'r--');hold on;
                else
                    
                end
            else
                validPathNum = i - 1;
                break;
            end
        end
        xlabel('lon')
        ylabel('lat')
        zlabel('height(不是海拔)')
        grid on;
        set(gca,'DataAspectRatio' ,[1 1 1e4])
end
%% 模式曲线
res_TaskMode = out.Task_TaskModeData.flightTaskMode.Data;
res_RTInfo = out.Task_RTInfo.Task.Data;
res_ControlMode = out.Task_TaskModeData.flightControlMode.Data;
res_uavMode = out.Task_TaskModeData.uavMode.Data;
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
%% 绘制航点 （包括中间航点）
prePathPoints = permute(out.Task_TaskModeData.prePathPoint_LLA.Data,[3,2,1]);
prePathPoints(prePathPoints(:,1) == 0,:) = [];
curPathPoints = permute(out.Task_TaskModeData.curPathPoint_LLA.Data,[3,2,1]);
pathtime = out.Task_TaskModeData.curPathPoint_LLA.Time;
pathtime(curPathPoints(:,1) == 0,:) = [];
curPathPoints(curPathPoints(:,1) == 0,:) = [];
switch plotmode
    case '2d'
        plot(prePathPoints(:,2),prePathPoints(:,1),'r*');hold on;
        plot(curPathPoints(:,2),curPathPoints(:,1),'ko');hold on;
    case '3d'
        plot3(prePathPoints(:,2),prePathPoints(:,1),prePathPoints(:,3),'r*');hold on;
        plot3(curPathPoints(:,2),curPathPoints(:,1),curPathPoints(:,3),'ko');hold on;        
        if 0 
            figure;
            plot(pathtime,curPathPoints(:,3));
            grid on;
        end
%         plot3(prePathPoints(:,2),prePathPoints(:,1),mavlinkPathData(2).z*ones(size(prePathPoints(:,1))),'r*');hold on;
%         plot3(curPathPoints(:,2),curPathPoints(:,1),mavlinkPathData(2).z*ones(size(curPathPoints(:,1))),'ko');hold on;
end
%% 盘旋点
plot(out.Task_TaskModeData.turnCenterLL.Data(out.Task_TaskModeData.turnCenterLL.Data(:,2)~=0,2),out.Task_TaskModeData.turnCenterLL.Data(out.Task_TaskModeData.turnCenterLL.Data(:,2)~=0,1),'ko');
%% 地面高程
homeLLA = [mavlinkPathData(1).x, ...
    mavlinkPathData(1).y,        ...
    0 * SimParam_GroundStation.groundAltitude]; % home点高度为0
% 全局稀疏点
tempLat = [mavlinkPathData(1:validPathNum).x];
tempLon = [mavlinkPathData(1:validPathNum).y];
spanLat = [min(tempLat),max(tempLat)];
spanLon = [min(tempLon),max(tempLon)];
dLat = spanLat(2)-spanLat(1);
dLon = spanLon(2)-spanLon(1);
spanLat = [min(tempLat)-0.5*dLat,max(tempLat)+0.5*dLat];
spanLon = [min(tempLon)-0.5*dLon,max(tempLon)+0.5*dLon];

[gridLon,gridLat] = meshgrid(spanLon(1):dLon/10:spanLon(2),spanLat(1):dLat/10:spanLat(2));
for i = 1:size(gridLat,1)
    for j = 1:size(gridLat,2)
        altGround(i,j) = altMap(homeLLA,[gridLat(i,j),gridLon(i,j)]); 
    end
end
mesh(gridLon,gridLat,altGround)
% 近home处密集点
tempLat = [mavlinkPathData(1:validPathNum).x];
dx = 1/111e3*150; %
spanLat = [homeLLA(1)-dx,homeLLA(1)+dx];
spanLon = [homeLLA(2)-dx,homeLLA(2)+dx];
dLat = spanLat(2)-spanLat(1);
dLon = spanLon(2)-spanLon(1);
% spanLat = [min(tempLat)-0.5*dLat,max(tempLat)+0.5*dLat];
% spanLon = [min(tempLon)-0.5*dLon,max(tempLon)+0.5*dLon];

[gridLon,gridLat] = meshgrid(spanLon(1):dLon/110:spanLon(2),spanLat(1):dLat/110:spanLat(2));
for i = 1:size(gridLat,1)
    for j = 1:size(gridLat,2)
        altGround(i,j) = altMap(homeLLA,[gridLat(i,j),gridLon(i,j)]); 
    end
end
mesh(gridLon,gridLat,altGround)
%
colorbar
% altMap(homeLLA,LatLon_deg)