Ts_GroundStation.Ts_base = 0.036;
%
mission_item_def.DataScope = 'Auto';
mission_item_def.HeaderFile = '';
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
STRUCT_BUS_TASK_COMMON_OutParam = Simulink.Bus.createMATLABStruct('BUS_TASK_COMMON_OutParam');
%% 航线
deg2m = 1/111e3;
pathHeight = 209;
homeHeight = pathHeight + 0*200;
TASK_SET.PATH.home = [40.04 116.367 homeHeight]; %  lat lon alt
TASK_SET.PATH.nanFlag = TASK_SET.PathPlanner.nanFlag;
TASK_SET.PATH.maxNum = TASK_SET.PathPlanner.maxPathPointNum;
TASK_SET.PATH.speed = 18;
TASK_SET.PATH.paths_m = TASK_SET.PATH.nanFlag*ones(TASK_SET.PATH.maxNum,3);

pathExmpale = 2;
switch pathExmpale
    case 1
        TASK_SET.PATH.paths_m(1:9,:) = [...
            1*1e3,0*1e3,pathHeight;
            1*1e3,1*1e3,pathHeight;
            0*1e3,1*1e3,pathHeight;
            0*1e3,0*1e3,pathHeight;
            -1*1e3,-1*1e3,pathHeight;
            0*1e3,2*1e3,pathHeight;
            2*1e3,3*1e3,pathHeight;
            3*1e3,0*1e3,pathHeight;
            5.1*1e3,5*1e3,pathHeight;];
    case 2 % 标准矩形测区
        numLine = 0;
        lon_left = 1e3;
        lon_right = 2e3;
        lat_space = 100;
        %         lon_right = 1.5e3;
        %         lat_space = 50;
        TASK_SET.PATH.paths_m(1,:) = 0*[0*lat_space, 0.5*lon_left, pathHeight];
        TASK_SET.PATH.paths_m(1,3) = pathHeight;
        nPoints = 11;
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
            TASK_SET.PATH.paths_m(i,:) = [numLine*lat_space, lon_pos, pathHeight];
        end
%         TASK_SET.PATH.paths_m(5,:) = TASK_SET.PATH.paths_m(4,:);
        angle = 0*pi;
        DCM = [cos(angle) sin(angle);
            -sin(angle) cos(angle);];
        TASK_SET.PATH.paths_m(1:nPoints,1:2) = TASK_SET.PATH.paths_m(1:nPoints,1:2)*DCM;
    case 3
        TASK_SET.PATH.paths_m(1:9,:) = [...
            1*1e2,0*1e3,pathHeight;
            1*1e2,1*1e3,pathHeight;
            2*1e2,1*1e3,pathHeight;
            2*1e2,2*1e3,pathHeight;
            4*1e2,2*1e3,pathHeight;
            4*1e2,3*1e3,pathHeight;
            5*1e2,3*1e3,pathHeight;
            10*1e2,2*1e3,pathHeight;
            16*1e2,2*1e3,pathHeight;];
    case 4
        TASK_SET.PATH.paths_m(1:9,:) = [...
            0,0,pathHeight;
            -1500,1500,pathHeight;
            -1600,1600,pathHeight;
            2*1e2,2*1e3,pathHeight;
            4*1e2,2*1e3,pathHeight;
            4*1e2,3*1e3,pathHeight;
            5*1e2,3*1e3,pathHeight;
            10*1e2,2*1e3,pathHeight;
            16*1e2,2*1e3,pathHeight;];
end
TASK_SET.PATH.paths_ddm = TASK_SET.PATH.paths_m;
TASK_SET.PATH.paths_ddm(1,:) = TASK_SET.PATH.home;
for i = 2:TASK_SET.PATH.maxNum
    if TASK_SET.PATH.paths_m(i,1) ~= TASK_SET.PATH.nanFlag
        TASK_SET.PATH.paths_ddm(i,1) = TASK_SET.PATH.home(1) + TASK_SET.PATH.paths_m(i,1)*deg2m - 0.01;
        TASK_SET.PATH.paths_ddm(i,2) = TASK_SET.PATH.home(2) + TASK_SET.PATH.paths_m(i,2)*deg2m/cos(TASK_SET.PATH.home(1)*pi/180) - 0.014;
        TASK_SET.PATH.paths_ddm(i,3) = TASK_SET.PATH.paths_m(i,3);
    end
end
%%
pathSimMode = 'sim'; % 'sim' 'flight'
switch pathSimMode
    case 'sim'
        for i = 1:TASK_SET.PATH.maxNum
            STRUCT_mavlink_mission_item_def_ARRAY(i) = STRUCT_mavlink_mission_item_def;
            STRUCT_mavlink_mission_item_def_ARRAY(i).param1 = rem(i,2);
            STRUCT_mavlink_mission_item_def_ARRAY(i).seq = i; % 航点序列号（0：Home点）
            STRUCT_mavlink_mission_item_def_ARRAY(i).autocontinue = 1; % 悬停拐弯:0, 协调拐弯:1
            STRUCT_mavlink_mission_item_def_ARRAY(i).param4 = TASK_SET.PATH.speed;
            STRUCT_mavlink_mission_item_def_ARRAY(i).x = TASK_SET.PATH.paths_ddm(i,1);  % lattitude
            STRUCT_mavlink_mission_item_def_ARRAY(i).y = TASK_SET.PATH.paths_ddm(i,2);  % longitude
            STRUCT_mavlink_mission_item_def_ARRAY(i).z = TASK_SET.PATH.paths_ddm(i,3);  % altitude
        end
    case 'flight'
        filename = 'bb3a77e6787849198733a699b82b4be3(7).log';
        LogWPdata = importGroundStationLog(filename);
        for i = 1:TASK_SET.PATH.maxNum
            if i <= length(LogWPdata)
                STRUCT_mavlink_mission_item_def_ARRAY(i) = STRUCT_mavlink_mission_item_def;
                STRUCT_mavlink_mission_item_def_ARRAY(i).param1 = LogWPdata(i).param1;
                STRUCT_mavlink_mission_item_def_ARRAY(i).seq = i; % 航点序列号（0：Home点）
                STRUCT_mavlink_mission_item_def_ARRAY(i).autocontinue = 1; % 悬停拐弯:0, 协调拐弯:1
                STRUCT_mavlink_mission_item_def_ARRAY(i).param4 = TASK_SET.PATH.speed;
                STRUCT_mavlink_mission_item_def_ARRAY(i).x = LogWPdata(i).lat;  % lattitude
                STRUCT_mavlink_mission_item_def_ARRAY(i).y = LogWPdata(i).lon;  % longitude
                STRUCT_mavlink_mission_item_def_ARRAY(i).z = LogWPdata(i).height;  % altitude
            else
                STRUCT_mavlink_mission_item_def_ARRAY(i) = STRUCT_mavlink_mission_item_def;
                STRUCT_mavlink_mission_item_def_ARRAY(i).param1 = rem(i,2);
                STRUCT_mavlink_mission_item_def_ARRAY(i).seq = i; % 航点序列号（0：Home点）
                STRUCT_mavlink_mission_item_def_ARRAY(i).autocontinue = 1; % 悬停拐弯:0, 协调拐弯:1
                STRUCT_mavlink_mission_item_def_ARRAY(i).param4 = TASK_SET.PATH.speed;
                STRUCT_mavlink_mission_item_def_ARRAY(i).x = TASK_SET.PATH.paths_ddm(i,1);  % lattitude
                STRUCT_mavlink_mission_item_def_ARRAY(i).y = TASK_SET.PATH.paths_ddm(i,2);  % longitude
                STRUCT_mavlink_mission_item_def_ARRAY(i).z = TASK_SET.PATH.paths_ddm(i,3);  % altitude
            end
        end
end
%                 STRUCT_mavlink_mission_item_def_ARRAY(1).x = STRUCT_mavlink_mission_item_def_ARRAY(2).x + 600/111e3;
%                 STRUCT_mavlink_mission_item_def_ARRAY(1).y = STRUCT_mavlink_mission_item_def_ARRAY(2).y + 300/111e3;
%% home点额外高度
                STRUCT_mavlink_mission_item_def_ARRAY(1).z = STRUCT_mavlink_mission_item_def_ARRAY(1).z + 0*300;
                
                STRUCT_mavlink_mission_item_def_ARRAY1 = STRUCT_mavlink_mission_item_def_ARRAY;
                STRUCT_mavlink_mission_item_def_ARRAY1(2).x = STRUCT_mavlink_mission_item_def_ARRAY(2).x + 0.005;
%%
% STRUCT_mavlink_mission_item_def_ARRAY(4).param1 = 1;
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch = 20;
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_TakeOff = 23;
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_AirStandBy = 28;
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_Continue = 29;
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude = 36;
TASK_SET.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor = 38; % 固定翼转旋翼
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_LandStart = 189;
TASK_SET.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist = 206;
TASK_SET.MavLinkInfo.CustomCmdInfo.num_StartProfile = 300; % 开始或继续任务

TASK_SET.MavLinkInfo.CustomCmdInfo.num_GoIntoPath = 1001;
TASK_SET.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath = 1003; % 开始或重新开始
TASK_SET.MavLinkInfo.CustomCmdInfo.num_HoverAdjust = 1004; % 定点悬停调整
TASK_SET.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix = 1006; % 旋翼转固定翼
TASK_SET.MavLinkInfo.CustomCmdInfo.num_CircleHover = 1007; % 定点绕圈盘旋
TASK_SET.MavLinkInfo.CustomCmdInfo.num_GroundStandBy = uint8(ENUM_MavlinkStandardCmd.MavCmd_EnterGroundStandby); % 进入地面模式
% 控制指令 -------------------------------------------------------------
% 内置指令
CMD_GoHome = STRUCT_mavlink_msg_id_command_long;
CMD_GoHome.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch;  % 返航
CMD_AirStandBy = STRUCT_mavlink_msg_id_command_long;
CMD_AirStandBy.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_AirStandBy;  % 暂停盘旋
CMD_Continue = STRUCT_mavlink_msg_id_command_long;
CMD_Continue.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_Continue; % 继续
CMD_TakeOff = STRUCT_mavlink_msg_id_command_long;
CMD_TakeOff.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_TakeOff; % 起飞
CMD_SwitchAltitude = STRUCT_mavlink_msg_id_command_long;
CMD_SwitchAltitude.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude; % 切换高度
CMD_SwitchAltitude.param1 = 50;
CMD_LandStart = STRUCT_mavlink_msg_id_command_long;
CMD_LandStart.param1 = 1;
CMD_LandStart.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_LandStart; % 着陆
CMD_CamTriggDist = STRUCT_mavlink_msg_id_command_long;
CMD_CamTriggDist.command = TASK_SET.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist; % 相机触发距离
CMD_CamTriggDist.param1 = 30;
% 自定义指令
CMD_GoIntoPath = STRUCT_mavlink_msg_id_command_long;
CMD_GoIntoPath.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_GoIntoPath; % 进入航线
CMD_StartProfile = STRUCT_mavlink_msg_id_command_long;
CMD_StartProfile.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_StartProfile; % 开始或继续之前中断的
CMD_ReGoIntoPath = STRUCT_mavlink_msg_id_command_long;
CMD_ReGoIntoPath.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath; % 开始或重新开始
CMD_HoverAdjust = STRUCT_mavlink_msg_id_command_long;
CMD_HoverAdjust.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_HoverAdjust; % 定点悬停调整
CMD_Fix2Rotor = STRUCT_mavlink_msg_id_command_long;
CMD_Fix2Rotor.param1 = 1;
CMD_Fix2Rotor.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor; % 定点悬停调整
CMD_Rotor2Fix = STRUCT_mavlink_msg_id_command_long;
CMD_Rotor2Fix.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix; % 定点悬停调整
CMD_CircleHover = STRUCT_mavlink_msg_id_command_long;
CMD_CircleHover.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_CircleHover; % 定点悬停调整
CMD_GroundStandBy = STRUCT_mavlink_msg_id_command_long;
CMD_GroundStandBy.command = TASK_SET.MavLinkInfo.CustomCmdInfo.num_GroundStandBy; % 定点悬停调整