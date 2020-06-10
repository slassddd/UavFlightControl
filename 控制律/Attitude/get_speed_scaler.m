function speed_scaler=get_speed_scaler()
global aspeed
global highest_airspeed
global scaling_speed
global airspeed_min
global airspeed_max

 %   get a speed scaling number for control surfaces. This is applied to
%   PIDs to change the scaling of the PID with speed. At high speed we
%   move the surfaces less, and at low speeds we move them more.

        if (aspeed > highest_airspeed)  
            highest_airspeed = aspeed;
        end
        if (aspeed > 0.0001)  
            speed_scaler = scaling_speed / aspeed;
        else  
            speed_scaler = 2.0;
        end
        % ensure we have scaling over the full configured airspeed
          scale_min = min(0.5, (0.5 * airspeed_min) / scaling_speed);
          scale_max = max(2.0, (1.5 * airspeed_max) / scaling_speed);
          speed_scaler = constrain_value(speed_scaler, scale_min, scale_max);
end

