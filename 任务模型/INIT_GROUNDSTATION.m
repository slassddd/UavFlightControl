function [] = INIT_GROUNDSTATION();
Ts_GroundStation.Ts_base = 0.036;
%
mission_item_def.DataScope = 'Auto';
mission_item_def.HeaderFile = '';
STRUCT_mavlink_mission_item_def = Simulink.Bus.createMATLABStruct('mavlink_mission_item_def');
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
STRUCT_BUS_TASK_COMMON_OutParam = Simulink.Bus.createMATLABStruct('BUS_TASK_COMMON_OutParam');
%% ����
deg2m = 1/111e3;
GSParam.PATH.pathHeight = 500;
homeHeight = GSParam.PATH.pathHeight + 0*200;
SimParam.GroundStation.groundAltitude = 200;
SimParam.GroundStation.mavlinkHome = [40.04 180 homeHeight]; %  lat lon alt
GSParam.PATH.nanFlag = TASK_PARAM_V1000.nanFlag;
GSParam.PATH.maxNum = TASK_PARAM_V1000.maxPathPointNum;
GSParam.PATH.speed = 18;
GSParam.PATH.paths_m = TASK_PARAM_V1000.nanFlag*ones(GSParam.PATH.maxNum,3);

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
    case 2 % ��׼���β���
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
GSParam.PATH.paths_ddm(1,:) = SimParam.GroundStation.mavlinkHome;
for i = 2:GSParam.PATH.maxNum
    if GSParam.PATH.paths_m(i,1) ~= GSParam.PATH.nanFlag
        GSParam.PATH.paths_ddm(i,1) = SimParam.GroundStation.mavlinkHome(1) + GSParam.PATH.paths_m(i,1)*deg2m - 0.01;
        GSParam.PATH.paths_ddm(i,2) = SimParam.GroundStation.mavlinkHome(2) + GSParam.PATH.paths_m(i,2)*deg2m/cos(SimParam.GroundStation.mavlinkHome(1)*pi/180) - 0.014;
        GSParam.PATH.paths_ddm(i,3) = GSParam.PATH.paths_m(i,3);
    end
end
%%
pathSimMode = 'sim'; % 'sim' 'flight'
switch pathSimMode
    case 'sim'
        for i = 1:GSParam.PATH.maxNum
            SimParam.GroundStation.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
            SimParam.GroundStation.mavlinkPathPoints(i).param1 = rem(i,2);
            SimParam.GroundStation.mavlinkPathPoints(i).seq = i; % �������кţ�0��Home�㣩
            SimParam.GroundStation.mavlinkPathPoints(i).autocontinue = 1; % ��ͣ����:0, Э������:1
            SimParam.GroundStation.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
            SimParam.GroundStation.mavlinkPathPoints(i).x = single(GSParam.PATH.paths_ddm(i,1));  % lattitude
            SimParam.GroundStation.mavlinkPathPoints(i).y = single(GSParam.PATH.paths_ddm(i,2));  % longitude
            SimParam.GroundStation.mavlinkPathPoints(i).z = single(GSParam.PATH.paths_ddm(i,3));  % altitude
        end
    case 'flight'
        filename = 'bb3a77e6787849198733a699b82b4be3(7).log';
        LogWPdata = importGroundStationLog(filename);
        for i = 1:GSParam.PATH.maxNum
            if i <= length(LogWPdata)
                SimParam.GroundStation.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
                SimParam.GroundStation.mavlinkPathPoints(i).param1 = LogWPdata(i).param1;
                SimParam.GroundStation.mavlinkPathPoints(i).seq = i; % �������кţ�0��Home�㣩
                SimParam.GroundStation.mavlinkPathPoints(i).autocontinue = 1; % ��ͣ����:0, Э������:1
                SimParam.GroundStation.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
                SimParam.GroundStation.mavlinkPathPoints(i).x = single(LogWPdata(i).lat);  % lattitude
                SimParam.GroundStation.mavlinkPathPoints(i).y = single(LogWPdata(i).lon);  % longitude
                SimParam.GroundStation.mavlinkPathPoints(i).z = single(LogWPdata(i).height);  % altitude
            else
                SimParam.GroundStation.mavlinkPathPoints(i) = STRUCT_mavlink_mission_item_def;
                SimParam.GroundStation.mavlinkPathPoints(i).param1 = rem(i,2);
                SimParam.GroundStation.mavlinkPathPoints(i).seq = i; % �������кţ�0��Home�㣩
                SimParam.GroundStation.mavlinkPathPoints(i).autocontinue = 1; % ��ͣ����:0, Э������:1
                SimParam.GroundStation.mavlinkPathPoints(i).param4 = GSParam.PATH.speed;
                SimParam.GroundStation.mavlinkPathPoints(i).x = GSParam.PATH.paths_ddm(i,1);  % lattitude
                SimParam.GroundStation.mavlinkPathPoints(i).y = GSParam.PATH.paths_ddm(i,2);  % longitude
                SimParam.GroundStation.mavlinkPathPoints(i).z = GSParam.PATH.paths_ddm(i,3);  % altitude
            end
        end
end
%% home�����߶�
                SimParam.GroundStation.mavlinkPathPoints(1).z = SimParam.GroundStation.mavlinkPathPoints(1).z + 0*200;
                
                SimParam.GroundStation.mavlinkPathPoints1 = SimParam.GroundStation.mavlinkPathPoints;
                SimParam.GroundStation.mavlinkPathPoints1(2).x = SimParam.GroundStation.mavlinkPathPoints(2).x + 0.005;
%%
% SimParam.GroundStation.mavlinkPathPoints(4).param1 = 1;
GSParam.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch = 20;
GSParam.MavLinkInfo.DefaultCmdInfo.num_TakeOff = 23;
GSParam.MavLinkInfo.DefaultCmdInfo.num_AirStandBy = 28;
GSParam.MavLinkInfo.DefaultCmdInfo.num_Continue = 29;
GSParam.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude = 36;
GSParam.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor = 38; % �̶���ת����
GSParam.MavLinkInfo.DefaultCmdInfo.num_LandStart = 189;
GSParam.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist = 206;
GSParam.MavLinkInfo.CustomCmdInfo.num_StartProfile = 300; % ��ʼ���������

GSParam.MavLinkInfo.CustomCmdInfo.num_GoIntoPath = 1001;
GSParam.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath = 1003; % ��ʼ�����¿�ʼ
GSParam.MavLinkInfo.CustomCmdInfo.num_HoverAdjust = 1004; % ������ͣ����
GSParam.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix = 1006; % ����ת�̶���
GSParam.MavLinkInfo.CustomCmdInfo.num_CircleHover = 1007; % ������Ȧ����
GSParam.MavLinkInfo.CustomCmdInfo.num_GroundStandBy = uint8(ENUM_MavlinkStandardCmd.MavCmd_EnterGroundStandby); % �������ģʽ
% ����ָ�� -------------------------------------------------------------
% ����ָ��
SimParam.GroundStation.CMD_GoHome = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_GoHome.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch;  % ����
SimParam.GroundStation.CMD_AirStandBy = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_AirStandBy.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_AirStandBy;  % ��ͣ����
SimParam.GroundStation.CMD_Continue = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_Continue.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_Continue; % ����
SimParam.GroundStation.CMD_TakeOff = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_TakeOff.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_TakeOff; % ���
SimParam.GroundStation.CMD_SwitchAltitude = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_SwitchAltitude.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude; % �л��߶�
SimParam.GroundStation.CMD_SwitchAltitude.param1 = 50;
SimParam.GroundStation.CMD_LandStart = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_LandStart.param1 = 1;
SimParam.GroundStation.CMD_LandStart.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_LandStart; % ��½
SimParam.GroundStation.CMD_CamTriggDist = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_CamTriggDist.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist; % �����������
SimParam.GroundStation.CMD_CamTriggDist.param1 = 30;
% �Զ���ָ��
SimParam.GroundStation.CMD_GoIntoPath = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_GoIntoPath.command = GSParam.MavLinkInfo.CustomCmdInfo.num_GoIntoPath; % ���뺽��
SimParam.GroundStation.CMD_StartProfile = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_StartProfile.command = GSParam.MavLinkInfo.CustomCmdInfo.num_StartProfile; % ��ʼ�����֮ǰ�жϵ�
SimParam.GroundStation.CMD_ReGoIntoPath = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_ReGoIntoPath.command = GSParam.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath; % ��ʼ�����¿�ʼ
SimParam.GroundStation.CMD_HoverAdjust = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_HoverAdjust.command = GSParam.MavLinkInfo.CustomCmdInfo.num_HoverAdjust; % ������ͣ����
SimParam.GroundStation.CMD_Fix2Rotor = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_Fix2Rotor.param1 = 1;
SimParam.GroundStation.CMD_Fix2Rotor.command = GSParam.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor; % ������ͣ����
SimParam.GroundStation.CMD_Rotor2Fix = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_Rotor2Fix.command = GSParam.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix; % ������ͣ����
SimParam.GroundStation.CMD_CircleHover = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_CircleHover.command = GSParam.MavLinkInfo.CustomCmdInfo.num_CircleHover; % ������ͣ����
SimParam.GroundStation.CMD_GroundStandBy = STRUCT_mavlink_msg_id_command_long;
SimParam.GroundStation.CMD_GroundStandBy.command = GSParam.MavLinkInfo.CustomCmdInfo.num_GroundStandBy; % ������ͣ����
%%
fprintf('���߲�������(�����ڷ���):\n')
fprintf('\t\t���溣�θ߶�: %d [m]\n',SimParam.GroundStation.groundAltitude);
fprintf('\t\t������ظ߶�: %d [m]\n',GSParam.PATH.pathHeight);