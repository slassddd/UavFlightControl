classdef ENUM_FindWind < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        FW_BeforeFindWind (0),
        FW_BeginFindWind (1),
        FW_Sail_WindIsLowerThanThreshold (2),
        FW_OneCircleOver_WindIsHigherThanThreshold (3),
        FW_Sail_ReachExpectedWindHeading (4),
        FW_OneCircleOver_AgainstWind (5),
        FW_OneCircleOver_FollowWind (6),
        FW_OneCircleOver_CrossWind (7),
        FW_OneCircleOver_AnyWind (8),
        FW_Sail_AnyWind (9),
        FW_BeginFindWind_Against (10),
        FW_BeginFindWind_Follow (11),
        FW_BeginFindWind_Cross (12),
        FW_BeginFindWind_Any (13),
        FW_Sail_0_30_deg (14),
        FW_Sail_30_60_deg (15),
        FW_Sail_60_90_deg (16),
        FW_Sail_90_120_deg (17),
        FW_Sail_120_150_deg (18),
        FW_Sail_150_180_deg (19),
        FW_Sail_180_210_deg (20),
        FW_Sail_210_240_deg (21),
        FW_Sail_240_270_deg (22),
        FW_Sail_270_300_deg (23),
        FW_Sail_300_330_deg (24),
        FW_Sail_330_360_deg (25),
        FW_WindSpeed_p_0_3_ms (26),
        FW_WindSpeed_p_3_6_ms (27),
        FW_WindSpeed_p_6_Inf_ms (28),
        FW_WindSpeed_m_0_3_ms (29),
        FW_WindSpeed_m_3_6_ms (30),
        FW_WindSpeed_m_6_Inf_ms (31),        
    end
end

