classdef ENUM_FlightControlMode < Simulink.IntEnumType
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    enumeration
        NoneFlightControlMode (0),
        SpotHoverMode (1), % �����˶�ģʽ���������½���ƽ�ơ����㶼�Ǹ�ģʽ
        HeightKeepMode (2), % �߶ȱ���
        AttitudeKeepMode (3), % ��̬����,Ӧ���ò���
        HeadingKeepMode (4), % 
        PathFollowControlMode (5),
        CircleHoverMode (6),
        Move3dMode (7),
        GroundStandByControlMode (8),
        DoNothinig (9),
        OnlyStablizePitchAndRoll (10),
        RotorGoUpDownBySpeed (11),
        RotorUnloadToStandby (12),
        RotorShutDown (13), % ����س�
        RotorStable_RollPitchHeight (14),
        RotorGoUpDownWithHorizonPosFree (15),
        SliderMode (16), % �Ͷ�������
        HoverSliderMode (17), % �������轵��
        HeadingTrackMode (18), % ׷���򲢱��ָ߶�
%         FixWingLevel (14), % �̶�����̬��ƽ
    end
end