function GroundStationParam = genMavCmd76Struct()
% 生成标准Cmd76对应的命令结构体
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
GSParam.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch = 20;
GSParam.MavLinkInfo.DefaultCmdInfo.num_TakeOff = 23;
GSParam.MavLinkInfo.DefaultCmdInfo.num_AirStandBy = 28;
GSParam.MavLinkInfo.DefaultCmdInfo.num_Continue = 29;
GSParam.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude = 36;
GSParam.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor = 38; %
GSParam.MavLinkInfo.DefaultCmdInfo.num_EnterPoint = 51; %
GSParam.MavLinkInfo.DefaultCmdInfo.num_ExitPoint = 52; %
GSParam.MavLinkInfo.DefaultCmdInfo.num_LandStart = 189;
GSParam.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist = 206;
GSParam.MavLinkInfo.DefaultCmdInfo.num_AdjustPauseHeight = 301;
GSParam.MavLinkInfo.DefaultCmdInfo.num_Rotor2Fix2Home2Land = 2000;

GSParam.MavLinkInfo.CustomCmdInfo.num_StartProfile = 300;
GSParam.MavLinkInfo.CustomCmdInfo.num_GoIntoPath = 1001;
GSParam.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath = 1003; %
GSParam.MavLinkInfo.CustomCmdInfo.num_HoverAdjust = 1004; %
GSParam.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix = 1006; % 
GSParam.MavLinkInfo.CustomCmdInfo.num_CircleHover = 1007; %
GSParam.MavLinkInfo.CustomCmdInfo.num_GroundStandBy = uint8(ENUM_MavlinkStandardCmd.MavCmd_EnterGroundStandby);
% 鎺у埗鎸囦护 -------------------------------------------------------------
% 标准Cmd
GroundStationParam.CMD_None = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GoHome = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GoHome.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_ReturnToLaunch;  %
GroundStationParam.CMD_AirStandBy = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_AirStandBy.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_AirStandBy;  %
GroundStationParam.CMD_Continue = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Continue.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_Continue; %
GroundStationParam.CMD_TakeOff = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_TakeOff.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_TakeOff; %
GroundStationParam.CMD_SwitchAltitude = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_SwitchAltitude.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_SwitchAltitude; %
GroundStationParam.CMD_SwitchAltitude.param1 = 50;

GroundStationParam.CMD_EnterPoint = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_EnterPoint.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_EnterPoint; % 
GroundStationParam.CMD_ExitPoint = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_ExitPoint.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_ExitPoint; % 

GroundStationParam.CMD_LandStart = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_LandStart.param1 = 1;
GroundStationParam.CMD_LandStart.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_LandStart; % 
GroundStationParam.CMD_CamTriggDist = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_CamTriggDist.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_CamTriggDist; %
GroundStationParam.CMD_CamTriggDist.param1 = 30;
GroundStationParam.CMD_AdjustPauseHeight = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_AdjustPauseHeight.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_AdjustPauseHeight; %
GroundStationParam.CMD_AdjustPauseHeight.param1 = 350; % 相对高度 [m]
GroundStationParam.CMD_Rotor2Fix2Home2Land = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Rotor2Fix2Home2Land.command = GSParam.MavLinkInfo.DefaultCmdInfo.num_Rotor2Fix2Home2Land; %
GroundStationParam.CMD_Rotor2Fix2Home2Land.param1 = 0;
GroundStationParam.CMD_Rotor2Fix2Home2Land.param2 = 1; % 1 当前高度返航 0 提升到home点高度后返航
% 自定义Cmd�
GroundStationParam.CMD_GoIntoPath = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GoIntoPath.command = GSParam.MavLinkInfo.CustomCmdInfo.num_GoIntoPath; %
GroundStationParam.CMD_StartProfile = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_StartProfile.command = GSParam.MavLinkInfo.CustomCmdInfo.num_StartProfile; %
GroundStationParam.CMD_ReGoIntoPath = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_ReGoIntoPath.command = GSParam.MavLinkInfo.CustomCmdInfo.num_ReGoIntoPath; %
GroundStationParam.CMD_HoverAdjust = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_HoverAdjust.command = GSParam.MavLinkInfo.CustomCmdInfo.num_HoverAdjust; %
GroundStationParam.CMD_Fix2Rotor = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Fix2Rotor.param1 = 1;
GroundStationParam.CMD_Fix2Rotor.command = GSParam.MavLinkInfo.CustomCmdInfo.num_Fix2Rotor; %
GroundStationParam.CMD_Rotor2Fix = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_Rotor2Fix.command = GSParam.MavLinkInfo.CustomCmdInfo.num_Rotor2Fix; %
GroundStationParam.CMD_CircleHover = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_CircleHover.command = GSParam.MavLinkInfo.CustomCmdInfo.num_CircleHover; %
GroundStationParam.CMD_GroundStandBy = STRUCT_mavlink_msg_id_command_long;
GroundStationParam.CMD_GroundStandBy.command = GSParam.MavLinkInfo.CustomCmdInfo.num_GroundStandBy; %