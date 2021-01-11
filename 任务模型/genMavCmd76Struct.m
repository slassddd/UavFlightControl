function GroundStationParam = genMavCmd76Struct()
% 生成标准Cmd76对应的命令结构体
STRUCT_mavlink_msg_id_command_long = Simulink.Bus.createMATLABStruct('mavlink_msg_id_command_long');
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
% 标准Cmd
GroundStationParam.CMD_None = STRUCT_mavlink_msg_id_command_long;
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
% 自定义Cmd�
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