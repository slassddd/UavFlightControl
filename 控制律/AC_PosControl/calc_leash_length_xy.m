function calc_leash_length_xy()
% calc_leash_length - calculates the horizontal leash length given a maximum speed, acceleration
%     should be called whenever the speed, acceleration or position kP is modified
%     // todo: remove _flags.recalc_leash_xy or don't call this function after each variable change.
global recalc_leash_xy  
global leash
global POSCONTROL_SPEED
global POSCONTROL_ACCEL_XY
global POSCONTROL_POS_XY_P
 
    if ( recalc_leash_xy)  
            leash = calc_leash_length(POSCONTROL_SPEED, POSCONTROL_ACCEL_XY,POSCONTROL_POS_XY_P);
            recalc_leash_xy = 0;
    end
 
end

