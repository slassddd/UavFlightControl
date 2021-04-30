function GroundStationParam = SetSimParam_GroundStation(TaskParam)
global GLOBAL_PARAM
%% 载入Bus
load('IOBusInfo_V1000');
%% 初始化地面站模块参数，包括仿真航线
GroundStationParam.Ts_base = 0.004; % 仿真步长 [sec]
% 结构体定义
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
% STRUCT_BUS_TASK_COMMON_OutParam =
% Simulink.Bus.createMATLABStruct('BUS_TASK_COMMON_OutParam');
%% 航线参数
m2deg = 1/111e3;
GSParam.PATH.pathHeight = 150;
homeHeight = GSParam.PATH.pathHeight + 0*200;
GroundStationParam.groundAltitude = 200;
GroundStationParam.mavlinkHome = [40.04 180 homeHeight]; %  lat lon alt
GSParam.PATH.nanFlag = TaskParam.nanFlag;
GSParam.PATH.maxNum = TaskParam.maxPathPointNum;
GSParam.PATH.speed = 18;
GSParam.PATH.paths_m = TaskParam.nanFlag*ones(GSParam.PATH.maxNum,3);

pathExmpale = 4;
pathoffset = [-600,-600]*m2deg.*[1,1/cos(GroundStationParam.mavlinkHome(1)*pi/180)];
pathmode = '耕地';
switch pathExmpale
    case 1 % 测试低电量沿航线返航逻辑
        data = [
            0        0   150;
            5     10e3   150;
            100    9e3   150;
           -100    8e3   150;
            150    6e3   150;
            100    5e3   150;
            200    4e3   150;
              0    3e3   150;
            200    2e3   150;
            100    1e3   150;
            300    0e3   150;];
        ndata = size(data,1);
        GSParam.PATH.paths_m(1:ndata,:) = data;
    case 2 % 单区航线
        pathoffset = [-0.2e3,-1.5e3]*m2deg.*[1,1/cos(GroundStationParam.mavlinkHome(1)*pi/180)];
        idxUnitedPath = 1;
        UnitedPath(idxUnitedPath).nPoints = 8*20;
        UnitedPath(idxUnitedPath).lon_left = 1e3;
        UnitedPath(idxUnitedPath).lon_right = 2e3;
        UnitedPath(idxUnitedPath).lat_space = 5;
        UnitedPath(idxUnitedPath).height = GSParam.PATH.pathHeight;
        UnitedPath(idxUnitedPath).angle = 0*pi;
        UnitedPath(idxUnitedPath).offset = [0,0];
        Aera1 = genLocalPath(UnitedPath(idxUnitedPath));
        tempNum = size(Aera1,1);
        
        Path0 = [0,0,GSParam.PATH.pathHeight];
        GSParam.PATH.paths_m(1,:) = Path0;
        GSParam.PATH.paths_m(2:tempNum+1,:) = [Aera1];
    case 3 % 联合航线
        % 航区1
        idxUnitedPath = 1;
        UnitedPath(idxUnitedPath).nPoints = 4;
        UnitedPath(idxUnitedPath).lon_left = 1e3;
        UnitedPath(idxUnitedPath).lon_right = 1.5e3;
        UnitedPath(idxUnitedPath).lat_space = 250;
        UnitedPath(idxUnitedPath).height = GSParam.PATH.pathHeight;
        UnitedPath(idxUnitedPath).angle = 0*pi;
        UnitedPath(idxUnitedPath).offset = [0,0];
        PathAeras{idxUnitedPath} = genLocalPath(UnitedPath(idxUnitedPath));
        % 航区2
        height = GSParam.PATH.pathHeight+200;
        PathAeras{idxUnitedPath} = [PathAeras{idxUnitedPath};PathAeras{idxUnitedPath}(end,1:2),height;PathAeras{idxUnitedPath}(end,1:2),height]; % 垂直方向的过渡航点, 为了方便设置航点类型，添加两个相同点
        
        idxUnitedPath = 2;
        UnitedPath(idxUnitedPath).nPoints = 4;
        UnitedPath(idxUnitedPath).lon_left = 1e3;
        UnitedPath(idxUnitedPath).lon_right = 1.3e3;
        UnitedPath(idxUnitedPath).lat_space = 150;
        UnitedPath(idxUnitedPath).height = height;
        UnitedPath(idxUnitedPath).angle = 0*pi;
        UnitedPath(idxUnitedPath).offset = [-1000,0];
        PathAeras{idxUnitedPath} = genLocalPath(UnitedPath(idxUnitedPath));
        % 航区3
        height = GSParam.PATH.pathHeight-50;
        PathAeras{idxUnitedPath} = [PathAeras{idxUnitedPath};PathAeras{idxUnitedPath}(end,1:2),height;PathAeras{idxUnitedPath}(end,1:2),height]; % 垂直方向的过渡航点, 为了方便设置航点类型，添加两个相同点
        
        idxUnitedPath = 3;
        UnitedPath(idxUnitedPath).nPoints = 4;
        UnitedPath(idxUnitedPath).lon_left = 1e3;
        UnitedPath(idxUnitedPath).lon_right = 1.4e3;
        UnitedPath(idxUnitedPath).lat_space = 150;
        UnitedPath(idxUnitedPath).height = height;
        UnitedPath(idxUnitedPath).angle = 0*pi;
        UnitedPath(idxUnitedPath).offset = [500,1000];
        PathAeras{idxUnitedPath} = genLocalPath(UnitedPath(idxUnitedPath));
        % 联合
        nPathAeras = length(PathAeras);
        AeraAll = [PathAeras{1};PathAeras{2};PathAeras{3}];
        Path0 = [0,0,GSParam.PATH.pathHeight];
        GSParam.PATH.paths_m(1,:) = Path0;
        
        tempNum = size(AeraAll,1);
        GSParam.PATH.paths_m(2:tempNum+1,:) = AeraAll;
%         pathoffset = [45e3,2000]*m2deg.*[1,1/cos(GroundStationParam.mavlinkHome(1)*pi/180)];
    case 4 % 电力巡线 —— 变高航线
        AeraAll = [
            1000     0    250;
            1000  1000    210;
           -1000  1000    270;
           -1000     0    130;
           -500      0    250];
        Path0 = [0,0,GSParam.PATH.pathHeight];
        GSParam.PATH.paths_m(1,:) = Path0;
        tempNum = size(AeraAll,1);
        GSParam.PATH.paths_m(2:tempNum+1,:) = AeraAll;
    case 5 % 电力巡线 —— 变高航线
        AeraAll = [
            1000     0    200;
            1000  1*300    200;
            1000  2*300    200;
            1000  3*300    200;
            1000  4*300    200;
            1000  5*300    200;
            1000  6*300    200;
            1000  7*300    200;
            1000  8*300    200;
            1000  9*300    200;
            1000  10*300    200;
            1000  11*300    200;
            1000  12*300    200;
            1000  13*300    200;
            1000  14*300    200;
            1000  15*300    200;
            1000  16*300    200;
            1000  17*300    200;
            1000  18*300    200;
            1000  19*300    200;
            1000  20*300    200;
            ];
        AeraAll(:,3) = [0 0 30 60 90 120 90 60 30 0 50 100 150 150 100 50 0 50 100 50 100]';
        Path0 = [0,0,GSParam.PATH.pathHeight];
        GSParam.PATH.paths_m(1,:) = Path0;
        tempNum = size(AeraAll,1);
        GSParam.PATH.paths_m(2:tempNum+1,:) = AeraAll;        
        pathmode = '条带';
end
GSParam.PATH.paths_ddm = GSParam.PATH.paths_m;
GSParam.PATH.paths_ddm(1,:) = GroundStationParam.mavlinkHome;

for i = 2:GSParam.PATH.maxNum
    if GSParam.PATH.paths_m(i,1) ~= GSParam.PATH.nanFlag
        GSParam.PATH.paths_ddm(i,1) = GroundStationParam.mavlinkHome(1) + GSParam.PATH.paths_m(i,1)*m2deg + pathoffset(1);
        GSParam.PATH.paths_ddm(i,2) = GroundStationParam.mavlinkHome(2) + GSParam.PATH.paths_m(i,2)*m2deg/cos(GroundStationParam.mavlinkHome(1)*pi/180) + pathoffset(2) ;
        GSParam.PATH.paths_ddm(i,3) = GSParam.PATH.paths_m(i,3);
    end
end
%%
pathSimMode = 'sim'; % 'sim' 'flight'
switch pathSimMode
    case 'sim'
        for i = 1:GSParam.PATH.maxNum
            GroundStationParam.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
            if strcmp(pathmode, '耕地')
                GroundStationParam.mavlinkPathPoints(i).param1 = rem(i,2);
            else
                GroundStationParam.mavlinkPathPoints(i).param1 = 1;
            end
            GroundStationParam.mavlinkPathPoints(i).seq = i; % 鑸偣搴忓垪鍙凤紙0锛欻ome鐐癸級
            GroundStationParam.mavlinkPathPoints(i).autocontinue = 1; % 鎮仠鎷愬集:0, 鍗忚皟鎷愬集:1
            GroundStationParam.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
            GroundStationParam.mavlinkPathPoints(i).x = single(GSParam.PATH.paths_ddm(i,1));  % lattitude
            GroundStationParam.mavlinkPathPoints(i).y = single(GSParam.PATH.paths_ddm(i,2));  % longitude
            GroundStationParam.mavlinkPathPoints(i).z = single(GSParam.PATH.paths_ddm(i,3));  % altitude
        end
        GroundStationParam.mavlinkPathPoints(1).z = max([GroundStationParam.mavlinkPathPoints.z]);
    case 'flight'
        filename = 'bb3a77e6787849198733a699b82b4be3(7).log';
        LogWPdata = importGroundStationLog(filename);
        for i = 1:GSParam.PATH.maxNum
            if i <= length(LogWPdata)
                GroundStationParam.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
                GroundStationParam.mavlinkPathPoints(i).param1 = LogWPdata(i).param1;
                GroundStationParam.mavlinkPathPoints(i).seq = i; % 鑸偣搴忓垪鍙凤紙0锛欻ome鐐癸級
                GroundStationParam.mavlinkPathPoints(i).autocontinue = 1; % 鎮仠鎷愬集:0, 鍗忚皟鎷愬集:1
                GroundStationParam.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
                GroundStationParam.mavlinkPathPoints(i).x = single(LogWPdata(i).lat);  % lattitude
                GroundStationParam.mavlinkPathPoints(i).y = single(LogWPdata(i).lon);  % longitude
                GroundStationParam.mavlinkPathPoints(i).z = single(LogWPdata(i).height);  % altitude
            else
                GroundStationParam.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
                GroundStationParam.mavlinkPathPoints(i).param1 = rem(i,2);
                GroundStationParam.mavlinkPathPoints(i).seq = i; % 鑸偣搴忓垪鍙凤紙0锛欻ome鐐癸級
                GroundStationParam.mavlinkPathPoints(i).autocontinue = 1; % 鎮仠鎷愬集:0, 鍗忚皟鎷愬集:1
                GroundStationParam.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
                GroundStationParam.mavlinkPathPoints(i).x = GSParam.PATH.paths_ddm(i,1);  % lattitude
                GroundStationParam.mavlinkPathPoints(i).y = GSParam.PATH.paths_ddm(i,2);  % longitude
                GroundStationParam.mavlinkPathPoints(i).z = GSParam.PATH.paths_ddm(i,3);  % altitude
            end
        end
end
%% home点上方对应的航线高度
GroundStationParam.mavlinkPathPoints(1).z = GroundStationParam.mavlinkPathPoints(1).z + 0*200;
GroundStationParam.mavlinkPathPoints1 = GroundStationParam.mavlinkPathPoints;
GroundStationParam.mavlinkPathPoints1(2).x = GroundStationParam.mavlinkPathPoints(2).x + 0.005;
GroundStationParam_Cmd76 = genMavCmd76Struct(); % 76# Mavlink 命令
GroundStationParam = combineStruct(GroundStationParam,GroundStationParam_Cmd76);
%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,GroundStationParam.Ts_base);
fprintf('%s地面站仿真参数(仅用于仿真):\n',GLOBAL_PARAM.Print.lineHead);
fprintf('%s%shome点海拔高度: %d [m]\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,GroundStationParam.groundAltitude);
switch pathExmpale
    case 2
        fprintf('%s%s航线模式: 单区\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
    case 3
        fprintf('%s%s航线模式: %d区联合航线\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,nPathAeras);
    case 4
        fprintf('%s%s航线模式: 电力巡线\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
end
pathHeights = [GroundStationParam.mavlinkPathPoints.z];
pathHeights = pathHeights(pathHeights>0);
nValidPath = length(pathHeights);
fprintf('%s%s总航点数(包括home点): %d\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,nValidPath);
fprintf('%s%s航点高度[m]: \t',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
fprintf('%d\t',unique(pathHeights))
fprintf('\n')
fprintf('%s%s0（1）号航点高度等于最高航点高度 (仿真模式下)\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead);
% fprintf('%s%s有效航点数: %d
% [m]\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,);
% fprintf('%s%s航线离地高度: %d
% [m]\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,GSParam.PATH.pathHeight);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);
if 1
    pathPlot = [...
        [GroundStationParam.mavlinkPathPoints(1:nValidPath).x]',...
        [GroundStationParam.mavlinkPathPoints(1:nValidPath).y]',...
        [GroundStationParam.mavlinkPathPoints(1:nValidPath).z]'
        ];
    figure;
    plot(pathPlot(:,2),pathPlot(:,1));hold on;
    plot(pathPlot(2:end,2),pathPlot(2:end,1),'bo');hold on;
    plot(pathPlot(1,2),pathPlot(1,1),'ro');hold on;
    grid on;
    xlabel('lon(deg)')
    ylabel('lat(deg)')
    axis equal
    test = 1;
end
%% 子函数
%
function LocalPath = genLocalPath(UnitedPath)
lon_left = UnitedPath.lon_left;
lon_right = UnitedPath.lon_right;
lat_space = UnitedPath.lat_space;
height = UnitedPath.height;
angle = UnitedPath.angle;
offset = UnitedPath.offset;
nPoints = UnitedPath.nPoints;

% LocalPath(1,:) = 0*[0*lat_space, 0.5*lon_left, height]; LocalPath(1,3) =
% height;
numLine = 0;
for i = 1:nPoints
    if rem(i,4) == 1
        lon_pos = lon_left;
    elseif rem(i,4) == 2
        lon_pos = lon_right;
    elseif rem(i,4) == 3
        lon_pos = lon_right;
    elseif rem(i,4) == 0
        lon_pos = lon_left;
    end
    if rem(i,2) == 1
        numLine = numLine + 1;
    end
    LocalPath(i,:) = [numLine*lat_space, lon_pos, height];
end
LocalPath = LocalPath + ones(nPoints,1)*[offset,0];
DCM = [cos(angle) sin(angle);
    -sin(angle) cos(angle);];
LocalPath(1:nPoints,1:2) = LocalPath(1:nPoints,1:2)*DCM;