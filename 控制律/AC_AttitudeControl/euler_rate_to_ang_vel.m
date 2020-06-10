function ang_vel_radso = euler_rate_to_ang_vel(euler_radi,euler_rate_radsi)
    euler_rad.x=euler_radi(1);
    euler_rad.y=euler_radi(2);
    euler_rad.z=euler_radi(3);
    euler_rate_rads.x=euler_rate_radsi(1);
    euler_rate_rads.y=euler_rate_radsi(2);
    euler_rate_rads.z=euler_rate_radsi(3);
    
    sin_theta = sin(euler_rad.y);
    cos_theta = cos(euler_rad.y);
    sin_phi = sin(euler_rad.x);
    cos_phi = cos(euler_rad.x);

    ang_vel_rads.x = euler_rate_rads.x - sin_theta * euler_rate_rads.z;
    ang_vel_rads.y = cos_phi * euler_rate_rads.y + sin_phi * cos_theta * euler_rate_rads.z;
    ang_vel_rads.z = -sin_phi * euler_rate_rads.y + cos_theta * cos_phi * euler_rate_rads.z;
    ang_vel_radso=[ang_vel_rads.x ang_vel_rads.y ang_vel_rads.z];
end
