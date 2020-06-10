classdef ENUM_RTInfo_PayLoad < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        % 逻辑信息
        NonePayLoad (0),     
        Camera_Enter_StandBy (1), 
        Camera_Enter_Work (2), 
        Lidar_Enter_StandBy (11), 
        Lidar_Enter_Work (12),         
        % 严重警告
    end
end

