function update_loiter( center_WP,   radius,   loiter_direction)
 
 global L1_period
 global L1_damping
 global L1_dist
 global groundspeed_vector
 global target_bearing_cd
 global yaw
 global last_Nu
 global crosstrack_error
 global data_is_stale
 global latAccDem
 global WPcircle
 global bearing_error
 global nav_bearing
 global current_loc
 
    % scale loiter radius with square of EAS2TAS to allow us to stay
    % stable at high altitude
    radius = loiter_radius(abs(radius));
    % Calculate guidance gains used by PD loop (used during circle tracking)
      omega = (6.2832 / L1_period);
      Kx = omega * omega;
      Kv = 2.0 * L1_damping * omega;
    % Calculate L1 gain required for specified damping (used during waypoint capture)
      K_L1 = 4.0* L1_damping * L1_damping;
    %Get current position and velocity
    %Calculate groundspeed
      groundspeed_vector_length=norm(groundspeed_vector,2);
      groundSpeed = max(groundspeed_vector_length , 1.0);
    % update _target_bearing_cd
      target_bearing_cd = get_bearing_to(center_WP,current_loc);


    % Calculate time varying control parameters
    % Calculate the L1 length required for specified period
    % 0.3183099 = 1/pi
    L1_dist = 0.3183099 * L1_damping * L1_period * groundSpeed;

    %Calculate the NE position of the aircraft relative to WP A
    A_air = get_distance_NE(current_loc,center_WP);
    A_air_length=norm(A_air,2);
    % Calculate the unit vector from WP A to aircraft
    % protect against being on the waypoint and having zero velocity
    % if too close to the waypoint, use the velocity vector
    % if the velocity vector is too small, use the heading vector
     if (A_air_length > 0.1)  
        A_air_unit = A_air/A_air_length;
      else  
        if (groundspeed_vector_length < 0.1)  
            A_air_unit = [cos(yaw), sin(yaw)];
          else  
            A_air_unit = groundspeed_vector/groundspeed_vector_length;
        end
     end
     

    %Calculate Nu to capture center_WP
      xtrackVelCap = cross2D(A_air_unit , groundspeed_vector); % Velocity across line - perpendicular to radial inbound to WP
      ltrackVelCap = - (groundspeed_vector * A_air_unit'); % Velocity along line - radial inbound to WP
      Nu = atan2(xtrackVelCap,ltrackVelCap);

    Nu=prevent_indecision(Nu);
    last_Nu = Nu;

    Nu = constrain_value (Nu, -pi/2, pi/2); %Limit Nu to +- Pi/2

    %Calculate lat accln demand to capture center_WP (use L1 guidance law)
      latAccDemCap = K_L1 * groundSpeed * groundSpeed / L1_dist * sin(Nu);

    %Calculate radial position and velocity errors
      xtrackVelCirc = -ltrackVelCap; % Radial outbound velocity - reuse previous radial inbound velocity
      xtrackErrCirc = A_air_length - radius; % Radial distance from the loiter circle

    % keep crosstrack error for reporting
     crosstrack_error = xtrackErrCirc;

    %Calculate PD control correction to circle waypoint_ahrs.roll
      latAccDemCircPD = (xtrackErrCirc * Kx + xtrackVelCirc * Kv);

    %Calculate tangential velocity
      velTangent = xtrackVelCap *  (loiter_direction);

    %Prevent PD demand from turning the wrong way by limiting the command when flying the wrong way
    if (ltrackVelCap < 0.0 && velTangent < 0.0)  
        latAccDemCircPD =  max(latAccDemCircPD, 0.0);
    end

    % Calculate centripetal acceleration demand
      latAccDemCircCtr = velTangent * velTangent / max((0.5 * radius), (radius + xtrackErrCirc));

    %Sum PD control and centripetal acceleration to calculate lateral manoeuvre demand
      latAccDemCirc = loiter_direction * (latAccDemCircPD + latAccDemCircCtr);

    % Perform switchover between 'capture' and 'circle' modes at the
    % point where the commands cross over to achieve a seamless transfer
    % Only fly 'capture' mode if outside the circle
    if (xtrackErrCirc > 0.0 && loiter_direction * latAccDemCap < loiter_direction * latAccDemCirc)  
        latAccDem = latAccDemCap;
        WPcircle = 0;
        bearing_error = Nu; % angle between demanded and achieved velocity vector, +ve to left of track
        nav_bearing = atan2(-A_air_unit(2) , -A_air_unit(1)); % bearing (radians) from AC to L1 point
      else  
        latAccDem = latAccDemCirc;
        WPcircle = 1;
        bearing_error = 0.0; % bearing error (radians), +ve to left of track
        nav_bearing = atan2(-A_air_unit(2) , -A_air_unit(1)); % bearing (radians)from AC to L1 point
    end

    data_is_stale = 0; % status are correctly updated with current waypoint data
 

end

