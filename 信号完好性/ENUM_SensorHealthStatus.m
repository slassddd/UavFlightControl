classdef ENUM_SensorHealthStatus < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        Health (0),  
        Degrade (1), % 性能降低
        LostShort (2),    % 信号丢失
        LostLong (3),    % 信号丢失
        Fault (4),   % 传感器故障
    end
end

