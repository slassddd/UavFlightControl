function update_vel_controller_xy()

% update_velocity_controller_xy - run the velocity controller - should be called at 100hz or higher
%     velocity targets should we set using set_desired_velocity_xy() method
%     callers should use get_roll() and get_pitch() methods and sent to the attitude controller
%     throttle targets will be sent directly to the motors
 
    %capture time since last iteration
global dt

    %sanity check dt
  

    %check for ekf xy position reset
%     check_for_ekf_xy_reset();

    %check if xy leash needs to be recalculated
    calc_leash_length_xy();

    %apply desired velocity request to position target
    %TODO: this will need to be removed and added to the calling function.
    desired_vel_to_pos(dt);

    %run position controller
    run_xy_controller(dt);

    %update xy update time
%     _last_update_xy_us = now_us;
 

end

