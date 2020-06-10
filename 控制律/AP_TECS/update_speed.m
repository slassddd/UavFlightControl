function  update_speed(load_factor)
 global dt
 global EAS2TAS
 global TAS_dem
 global TASmax
 global TASmin
 global EAS_dem
 global airspeed_max
 global airspeed_min
 global aspeed
 global TAS_state
 global spdCompFiltOmega
 global integDTAS_state
 global vel_dot
    % Calculate time in seconds since last update
    % Convert equivalent airspeeds to true airspeeds
    EAS=aspeed;
    TAS_dem = EAS_dem * EAS2TAS;
    TASmax   = airspeed_max * EAS2TAS;
    TASmin   = airspeed_min * EAS2TAS;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        TASmin =TASmin* load_factor;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (TASmax < TASmin)  
        TASmax = TASmin;
    end
    if (TASmin > TAS_dem)  
        TASmin = TAS_dem;
    end

    % Reset states of time since last update is too large
     

    % Get airspeed or default to halfway between min and max if
    % airspeed is not being used and set speed rate to zero
  

    % Implement a second order complementary filter to obtain a
    % smoothed airspeed estimate
    % airspeed estimate is held in _TAS_state
      aspdErr = ( EAS * EAS2TAS) - TAS_state;
      integDTAS_input = aspdErr * spdCompFiltOmega * spdCompFiltOmega;
    % Prevent state from winding up
    if (TAS_state < 3.1)  
        integDTAS_input = max(integDTAS_input , 0.0);
    end
    integDTAS_state = integDTAS_state + integDTAS_input * dt;
    TAS_input = integDTAS_state + vel_dot + aspdErr * spdCompFiltOmega * 1.4142;
    TAS_state = TAS_state + TAS_input * dt;
    % limit the airspeed to a minimum of 3 m/s
    TAS_state = max(TAS_state, 3.0);
end

