classdef ENUM_SailMode < Simulink.IntEnumType
    % 出航方式
    enumeration
        AgainstWind (0), % 找风后逆风出航
        FollowWind (1), % 找风后顺风出航
        CrossWind (2), % 找风后侧风出航
        AnyWind (3), % 任意风向出航
    end
end

