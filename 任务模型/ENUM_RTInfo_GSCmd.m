classdef ENUM_RTInfo_GSCmd < Simulink.IntEnumType
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    enumeration
        Recive_Nothing (0),
        Recive_TakeOff (2),
        Recive_TakeOff_But_Not_Response (3),
        Recive_Pause (4),
        Recive_Pause_But_Not_Response (5),
        Recive_StartTask (6),
        Recive_StartTask_But_Not_Response (7),       
        Recive_Continue (8),
        Recive_Continue_But_Not_Response (9),      
        Recive_SwitchHeight (10),
        Recive_SwitchHeight_But_Not_Response (11),   
        Recive_Fix2Rotor (12),
        Recive_Fix2Rotor_But_Not_Response (13),    
        Recive_Land (14),
        Recive_Land_But_Not_Response (15),    
        Recive_CameraDist (14),
        Recive_CameraDist_But_Not_Response (15),        
        Recive_GoHome (16),
        Recive_GoHome_But_Not_Response (17),        
    end
end

