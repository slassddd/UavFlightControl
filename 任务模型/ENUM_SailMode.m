classdef ENUM_SailMode < Simulink.IntEnumType
    % ������ʽ
    enumeration
        AgainstWind (0), % �ҷ��������
        FollowWind (1), % �ҷ��˳�����
        CrossWind (2), % �ҷ�������
        AnyWind (3), % ����������
    end
end

