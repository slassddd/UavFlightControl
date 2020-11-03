classdef ENUM_TaskLogBlockName < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        TASKLOG_None (0),
        TASKLOG_Payload (1),      
        TASKLOG_ParserInput (2),
        TASKLOG_ParserCmd (3),
        TASKLOG_PowerConsumer (4),
        TASKLOG_FlightMode (5),      
        TASKLOG_Protect_Height (6),
        TASKLOG_Protect_BatteryLife (7),
        TASKLOG_Protect_Com (8),
        TASKLOG_Protect_Stall (9),      
        TASKLOG_Protect_Wind (10),
        TASKLOG_Protect_Sensor (11),
        TASKLOG_Protect_Fense (12),        
        TASKLOG_Protect (13),
        TASKLOG_System (14),
    end
end

