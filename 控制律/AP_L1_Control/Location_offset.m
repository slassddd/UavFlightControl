function  loco=Location_offset( loc,ofs_north,  ofs_east)
global LOCATION_SCALING_FACTOR_INV
    % use is_equal() because is_zero() is a local class conflict and is_zero() in AP_Math does not belong to a class
         lat=loc(1);
         lng=loc(2);
         dlat = ofs_north * LOCATION_SCALING_FACTOR_INV;
         dlng = (ofs_east * LOCATION_SCALING_FACTOR_INV) / longitude_scale(loc);
         lato=lat + dlat;
         lngo=lng + dlng;
         loco=[lato lngo];
end

