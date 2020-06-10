function bearing=get_bearing_to(loc2,loc)  
global HD
 loc2_lat=loc2(1);
 loc2_lng=loc2(2);
 loc_lat=loc(1);
 loc_lng=loc(2);
     off_x = loc2_lng - loc_lng;
     off_y = (loc2_lat - loc_lat) / longitude_scale(loc);   
     bearing = 9000 + atan2(-off_y, off_x) * HD*100;
    if (bearing < 0)  
        bearing =bearing+ 36000;
    end 
end

