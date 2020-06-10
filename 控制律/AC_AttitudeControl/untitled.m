function ang_vel_radso = euler_rate_to_ang_vel(euler_radi,euler_rate_rads)
 
    sin_theta = sinf(euler_rad.y);
    cos_theta = cosf(euler_rad.y);
    sin_phi = sinf(euler_rad.x);
    cos_phi = cosf(euler_rad.x);

    ang_vel_rads.x = euler_rate_rads.x - sin_theta * euler_rate_rads.z;
    ang_vel_rads.y = cos_phi * euler_rate_rads.y + sin_phi * cos_theta * euler_rate_rads.z;
    ang_vel_rads.z = -sin_phi * euler_rate_rads.y + cos_theta * cos_phi * euler_rate_rads.z;
 