function    update_xy_controller()

% update_xy_controller - run the horizontal position controller - should be called at 100hz or higher
 

global dt

    

    % check for ekf xy position reset
%     check_for_ekf_xy_reset();

    % check if xy leash needs to be recalculated
    calc_leash_length_xy();

    % translate any adjustments from pilot to loiter target
    desired_vel_to_pos(dt);

    % run horizontal position controller
    run_xy_controller(dt);
 
 

end

