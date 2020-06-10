function vec_ne=get_vector_xy_from_origin_NE( loc,loc_origin ) 
 global LOCATION_SCALING_FACTOR
 loc_lat=loc(1);
 loc_lng=loc(2);
 loc_origin_lat=loc_origin(1);
 loc_origin_lng=loc_origin(2);
    vec_ne=[0 0];
    vec_ne(1) = (loc_lat-loc_origin_lat) * LOCATION_SCALING_FACTOR;
    vec_ne(2) = (loc_lng-loc_origin_lng) * LOCATION_SCALING_FACTOR * longitude_scale(loc_origin);

end

