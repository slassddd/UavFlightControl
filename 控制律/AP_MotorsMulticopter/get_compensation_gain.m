function    ret=get_compensation_gain() 
global air_density_ratio
    % avoid divide by zero 
    ret=1;
     % air density ratio is increasing in density / decreasing in altitude
    if (air_density_ratio > 0.3 && air_density_ratio < 1.5) 
        ret=ret *1.0 / constrain_value(air_density_ratio,0.5,1.25);
    end
end

