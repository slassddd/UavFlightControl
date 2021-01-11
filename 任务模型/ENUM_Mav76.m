classdef ENUM_Mav76 < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        Mav76_None (0),
        Mav76_GoHome (20),
        Mav76_TakeOff (23),
        Mav76_Hover (28),
        Mav76_Continue (29),
        Mav76_GimbalCheck (30),
        Mav76_PosCheck (31),
        Mav76_QCheck (34),
        Mav76_SurfaceCheck (35),
        Mav76_SwitchHeight (36),
        Mav76_Fix2Rotor (38),
        Mav76_Land (189),
        Mav76_CamDist (206),
        Mav76_PreFlightCalib (241),
        Mav76_Reboot (246),
    end
end

