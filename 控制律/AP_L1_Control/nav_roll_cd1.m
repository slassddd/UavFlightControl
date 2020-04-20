function    ret=nav_roll_cd1( )  
 global pitch
 global HD
 global latAccDem
 
    ret = cos(pitch)*atan(latAccDem * 0.101972) * 100.0*HD; % 0.101972 = 1/9.81
    ret = constrain_value(ret, -9000, 9000);
  
end

