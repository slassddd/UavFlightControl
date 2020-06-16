function set_alt_target_from_climb_rate(  climb_rate_cms,   dt,   force_descend)
% set_alt_target_from_climb_rate - adjusts target up or down using a climb rate in cm/s
%     should be called continuously (with dt set to be the expected time between calls)
%     actual position target will be moved no faster than the speed_down and speed_up
%     target will also be stopped if the motors hit their limits or leash length is exceeded
 global throttle_lower
 global throttle_upper
 global limit_pos_up
 global use_desvel_ff_z
 global vel_desired
 global pos_target
    % adjust desired alt if motors have not hit their limits
    % To-Do: add check of _limit.pos_down?
    if ((climb_rate_cms < 0 && (~throttle_lower || force_descend)) || (climb_rate_cms > 0 && ~throttle_upper && ~limit_pos_up))  
         pos_target(3)=pos_target(3)+climb_rate_cms * dt;
    end

    % do not use z-axis desired velocity feed forward
    % vel_desired set to desired climb rate for reporting and land-detector
     use_desvel_ff_z = 0;
     vel_desired(3) = climb_rate_cms;
 

end

