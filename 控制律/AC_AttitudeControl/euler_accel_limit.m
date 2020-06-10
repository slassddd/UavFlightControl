function rot_accelo=euler_accel_limit(euler_radin, euler_accelin)

 euler_rad.x=euler_radin(1);
 euler_rad.y=euler_radin(2);
 euler_rad.z=euler_radin(3);
 euler_accel.x=euler_accelin(1);
 euler_accel.y=euler_accelin(2);
 euler_accel.z=euler_accelin(3);
 
      sin_phi = constrain_value (abs(sin(euler_rad.x)), 0.1, 1.0);
      cos_phi = constrain_value (abs(cos(euler_rad.x)), 0.1, 1.0);
      sin_theta = constrain_value (abs(sin(euler_rad.y)), 0.1, 1.0);

    if (is_zero(euler_accel.x) || is_zero(euler_accel.y) || is_zero(euler_accel.z) || is_negative(euler_accel.x) || is_negative(euler_accel.y) || is_negative(euler_accel.z))  
        rot_accel.x = euler_accel.x;
        rot_accel.y = euler_accel.y;
        rot_accel.z = euler_accel.z;
     else  
        rot_accel.x = euler_accel.x;
        rot_accel.y = min(euler_accel.y / cos_phi, euler_accel.z / sin_phi);
        rot_accel.z = min(min(euler_accel.x / sin_theta, euler_accel.y / sin_phi), euler_accel.z / cos_phi);
    end
    rot_accelo=[rot_accel.x rot_accel.y rot_accel.z];

end

