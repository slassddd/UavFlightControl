function leash_length=calc_leash_length( speed_cms,  accel_cms,  kP) 
 global POSCONTROL_ACCELERATION_MIN
 global POSCONTROL_LEASH_LENGTH_MIN
    %calc_leash_length - calculates the horizontal leash length given a maximum speed, acceleration and position kP gain
    % sanity check acceleration and avoid divide by zero
    if (accel_cms <= 0.0 )  
        accel_cms = POSCONTROL_ACCELERATION_MIN;
    end
     

    % avoid divide by zero
    if (kP <= 0.0 )  
        leash_length= POSCONTROL_LEASH_LENGTH_MIN;
        return
    end
     

    % calculate leash length
    if (speed_cms <= accel_cms / kP)  
        % linear leash length based on speed close in
        leash_length = speed_cms / kP;
     else  
        % leash length grows at sqrt of speed further out
        leash_length = (accel_cms / (2.0 * kP * kP)) + (speed_cms * speed_cms / (2.0 * accel_cms));
    end

    % ensure leash is at least 1m long
    if (leash_length < POSCONTROL_LEASH_LENGTH_MIN)  
        leash_length = POSCONTROL_LEASH_LENGTH_MIN;
    end
 
end

