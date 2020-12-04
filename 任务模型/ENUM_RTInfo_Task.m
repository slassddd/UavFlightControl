classdef ENUM_RTInfo_Task < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        NothingHappened_task (0),     
        Enter_ManualMode (101),
        Enter_AutoMode (102),
        Enter_AutoMode_Init (103),
        Enter_AutoMode_GroundStandBy (104),
        Enter_AutoMode_GroundStandBy_Init (105),
        Enter_AutoMode_GroundStandBy_ToGo (106),
        Enter_AutoMode_TakeOff (107),
        Enter_AutoMode_TakeOff_Init (108),
        Enter_AutoMode_TakeOff_NearGround (109),
        Enter_AutoMode_TakeOff_ToGo (110),
        Enter_AutoMode_HoverAdjust_Init (111),
        If_AutoMode_HoverAdjust_Init_AutoProfile_Yes (112),
        If_AutoMode_HoverAdjust_Init_AutoProfile_No (113),
        If_AutoMode_HoverAdjust_ReachHeightAndLevelPoint_Yes (114),
        Enter_AutoMode_HoverAdjust_Doing (115),
        Enter_AutoMode_HoverAdjust_ToGo (116),
        If_AutoMode_HoverAdjust_ToGo_AutoProfile_Yes (117),
        Enter_AutoMode_HoverAdjust_Exit (118),
        Enter_AutoMode_Rotor2Fix (119),
        Enter_AutoMode_Rotor2Fix_Init (120),
        Enter_AutoMode_Rotor2Fix_Doing (121),
        If_AutoMode_Rotor2Fix_ReachSpeed_Yes (122),
        Enter_AutoMode_Rotor2Fix_ToGo (123),
        If_AutoMode_Rotor2Fix_ToGo_AutoProfile_Yes (124),
        If_AutoMode_Rotor2Fix_Init_AutoProfile_Yes (125),
        If_AutoMode_HoverUp_Init_AutoProfile_Yes (126),
        Enter_AutoMode_HoverUp_Doing (127),
        Enter_AutoMode_HoverUp_ToGo (128),
        If_AutoMode_HoverUp_ReachHeight_Yes (129),
        If_AutoMode_HoverUp_ReachHeightRange_Yes (130),
        If_AutoMode_HoverUp_ToGo_AutoProfile_Yes (131),
        If_AutoMode_PathFollow_Init_AutoProfile_Yes (132),
        If_AutoMode_PathFollow_Init_ValidPathNum_1 (133),
        If_AutoMode_PathFollow_Init_ValidPathNum_2 (134),
        If_AutoMode_PathFollow_Init_ValidPathNum_n_go1st (135),
        If_AutoMode_PathFollow_Init_ValidPathNum_n_goMid (136),
        Enter_AutoMode_PathFollow_ToFirst (137),
        If_AutoMode_PathFollow_ToFirst_Arrive (138),
        Enter_AutoMode_PathFollow_ToMid (139),
        If_AutoMode_PathFollow_ToMid_Arrive (140),
        Enter_AutoMode_PathFollow_ToLast (141),
        If_AutoMode_PathFollow_ToLast_Arrive (142),
        Enter_AutoMode_PathFollow_ToTheNext (143),
        If_AutoMode_PathFollow_ToGo_AutoProfile_Yes (144),
        Enter_AutoMode_GoHome_Init (145),
        If_AutoMode_GoHome_Init_Arrive (146),
        Enter_AutoMode_GoHome_ToGo (147),
        If_AutoMode_GoHome_ToGo_AutoProfile_Yes (148),
        If_AutoMode_GoHome_ToGo_AutoProfile_No_Fix (149),
        If_AutoMode_GoHome_ToGo_AutoProfile_No_Rotor (150),
        Enter_AutoMode_HoverDown_Init (151),
        If_AutoMode_HoverDown_Init_AutoProfile_Yes (152),
        Enter_AutoMode_HoverDown_Doing (153),
        If_AutoMode_HoverDown_ReachHeight_Yes (154),
        Enter_AutoMode_HoverDown_ToGo (155),
        If_AutoMode_HoverDown_ToGo_AutoProfile_Yes (156),
        Enter_AutoMode_Fix2Rotor_Init (157),
        If_AutoMode_Fix2Rotor_Init_AutoProfile_Yes (158),
        Enter_AutoMode_Fix2Rotor_Doing (159),
        Enter_AutoMode_Land_Init (160),
        If_AutoMode_Land_Init_AutoProfile_Yes (161),
        Enter_AutoMode_Land_NearGround (162),
        If_AutoMode_Land_ReachHeight_Yes (163),
        Enter_AutoMode_Land_ToGo (164),
        If_AutoMode_Land_ToGo_AutoProfile_Yes (165),
        Enter_AutoMode_AirStandBy_Init (166),
        If_AutoMode_AirStandBy_Init_AutoProfile_Yes (167),
        Enter_AutoMode_AirStandBy_Doing (168),
        Enter_AutoMode_AirStandBy_ToGo (169),
        Switch_AutoMode_Fcn_ContinueFromPause_HoverUp (170),
        Switch_AutoMode_Fcn_ContinueFromPause_HoverDown (171),
        Switch_AutoMode_Fcn_ContinueFromPause_PathFollow (172),
        Switch_AutoMode_Fcn_ContinueFromPause_TakeOff (173),
        Switch_AutoMode_Fcn_ContinueFromPause_Land (174),
        Switch_AutoMode_Fcn_ContinueFromPause_GoHome (175),
        Switch_AutoMode_Fcn_ContinueFromPause_HoverAdjust (176),
        Switch_AutoMode_Fcn_ContinueFromPause_NoneMode (177),
        Enter_AutoMode_Fcn_ContinueFromPause (178),
        Switch_AutoMode_sendEventWhileSwitchToAuto_OnGround (179),
        Switch_AutoMode_sendEventWhileSwitchToAuto_InTheAir (180),
        Switch_AutoMode_sendEventWhileSwitchToAuto_InTheAir_If_Rotor (181),
        Switch_AutoMode_sendEventWhileSwitchToAuto_InTheAir_If_Fix (182),
        Switch_AutoMode_HoverAdjust_Doing_AutoProfile (183),
        Switch_AutoMode_HoverAdjust_Doing_SuspendTaskToLand (184),
        Switch_AutoMode_HoverAdjust_Doing_SuspendTaskToHome (185),
        Switch_AutoMode_Land_Doing_AutoProfile (186),
        Switch_AutoMode_Land_Doing_SuspendTaskToLand (187),
        Switch_AutoMode_Land_Doing_SuspendTaskToHome (188),
        Enter_AutoMode_TakeOff_FarGround (189),        
        Enter_AutoMode_Land_UnloadOnGround (190),
        Enter_AutoMode_HoverDown_LevelAttitude (191),
        Enter_AutoMode_HoverUp_LevelAttitude (192),
        Enter_AutoMode_StallRecovery_Hover (193),
        Enter_AutoMode_Land_FarGround (194),
        Switch_AutoMode_Land_NearGround_SuspendTaskToHomeThenLand (195),
        Switch_AutoMode_Land_NearGround_SuspendTaskToLand (196),
        Switch_AutoMode_Land_NearGround_SuspendTaskToHome (197),
        Switch_AutoMode_Land_NearGround_AutoProfile (198),
        NotDefined_State_Land_NearGround_Switch (199),
        Switch_AutoMode_Land_FarGround_SuspendTaskToHomeThenLand (200),
        Switch_AutoMode_Land_FarGround_SuspendTaskToLand (201),
        Switch_AutoMode_Land_FarGround_SuspendTaskToHome (202),
        Switch_AutoMode_Land_FarGround_AutoProfile (203),
        NotDefined_State_Land_FarGround_Switch (204),        
        Switch_AutoMode_HoverAdjust_Doing_SuspendTaskToHomeThenLand (205),
        Enter_AutoMode_HoverAdjust_WaitForContinue (206),
        If_AutoMode_Land_HasLand_Yes (207),
        If_AutoMode_HoverDown_ToGo_SuspendTaskToLand_Yes (208),
        If_AutoMode_HoverDown_SuspendTaskToHome_AutoProfile_Yes (209),
        If_AutoMode_HoverDown_ToGo_SuspendTaskToHomeThenLand_Yes (210),
        Enter_AutoMode_HoverDown_FindWind (211),
        If_AutoMode_HoverDown_ToGo_SuspendTaskToHome_Yes (212),
        Enter_AutoMode_HoverDown_HeightDown (213),
        Enter_AutoMode_Land_HitGround_AzMean (214),
        Enter_AutoMode_Land_HitGround_AzMax (215),
        Event_GSKeyMove_North (216),
        Event_GSKeyMove_East (217),
        Event_GSKeyMove_South (218),
        Event_GSKeyMove_West (219),
        If_AutoMode_Rotor2Fix_ToGo_SuspendTaskToHomeThenLand_Yes (220),
        If_AutoMode_Rotor2Fix_ToGo_SuspendTaskToLand_Yes (221),
        If_AutoMode_Rotor2Fix_ToGo_Fix2Rotor2HoverAdjust_Yes (222),
        If_AutoMode_Rotor2Fix_ToGo_Fix2Rotor2Home2Land_Yes (223),       
        Switch_AutoMode_HoverAdjust_Doing_Fix2Rotor2HoverAdjust (224),
        Switch_AutoMode_HoverAdjust_Doing_PauseInAir (225),
        Switch_AutoMode_HoverAdjust_Doing_Fix2Rotor2Home2Land (226),
        Switch_AutoMode_HoverAdjust_Doing_Otherwise (227),
        Enter_AutoMode_HoverAdjust_ExitFromContinue (228),
        Flag_Rotor2Fix_MatchCondition_To_Finish (229),
        Enter_AutoMode_HoverUp (230),
        If_AutoMode_INIT_CircleHome (231),
        HoverUp_INIT_ContinueHoverUpDown (232),
        GoHome_Approach_UavFix (233),
        GoHome_Approach_UavRotor (234),
        Fix2Rotor_ToGo_Switch_AutoProfile (235),
        Fix2Rotor_ToGo_Switch_Fix2Rotor2HoverAdjust (236),
        Fix2Rotor_ToGo_Switch_Otherwise (237),
        Fix2Rotor_ToGo_Complete_Con1 (238),
        Fix2Rotor_ToGo_Complete_Con2 (239),
        Land_NearGround_HorizontalFree (240),
        Land_HasLandCond_Acc_H (241),
        Land_HasLandCond_H_Continue (242),
        Land_HasLandCond_NearGround_Continue (243),
        StallRecovery_Exit (244),
        VerticalMove_Enter (245),
        VerticalMove_Exit (246),
        Not_Allowed_TakeOff (247),
        Land_No_GPS_Available (248),
        Land_AtLeastOne_GPS_Available (249),
        Enter_AutoMode_HoverDown_ToCenter (250),
        Enter_AutoMode_HoverDown_StraightForward (251),
        BreakRecord_Yes (252),
        VerticalMove_BeforeGoHome_Enter_Yes (253),
        VerticalMove_BeforeGoHome_Enter_No (254),
        VerticalMove_BeforePath_Enter_Yes (255),
        VerticalMove_BeforePath_Enter_No (256),
        LargeAttitudeDetect_Enter_Normal (257),
        LargeAttitudeDetect_Enter_Abnormal (258),
        TaskLog_Protect_HeightInHoverUp_Normal (259),
        TaskLog_Protect_HeightInHoverUp_TooLow (260),
        Enter_AutoMode_TakeOff_Waiting (261),
        SingleMode_Change (262),
        SingleMode_TakeOff_StopHere (263),
        SingleMode_HovverAdjust_StopHere (264),
        SingleMode_Rotor2Fix_StopHere (265),
        SingleMode_HoverUp_StopHere (266),
        SingleMode_Fix2Rotor_StopHere (267),
        LoopPath_Complete_Num (268),
        TaskLog_Protect_Battery_RunOut (269),
        Rotor2Fix_FailToGo (270),
        HoverUp_Expand_R_90 (271),
        HoverUp_Expand_R_120 (272),
        HoverUp_Expand_R_150 (273),
        HoverUp_Expand_R_200 (274),
        HoverUp_Expand_R_250 (275),
        HoverUp_Expand_R (276),
        FlightControlMode_Changed (277),        
        SystemTimeUpdate (278),
        SystemInfoUpdate (279),
        Airspeed_AddExtraSpeed (280),
        Task_Calib_Enter (281),
        Task_Calib_Circle1 (282),
        Task_Calib_Circle2 (283),
        Airspeed_Stuck (284),
        Task_Calib_ToGo_AutoProfile (285),
        Landmark_Detected (286),
        
        
        
        ReciveCmd_GoHome (1201),
        ReciveCmd_GoHome_But_Not_Response (1202),
        ReciveCmd_TakeOff (1203),
        ReciveCmd_TakeOff_But_Not_Response (1204),
        SendEvent_TakeOff_ButNotAllowed (1205),
        SendEvent_HoverAdjust_ButNotAllowed (1206),
        SendEvent_Rotor2Fix_ButNotAllowed (1207),
        SendEvent_HoverUp_ButNotAllowed (1208),
        SendEvent_PathFollow_ButNotAllowed (1209),
        SendEvent_GoHomeMode_ButNotAllowed (1210),
        SendEvent_HoverDown_ButNotAllowed (1211),
        SendEvent_Fix2Rotor_ButNotAllowed (1212),
        SendEvent_Land_ButNotAllowed (1213),
        SendEvent_AirStandBy_ButNotAllowed (1214),
        SetValue_HeightCmd (1215),
        
        % 载荷 -----------------------------------------------------------------
        TaskLog_Payload_Camera_Shot (2000),
        TaskLog_Payload_Camera_StandBy (2001),
        TaskLog_Payload_Camera_BeginWork (2002),
        % mavlink
        TaskLog_Mav_CmdChange (2100),
        TaskLog_Mav_GoHome_Yes (2101),
        TaskLog_Mav_GoHome_No (2102),
        TaskLog_Mav_TakeOff_Yes (2103),
        TaskLog_Mav_TakeOff_No (2104),    
        TaskLog_Mav_HoverAdjust_Yes (2105),
        TaskLog_Mav_HoverAdjust_No (2106),
        TaskLog_Mav_Continue_Yes (2107),
        TaskLog_Mav_Continue_No (2108),
        TaskLog_Mav_StartTask_Yes (2109),
        TaskLog_Mav_StartTask_No (2110),  
        TaskLog_Mav_SwitchHeight_Yes (2111),
        TaskLog_Mav_SwitchHeight_No (2112),
        TaskLog_Mav_Fix2Rotor_Yes (2113),
        TaskLog_Mav_Fix2Rotor_No (2114),
        TaskLog_Mav_Land_Yes (2115),
        TaskLog_Mav_Land_No (2116),
        TaskLog_Mav_CamTrigDist_Yes (2117),
        TaskLog_Mav_CamTrigDist_No (2118),
        TaskLog_Mav_GroundStandby_Yes (2119),
        TaskLog_Mav_GroundStandby_No (2120),
        % 各种Protect
        TaskLog_Protect_Height_Normal (2200),
        TaskLog_Protect_Height_TooLow (2201),
        TaskLog_Protect_Battery_Normal (2202),
        TaskLog_Protect_Battery_Low (2203),
        TaskLog_Protect_Battery_SevereLow (2204),
        TaskLog_Protect_Com_Normal (2205),
        TaskLog_Protect_Com_Lost (2206),
        TaskLog_Protect_Stall_Normal (2207),
        TaskLog_Protect_Stall_Stall (2208),
        TaskLog_Protect_Stall_Recovery (2209),
        TaskLog_Protect_Wind_VeryHigh (2210),
        TaskLog_Protect_SensorSystem_Normal (2211),        
        TaskLog_Protect_SensorSystem_Degrade (2212),        
        TaskLog_Protect_SensorSystem_Fault (2213),   
        TaskLog_Protect_Fense_In (2214),   
        TaskLog_Protect_Fense_Out (2215),   
        TaskLog_Protect_Airspeed_Fault_1 (2216),   
        TaskLog_Protect_Airspeed_Normal (2217),  
        TaskLog_Protect_Airspeed_LargePitch (2218),   
        TaskLog_Protect_Airspeed_LargeAngularVelOrAccz (2219),   
        TaskLog_Protect_Airspeed_LargeVd (2220),   
        TaskLog_Protect_Airspeed_LargeHeightErr (2221),
        % Input
        TaskLog_Input_HomeChange_GS (2416),
        TaskLog_Input_HomeChange_Path (2417),
        TaskLog_Input_HomeChange_TakeOff (2418),
        TaskLog_Input_HomeChange_KeyBoard (2419),
        TaskLog_Protect_Airspeed_Fault_2 (2420),   
        
        % 严重警告
        NotDefined_Fcn_isAllowedToEnterThisMode (5001),
        NotDefined_State_ValidPathNum (5002),
        NotDefined_Fcn_ContinueFromPause (5003),
        NotDefined_Fcn_sendEventWhileSwitchToAuto_If (5004),
        NotDefined_Fcn_sendEventWhileSwitchToAuto_Switch (5005),
        NotDefined_Fcn_calIfReachPoint_Switch (5006),
        NotDefined_State_HoverAdjust_Doing_Switch (5007),
        NotDefined_State_Land_Doing_Switch (5008),
        Switch_AutoMode_sendEventWhileSwitchToAuto_InTheAir_NotInFense (5009),
        If_fcn_isAllowedToTakeOff_No (5010),
        Enter_BatteryLife_BatteryLow (5011),
        Enter_BatteryLife_BatterySevereLow (5012),
        Enter_Communication_Lost (5013),
        If_fcn_isSensorSystemHealth_No (5014),
        Enter_AutoMode_StallRecovery_StablizePitchAndRoll (5015),
        Enter_StallDetect_Stall (5016),
        Exit_StallDetect_Stall (5017),
        Enter_SignalIntegrity_Abnormal (5018),
        Exit_SignalIntegrity_Abnormal (5019),            
        Enter_SystemLockInTheAir_Protect_LockedInTheAir (5020),
        Enter_SystemLockInTheAir_Protect_UnLockedInTheAir (5021),
        Enter_HeightTooLowInFix_Protect_HasBeenTooLow (5022),
%         RTInfo.Task = ENUM_RTInfo_Task.Enter_Communication_Lost; % 更新RT信息

    end
end

