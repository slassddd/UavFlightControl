function  calc_nav_yaw_coordinated( speed_scaler)
%   calculate yaw control for coordinated flight
  global k_rudder
  global k_aileron
  global kff_rudder_mix
  global disable_integrator_yaw
 
%      rudder_in = rudder_input();
    % Received an external msg that guides yaw in the last 3 seconds?
%     if ((control_mode == &mode_guided || control_mode == &mode_avoidADSB) &&
%             plane.guided_state.last_forced_rpy_ms.z > 0 &&
%             millis() - plane.guided_state.last_forced_rpy_ms.z < 3000)  
%         commanded_rudder = plane.guided_state.forced_rpy_cd.z;
%       else  
%         if (control_mode == &mode_stabilize && rudder_in != 0)  
        commanded_rudder = get_servo_out_yaw(speed_scaler, disable_integrator_yaw);

        % add in rudder mixing from roll
        commanded_rudder =commanded_rudder+ k_aileron * kff_rudder_mix;
%         commanded_rudder =commanded_rudder+ rudder_in;    
    k_rudder = constrain_value(commanded_rudder, -4500, 4500);
 
end

