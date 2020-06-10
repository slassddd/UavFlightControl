classdef ENUM_RTInfo_Warn < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        Warn_Normal (0),
        Warn_SensorSystem_Not_Health (1),
        Warn_Battery_Not_Normal (2),
        Warn_Not_InFense (3),
        Warn_Remote_Not_Connect (4),
        Warn_Station_Not_Connect (5),
        Warn_Path_Not_Valid (6),
        Warn_Stalling (7),
        Warn_FilterInit_Not_Complete (8),
    end
end

