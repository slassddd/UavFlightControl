classdef ENUM_FlightControlMode < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        NoneFlightControlMode (0),
        SpotHoverMode (1), % 旋翼运动模式，上升、下降、平移、定点都是该模式
        HeightKeepMode (2), % 高度保持
        AttitudeKeepMode (3), % 姿态保持,应该用不到
        HeadingKeepMode (4), % 
        PathFollowControlMode (5),
        CircleHoverMode (6),
        Move3dMode (7),
        GroundStandByControlMode (8),
        DoNothinig (9),
        OnlyStablizePitchAndRoll (10),
        RotorGoUpDownBySpeed (11),
        RotorUnloadToStandby (12),
        RotorShutDown (13), % 地面关车
        RotorStable_RollPitchHeight (14),
        RotorGoUpDownWithHorizonPosFree (15),
        SliderMode (16), % 低动力降高
        HoverSliderMode (17), % 盘旋滑翔降高
        HeadingTrackMode (18), % 追航向并保持高度
%         FixWingLevel (14), % 固定翼姿态改平
    end
end