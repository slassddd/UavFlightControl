function   radiuso=loiter_radius(radius)  
global loiter_bank_limit
global GRAVITY_MSS
global EAS_dem
global EAS2TAS
    % prevent an insane loiter bank limit
     sanitized_bank_limit = constrain_value(loiter_bank_limit, 0.0, 89.0);
     lateral_accel_sea_level = tan(radians(sanitized_bank_limit)) * GRAVITY_MSS;
 
     nominal_velocity_sea_level = EAS_dem;
     

     eas2tas_sq = EAS2TAS.^2;

    if (is_zero(sanitized_bank_limit) || is_zero(nominal_velocity_sea_level) ||is_zero(lateral_accel_sea_level))  
        % Missing a sane input for calculating the limit, or the user has
        % requested a straight scaling with altitude. This will always vary
        % with the current altitude, but will at least protect the airframe
        radiuso= radius * eas2tas_sq;
    else  
         sea_level_radius = (nominal_velocity_sea_level).^2 / lateral_accel_sea_level;
        if (sea_level_radius > radius)  
            % If we've told the plane that its sea level radius is unachievable fallback to
            % straight altitude scaling
            radiuso= radius * eas2tas_sq;
          else  
            % select the requested radius, or the required altitude scale, whichever is safer
            radiuso= max(sea_level_radius * eas2tas_sq, radius);
        end
    end
         
end

