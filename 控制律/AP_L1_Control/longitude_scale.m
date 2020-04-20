function scale=longitude_scale(loc)
 global HD
 lat=loc(1);
    scale=constrain_value(cos(lat*1e-7 / HD), 0.01, 1.0);
end

