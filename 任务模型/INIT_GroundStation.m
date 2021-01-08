function GroundStationParam = INIT_GroundStation(TaskParam)
global GLOBAL_PARAM
%% 载入Bus
load('IOBusInfo_V1000');
%% 初始化地面站模块参数，包括仿真航线
GroundStationParam.Ts_base = 0.004; % 仿真步长 [sec]
% 结构体定义
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
% STRUCT_BUS_TASK_COMMON_OutParam = Simulink.Bus.createMATLABStruct('BUS_TASK_COMMON_OutParam');
%% 航线参数
deg2m = 1/111e3;
GSParam.PATH.pathHeight = 500;
homeHeight = GSParam.PATH.pathHeight + 0*200;
GroundStationParam.groundAltitude = 200;
GroundStationParam.mavlinkHome = [40.04 180 homeHeight]; %  lat lon alt
GSParam.PATH.nanFlag = TaskParam.nanFlag;
GSParam.PATH.maxNum = TaskParam.maxPathPointNum;
GSParam.PATH.speed = 18;
GSParam.PATH.paths_m = TaskParam.nanFlag*ones(GSParam.PATH.maxNum,3);

pathExmpale = 2;
switch pathExmpale
    case 1
        GSParam.PATH.paths_m(1:9,:) = [...
            1*1e3,0*1e3,GSParam.PATH.pathHeight;
            1*1e3,1*1e3,GSParam.PATH.pathHeight;
            0*1e3,1*1e3,GSParam.PATH.pathHeight;
            0*1e3,0*1e3,GSParam.PATH.pathHeight;
            -1*1e3,-1*1e3,GSParam.PATH.pathHeight;
            0*1e3,2*1e3,GSParam.PATH.pathHeight;
            2*1e3,3*1e3,GSParam.PATH.pathHeight;
            3*1e3,0*1e3,GSParam.PATH.pathHeight;
            5.1*1e3,5*1e3,GSParam.PATH.pathHeight;];
    case 2 % 鏍囧噯鐭╁舰娴嬪尯
        numLine = 0;
        lon_left = 1e3;
        lon_right = 2e3;
        lat_space = 150;
        %         lon_right = 1.5e3;
        %         lat_space = 50;
        GSParam.PATH.paths_m(1,:) = 0*[0*lat_space, 0.5*lon_left, GSParam.PATH.pathHeight];
        GSParam.PATH.paths_m(1,3) = GSParam.PATH.pathHeight;
        nPoints = 5;
        for i = 2:nPoints
            if rem(i,4) == 2
                lon_pos = lon_left;
            elseif rem(i,4) == 3
                lon_pos = lon_right;
            elseif rem(i,4) == 0
                lon_pos = lon_right;
            elseif rem(i,4) == 1
                lon_pos = lon_left;
            end
            if rem(i-1,2) == 1
                numLine = numLine + 1;
            end
            GSParam.PATH.paths_m(i,:) = [numLine*lat_space, lon_pos, GSParam.PATH.pathHeight];
        end
%         GSParam.PATH.paths_m(5,:) = GSParam.PATH.paths_m(4,:);
        angle = 0*pi;
        DCM = [cos(angle) sin(angle);
            -sin(angle) cos(angle);];
        GSParam.PATH.paths_m(1:nPoints,1:2) = GSParam.PATH.paths_m(1:nPoints,1:2)*DCM;
    case 3
        GSParam.PATH.paths_m(1:9,:) = [...
            1*1e2,0*1e3,GSParam.PATH.pathHeight;
            1*1e2,1*1e3,GSParam.PATH.pathHeight;
            2*1e2,1*1e3,GSParam.PATH.pathHeight;
            2*1e2,2*1e3,GSParam.PATH.pathHeight;
            4*1e2,2*1e3,GSParam.PATH.pathHeight;
            4*1e2,3*1e3,GSParam.PATH.pathHeight;
            5*1e2,3*1e3,GSParam.PATH.pathHeight;
            10*1e2,2*1e3,GSParam.PATH.pathHeight;
            16*1e2,2*1e3,GSParam.PATH.pathHeight;];
    case 4
        GSParam.PATH.paths_m(1:9,:) = [...
            0,0,GSParam.PATH.pathHeight;
            -1500,1500,GSParam.PATH.pathHeight;
            -1600,1600,GSParam.PATH.pathHeight;
            2*1e2,2*1e3,GSParam.PATH.pathHeight;
            4*1e2,2*1e3,GSParam.PATH.pathHeight;
            4*1e2,3*1e3,GSParam.PATH.pathHeight;
            5*1e2,3*1e3,GSParam.PATH.pathHeight;
            10*1e2,2*1e3,GSParam.PATH.pathHeight;
            16*1e2,2*1e3,GSParam.PATH.pathHeight;];
end
GSParam.PATH.paths_ddm = GSParam.PATH.paths_m;
GSParam.PATH.paths_ddm(1,:) = GroundStationParam.mavlinkHome;
for i = 2:GSParam.PATH.maxNum
    if GSParam.PATH.paths_m(i,1) ~= GSParam.PATH.nanFlag
        GSParam.PATH.paths_ddm(i,1) = GroundStationParam.mavlinkHome(1) + GSParam.PATH.paths_m(i,1)*deg2m - 0.01;
        GSParam.PATH.paths_ddm(i,2) = GroundStationParam.mavlinkHome(2) + GSParam.PATH.paths_m(i,2)*deg2m/cos(GroundStationParam.mavlinkHome(1)*pi/180) - 0.014;
        GSParam.PATH.paths_ddm(i,3) = GSParam.PATH.paths_m(i,3);
    end
end
%%
pathSimMode = 'sim'; % 'sim' 'flight'
switch pathSimMode
    case 'sim'
        for i = 1:GSParam.PATH.maxNum
            GroundStationParam.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
            GroundStationParam.mavlinkPathPoints(i).param1 = rem(i,2);
            GroundStationParam.mavlinkPathPoints(i).seq = i; % 鑸偣搴忓垪鍙凤紙0锛欻ome鐐癸級
            GroundStationParam.mavlinkPathPoints(i).autocontinue = 1; % 鎮仠鎷愬集:0, 鍗忚皟鎷愬集:1
            GroundStationParam.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
            GroundStationParam.mavlinkPathPoints(i).x = single(GSParam.PATH.paths_ddm(i,1));  % lattitude
            GroundStationParam.mavlinkPathPoints(i).y = single(GSParam.PATH.paths_ddm(i,2));  % longitude
            GroundStationParam.mavlinkPathPoints(i).z = single(GSParam.PATH.paths_ddm(i,3));  % altitude
        end
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
%% home鐐归澶栭珮搴�
                GroundStationParam.mavlinkPathPoints(1).z = GroundStationParam.mavlinkPathPoints(1).z + 0*200;
                
                GroundStationParam.mavlinkPathPoints1 = GroundStationParam.mavlinkPathPoints;
                GroundStationParam.mavlinkPathPoints1(2).x = GroundStationParam.mavlinkPathPoints(2).x + 0.005;
%%
% GroundStationParam.mavlinkPathPoints(4).param1 = 1;
GSParam.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch = 20;
GSParam.MavLinkInfo.DefaultCmdInfo.num_TakeOff = 23;
GSParam.MavLinkInfo.DefaultCmdInfo.num_AirStandBy = 28;
GSParam.MavLinkInfo.DefaultCmdInfo.num_Continue = 29;
GSParam.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude = 36;
GSParam.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor = 38; % 鍥哄畾缈艰浆鏃嬬考
GSParam.MavLinkInfo.DefaultCmdInfo.num_LandStart = 189;
GSParam.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist = 206;
GSParam.MavLinkInfo.CustomCmdInfo.num_StartProfile = 300; % 寮�濮嬫垨缁х画浠诲姟

GSParam.MavLinkInfo.CustomCmdInfo.num_GoIntoPath = 1001;
GSParam.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath = 1003; % 寮�濮嬫垨閲嶆柊寮�濮�
GSParam.MavLinkInfo.CustomCmdInfo.num_HoverAdjust = 1004; % 瀹氱偣鎮仠璋冩暣
GSParam.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix = 1006; % 鏃嬬考杞浐瀹氱考
GSParam.MavLinkInfo.CustomCmdInfo.num_CircleHover = 1007; % 瀹氱偣缁曞湀鐩樻棆
GSParam.MavLinkInfo.CustomCmdInfo.num_GroundStandBy = uint8(ENUM_MavlinkStandardCmd.MavCmd_EnterGroundStandby); % 杩涘叆鍦伴潰妯″紡
% 鎺у埗鎸囦护 -------------------------------------------------------------
% 鍐呯疆鎸囦护
GroundStationParam.CMD_GoHome = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GoHome.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch;  % 杩旇埅
GroundStationParam.CMD_AirStandBy = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_AirStandBy.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_AirStandBy;  % 鏆傚仠鐩樻棆
GroundStationParam.CMD_Continue = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Continue.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_Continue; % 缁х画
GroundStationParam.CMD_TakeOff = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_TakeOff.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_TakeOff; % 璧烽
GroundStationParam.CMD_SwitchAltitude = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_SwitchAltitude.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude; % 鍒囨崲楂樺害
GroundStationParam.CMD_SwitchAltitude.param1 = 50;
GroundStationParam.CMD_LandStart = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_LandStart.param1 = 1;
GroundStationParam.CMD_LandStart.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_LandStart; % 鐫�闄�
GroundStationParam.CMD_CamTriggDist = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_CamTriggDist.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist; % 鐩告満瑙﹀彂璺濈
GroundStationParam.CMD_CamTriggDist.param1 = 30;
% 鑷畾涔夋寚浠�
GroundStationParam.CMD_GoIntoPath = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GoIntoPath.command = GSParam.MavLinkInfo.CustomCmdInfo.num_GoIntoPath; % 杩涘叆鑸嚎
GroundStationParam.CMD_StartProfile = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_StartProfile.command = GSParam.MavLinkInfo.CustomCmdInfo.num_StartProfile; % 寮�濮嬫垨缁х画涔嬪墠涓柇鐨�
GroundStationParam.CMD_ReGoIntoPath = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_ReGoIntoPath.command = GSParam.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath; % 寮�濮嬫垨閲嶆柊寮�濮�
GroundStationParam.CMD_HoverAdjust = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_HoverAdjust.command = GSParam.MavLinkInfo.CustomCmdInfo.num_HoverAdjust; % 瀹氱偣鎮仠璋冩暣
GroundStationParam.CMD_Fix2Rotor = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Fix2Rotor.param1 = 1;
GroundStationParam.CMD_Fix2Rotor.command = GSParam.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor; % 瀹氱偣鎮仠璋冩暣
GroundStationParam.CMD_Rotor2Fix = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Rotor2Fix.command = GSParam.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix; % 瀹氱偣鎮仠璋冩暣
GroundStationParam.CMD_CircleHover = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_CircleHover.command = GSParam.MavLinkInfo.CustomCmdInfo.num_CircleHover; % 瀹氱偣鎮仠璋冩暣
GroundStationParam.CMD_GroundStandBy = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GroundStandBy.command = GSParam.MavLinkInfo.CustomCmdInfo.num_GroundStandBy; % 瀹氱偣鎮仠璋冩暣
%%
fprintf('[%s]\n',mfilename);
fprintf('%s周期: %.3f [sec]\n',GLOBAL_PARAM.Print.lineHead,GroundStationParam.Ts_base);
fprintf('%s地面站仿真参数(仅用于仿真):\n',GLOBAL_PARAM.Print.lineHead);
fprintf('%s%shome点海拔高度: %d [m]\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,GroundStationParam.groundAltitude);
% fprintf('%s%s有效航点数: %d [m]\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,);
fprintf('%s%s航线离地高度: %d [m]\n',GLOBAL_PARAM.Print.lineHead,GLOBAL_PARAM.Print.lineHead,GSParam.PATH.pathHeight);
fprintf('%s\n',GLOBAL_PARAM.Print.flagBegin);