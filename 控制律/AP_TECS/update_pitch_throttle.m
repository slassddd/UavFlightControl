function update_pitch_throttle(  hgt_dem_cm,EAS_dem_cm,load_factor)
 global hgt_dem 
 global EAS_dem
 global pitch_max
 global pitch_min
 global pitch_limit_max_cd
 global pitch_limit_min_cd
 global PITCHmaxf
 global PITCHminf
 global pitch_max_limit
 global throttle_max
 global throttle_min
 global THRmaxf
 global THRminf

    % Convert inputs
    hgt_dem = hgt_dem_cm * 0.01;
    EAS_dem = EAS_dem_cm * 0.01;
    % Update the speed estimate using a 2nd order complementary filter
    update_speed(load_factor);
    THRmaxf  =throttle_max * 0.01;
    THRminf  =throttle_min * 0.01;

    % work out the maximum and minimum pitch
    % if TECS_PITCH_ MAX,MIN  isn't set then use
    % LIM_PITCH_ MAX,MIN . Don't allow TECS_PITCH_ MAX,MIN  to be
    % larger than LIM_PITCH_ MAX,MIN 
    if (pitch_max <= 0)  
        PITCHmaxf = pitch_limit_max_cd * 0.01;
      else  
        PITCHmaxf = min(pitch_max, pitch_limit_max_cd * 0.01);
    end

    if (pitch_min >= 0)  
        PITCHminf = pitch_limit_min_cd * 0.01;
     else  
        PITCHminf = max(pitch_min, pitch_limit_min_cd * 0.01);
    end

    % apply temporary pitch limit and clear
    if (pitch_max_limit < 90)  
        PITCHmaxf = constrain_value(PITCHmaxf, -90, pitch_max_limit);
        PITCHminf = constrain_value(PITCHminf, -pitch_max_limit, PITCHmaxf);
        pitch_max_limit = 90;
    end
           
    % convert to radians
    PITCHmaxf = radians(PITCHmaxf);
    PITCHminf = radians(PITCHminf);

    % initialise selected states and variables if DT > 1 second or in climbout
%     initialise_states(ptchMinCO_cd, hgt_afe);

    % Calculate Specific Total Energy Rate Limits
    update_STE_rate_lim();

    % Calculate the speed demand
    update_speed_demand();

    % Calculate the height demand
    update_height_demand();

    % Detect underspeed condition
%     detect_underspeed();

    % Calculate specific energy quantitiues
    update_energies();

    % Calculate throttle demand - use simple pitch to throttle if no
    % airspeed sensor.
    % Note that caller can demand the use of
    % synthetic airspeed for one loop if needed. This is required
    % during QuadPlane transition when pitch is constrained
    update_throttle_with_airspeed();
     

    % Detect bad descent due to demanded airspeed being too high
%     detect_bad_descent();

    % when soaring is active we never trigger a bad descent
%     if (soaring_active)  
%        badDescent = 0;        
%     end

    % Calculate pitch demand
    update_pitch();

 
end

