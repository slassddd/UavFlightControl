function  stabilize_roll(  speed_scaler)
%   this is the main roll stabilization function. It takes the
%   previously set nav_roll calculates roll servo_out to try to
%   stabilize the plane at the given roll
 global inverted_flight
 global nav_roll_cd
 global roll
 global k_aileron
 global HD
 global disable_integrator_roll
    if (inverted_flight)  
        % we want to fly upside down. We need to cope with wrap of
        % the roll_sensor interfering with wrap of nav_roll, which
        % would really confuse the PID code. The easiest way to
        % handle this is to ensure both go in the same direction from
        % zero
        nav_roll_cd=nav_roll_cd + 18000;
        if (roll < 0) 
            nav_roll_cd=nav_roll_cd - 36000;
        end
    end
    k_aileron=get_servo_out_roll(nav_roll_cd - roll*HD*100, speed_scaler, disable_integrator_roll);
     
     
%     SRV_Channels::set_output_scaled(SRV_Channel::k_aileron, rollController.get_servo_out(nav_roll_cd - ahrs.roll_sensor, 
%                                                                                          speed_scaler, 
%                                                                                          disable_integrator));
 
end

