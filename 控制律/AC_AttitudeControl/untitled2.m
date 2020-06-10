function euler_rado=ang_vel_limit( euler_radin, ang_vel_roll_max,  ang_vel_pitch_max,  ang_vel_yaw_max) 
 euler_rad.x=euler_radin(1);
 euler_rad.y=euler_radin(2);
 euler_rad.z=euler_radin(3);
    if (ang_vel_roll_max==0||ang_vel_pitch_max==0)  
        if (ang_vel_roll_max~=0)  
            euler_rad.x = constrain_float(euler_rad.x, -ang_vel_roll_max, ang_vel_roll_max);
        end
        if ( ang_vel_pitch_max~=0)  
            euler_rad.y = constrain_float(euler_rad.y, -ang_vel_pitch_max, ang_vel_pitch_max);
        end
    else  
         thrust_vector_ang_vel.x=euler_rad.x / ang_vel_roll_max;
         thrust_vector_ang_vel.y=euler_rad.y / ang_vel_pitch_max;
          thrust_vector_length = norm([thrust_vector_ang_vel.x,thrust_vector_ang_vel.y],2);
        if (thrust_vector_length > 1.0)  
            euler_rad.x = thrust_vector_ang_vel.x * ang_vel_roll_max / thrust_vector_length;
            euler_rad.y = thrust_vector_ang_vel.y * ang_vel_pitch_max / thrust_vector_length;
         
     
    if ( ang_vel_yaw_max~=0)  
        euler_rad.z = constrain_float(euler_rad.z, -ang_vel_yaw_max, ang_vel_yaw_max);
    end
 
    end