classdef ENUM_FlightTaskMode < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    enumeration
        NoneFlightTaskMode (0),
        GroundStandByMode (1), % ����״̬�µĵ���ģʽ
        TakeOffMode (2),
        Rotor2Fix_Mode (3),
        HoverAdjustMode (4),
        HoverUpMode (5),
        PathFollowMode (6),
        AirStandByMode (7),
        GoHomeMode (8),
        HoverDownMode (9),
        Fix2Rotor_Mode (10),
        LandMode (11),
        FenceRecoverMode (12),
        SpotCircleMode (13),
        StallRecovery (14),
        VerticalMove (15),
        CalibBeforePath (16),
%         GroundLock (15), % ����״̬�µĵ���ģʽ
        
        Test_HeightKeep (101),
        Test_AttitudeKeep (102),
        Test_HeadingKeep (103),
        Test_SpotCircle (104)
    end
end