function  update_STE_rate_lim( )
 global STEdot_max
 global STEdot_min
 global maxClimbRate
 global minSinkRate
 global GRAVITY_MSS
    % Calculate Specific Total Energy Rate Limits
    % This is a trivial calculation at the moment but will get bigger once we start adding altitude effects
    STEdot_max = maxClimbRate * GRAVITY_MSS;
    STEdot_min = - minSinkRate * GRAVITY_MSS;
 

end

