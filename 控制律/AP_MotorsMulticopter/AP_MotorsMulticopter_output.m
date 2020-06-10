function   AP_MotorsMulticopter_output()
 
    % update throttle filter
    update_throttle_filter();

    % calc filtered battery voltage and lift_max
%     update_lift_max_from_batt_voltage();

    % run spool logic
%     output_logic();

    % calculate thrust
    output_armed_stabilizing();

    % apply any thrust compensation for the frame
%     thrust_compensation();
    
    % convert rpy_thrust values to pwm
    output_to_motors();

    % output any booster throttle
%     output_boost_throttle();

end

