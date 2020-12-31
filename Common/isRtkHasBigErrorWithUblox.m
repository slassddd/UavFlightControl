function flag = isRtkHasBigErrorWithUblox(ll_ublox1,ll_um482,isUbloxHealth)
pos_error = distOfTwoLL(ll_ublox1,ll_um482);
%
flag = false;
if isUbloxHealth && pos_error > 100
    flag = true;
end
