classdef ENUM_HeightMeasStatus < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        HeightStatus_None_Ok (0),
        HeightStatus_LongRangeRadar_Ok (1),
        HeightStatus_LongRangeRadar_OneLaser_Ok (2),
        HeightStatus_LongRangeRadar_MultiLaser_Ok (3),
        HeightStatus_OneLaser_Ok (4),
        HeightStatus_MultiLaser_Ok (5),
    end
end

