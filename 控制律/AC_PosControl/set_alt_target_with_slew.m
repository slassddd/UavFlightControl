function  set_alt_target_with_slew(  alt_cm,   dt)
% set_alt_target_with_slew - adjusts target towards a final altitude target
%     should be called continuously (with dt set to be the expected time between calls)
%     actual position target will be moved no faster than the speed_down and speed_up
%     target will also be stopped if the motors hit their limits or leash length is exceeded
global curr_alt
global pos_target
global use_desvel_ff_z
global throttle_lower
global throttle_upper
global POSCONTROL_SPEED_DOWN
global POSCONTROL_SPEED_UP
global vel_desired
global leash_down_z
global leash_up_z

      alt_change = alt_cm - pos_target(3);
    % do not use z-axis desired velocity feed forward
       use_desvel_ff_z = 1;
    % adjust desired alt if motors have not hit their limits
    if ((alt_change < 0 && ~ throttle_lower) || (alt_change > 0 && ~throttle_upper))  
        if (dt~=0)  
            climb_rate_cms = constrain_value(alt_change / dt, POSCONTROL_SPEED_DOWN, POSCONTROL_SPEED_UP);
            pos_target(3)=pos_target(3) + climb_rate_cms * dt;
            vel_desired(3) = climb_rate_cms;  % recorded for reporting purposes
        end        
    else
        % recorded for reporting purposes
            vel_desired(3) = 0.0;        
    end

    % do not let target get too far from current altitude
     pos_target(3) = constrain_value(pos_target(3), curr_alt - leash_down_z, curr_alt + leash_up_z);
 
end

