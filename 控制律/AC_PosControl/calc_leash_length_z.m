function  calc_leash_length_z()
global recalc_leash_z 
global leash_up_z
global leash_down_z
global POSCONTROL_SPEED_DOWN
global POSCONTROL_SPEED_UP
global POSCONTROL_ACCEL_Z
global POSCONTROL_POS_Z_P
    if (  recalc_leash_z)  
        leash_up_z = calc_leash_length(POSCONTROL_SPEED_UP, POSCONTROL_ACCEL_Z, POSCONTROL_POS_Z_P);
        leash_down_z = calc_leash_length(-POSCONTROL_SPEED_DOWN, POSCONTROL_ACCEL_Z, POSCONTROL_POS_Z_P);
        recalc_leash_z = 0;
    end
end

