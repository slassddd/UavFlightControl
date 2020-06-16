function  accel_limiting(  enable_limits)
 global accel_roll_max
 global accel_roll_max_m
 global accel_pitch_max
 global accel_pitch_max_m
 global accel_yaw_max
 global accel_yaw_max_m
 
    if (enable_limits)  
        % If enabling limits, reload from eeprom or set to defaults
        if (accel_roll_max==0)  
            accel_roll_max=accel_roll_max_m;
        end
        if (accel_pitch_max==0)  
            accel_pitch_max=accel_pitch_max_m;
        end
        if (accel_yaw_max==0)  
            accel_yaw_max=accel_yaw_max_m;
        end
    else  
        accel_roll_max = 0.0 ;
        accel_pitch_max = 0.0 ;
        accel_yaw_max = 0.0 ;
    end
 
end

