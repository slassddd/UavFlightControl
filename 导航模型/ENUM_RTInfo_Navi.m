classdef ENUM_RTInfo_Navi < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    enumeration
        RTIN_None (0),
        RTIN_InitWait_1_Complete (101),
        RTIN_InitWait_2_Complete (102),
        RTIN_Init_Complete (103),
        RTIN_Init_Enter (104),
        
        RTIN_Filter_Fuse_Ublox (201),
        RTIN_Filter_Fuse_Um482 (202),
        RTIN_Filter_Fuse_Baro (203),
        RTIN_Filter_Fuse_Mag (204),
    end
end

