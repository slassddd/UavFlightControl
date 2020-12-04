function flag = isRtkHasBigErrorWithUblox(ll_ublox1,ll_um482,isUbloxHealth)
% isRtkHasBigErrorWithUblox([IN_SENSOR.ublox1.Lat,IN_SENSOR.ublox1.Lon],...
%                           [IN_SENSOR.um482.Lat,IN_SENSOR.um482.Lon],...
%                           SensorStatus.ublox1 == ENUM_SensorHealthStatus.Health)
% ll_ublox1 = [IN_SENSOR.ublox1.Lat,IN_SENSOR.ublox1.Lon];
% ll_um482 = [IN_SENSOR.um482.Lat,IN_SENSOR.um482.Lon];
pos_error = distOfTwoLL(ll_ublox1,ll_um482);
%
flag = false;
if isUbloxHealth && pos_error > 100
    flag = true;
end
