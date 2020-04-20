function  distance_NE=get_distance_NE( loc2,loc)  
 global LOCATION_SCALING_FACTOR
 loc2_lat=loc2(1);
 loc2_lng=loc2(2);
 loc_lat=loc(1);
 loc_lng=loc(2);
   distance_NE=[ (loc2_lat - loc_lat) * LOCATION_SCALING_FACTOR,(loc2_lng - loc_lng) * LOCATION_SCALING_FACTOR * longitude_scale(loc)];
end

