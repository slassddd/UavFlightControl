classdef ENUM_UAVMode < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        NoneUAVMode (0),
        Rotor (1),
        Fix (2),
        Rotor2Fix (3),
        Fix2Rotor (4)
    end
end