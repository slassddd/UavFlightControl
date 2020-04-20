function  update_load_factor()
global aspeed
global smoothed_airspeed
global airspeed_min
global aerodynamic_load_factor
global nav_roll_cd
global roll_limit_cd
global roll_limit_cd_inint
global HD
%   calculate a new aerodynamic_load_factor and limit nav_roll_cd to
%   ensure that the load factor does not take us below the sustainable
%   airspeed
     demanded_roll = abs(nav_roll_cd*0.01);
    if (demanded_roll > 85)  
        % limit to 85 degrees to prevent numerical errors
        demanded_roll = 85;
    end
    aerodynamic_load_factor = 1.0/ sqrt(cos(radians(demanded_roll)));

%     if (quadplane.in_transition() &&
%         (quadplane.options & QuadPlane::OPTION_LEVEL_TRANSITION))  
%         % the user wants transitions to be kept level to within LEVEL_ROLL_LIMIT
%         roll_limit_cd = MIN(roll_limit_cd, g.level_roll_limit*100);
%         nav_roll_cd = constrain_int32(nav_roll_cd, -roll_limit_cd, roll_limit_cd);
%         return;
         
    smoothed_airspeed = smoothed_airspeed * 0.8 + aspeed * 0.2;
     max_load_factor = smoothed_airspeed / max(airspeed_min, 1);
    if (max_load_factor <= 1)  
        % our airspeed is below the minimum airspeed. Limit roll to
        % 25 degrees
%         nav_roll_cd = constrain_value(nav_roll_cd, -2500, 2500);
        roll_limit_cd=2500;
%         roll_limit_cd = min(roll_limit_cd, 2500); %byc xiugai 20191111
    elseif (max_load_factor < aerodynamic_load_factor)  
        % the demanded nav_roll would take us past the aerodymamic
        % load limit. Limit our roll to a bank angle that will keep
        % the load within what the airframe can handle. We always
        % allow at least 25 degrees of roll however, to ensure the
        % aircraft can be maneuvered with a bad airspeed estimate. At
        % 25 degrees the load factor is 1.1 (10%)
         roll_limit = (acos((1.0 / max_load_factor)^2))*100*HD;
        if (roll_limit < 2500)  
            roll_limit = 2500;
        end
        nav_roll_cd = constrain_value(nav_roll_cd, -roll_limit, roll_limit);
        roll_limit_cd = roll_limit;
%         roll_limit_cd = min(roll_limit_cd, roll_limit);  %byc xiugai 20191111   
    else
        nav_roll_cd = constrain_value(nav_roll_cd, -roll_limit_cd_inint, roll_limit_cd_inint);
        roll_limit_cd = roll_limit_cd_inint;       
        
    end
    
    
    
end

