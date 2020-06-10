function  calc_nav_roll()
 global nav_roll_cd
 global roll_limit_cd
      commanded_roll = nav_roll_cd1();

    % Received an external msg that guides roll in the last 3 seconds?
%     if ((control_mode == &mode_guided || control_mode == &mode_avoidADSB) &&
%             plane.guided_state.last_forced_rpy_ms.x > 0 &&
%             millis() - plane.guided_state.last_forced_rpy_ms.x < 3000)  
%             commanded_roll = plane.guided_state.forced_rpy_cd.x;
%     end

    nav_roll_cd = constrain_value(commanded_roll, -roll_limit_cd, roll_limit_cd);
    update_load_factor();
 
end

