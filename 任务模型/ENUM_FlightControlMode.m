classdef ENUM_FlightControlMode < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    enumeration
        NoneFlightControlMode (0),
        SpotHoverMode (1),
        HeightKeepMode (2),
        AttitudeKeepMode (3),
        HeadingKeepMode (4),
        PathFollowControlMode (5),
        CircleHoverMode (6),
        Move3dMode (7),
        GroundStandByControlMode (8),
        DoNothinig (9),
        OnlyStablizePitchAndRoll (10),
        RotorGoUpDownBySpeed (11),
        RotorUnloadToStandby (12),
    end
end

