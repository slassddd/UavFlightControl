function euler_rate_radso = ang_vel_to_euler_rate(euler_radi,ang_vel_radsi)
 
 euler_rad.x=euler_radi(1);
 euler_rad.y=euler_radi(2);
 euler_rad.z=euler_radi(3);
 ang_vel_rads.x=ang_vel_radsi(1);
 ang_vel_rads.y=ang_vel_radsi(2);
 ang_vel_rads.z=ang_vel_radsi(3);
    sin_theta = sin(euler_rad.y);
    cos_theta = cos(euler_rad.y);
    sin_phi = sin(euler_rad.x);
    cos_phi = cos(euler_rad.x);

    if (cos_theta==0) 
     cos_theta=1e-6;
    end
    euler_rate_rads.x = ang_vel_rads.x + sin_phi * (sin_theta / cos_theta) * ang_vel_rads.y + cos_phi * (sin_theta / cos_theta) * ang_vel_rads.z;
    euler_rate_rads.y = cos_phi * ang_vel_rads.y - sin_phi * ang_vel_rads.z;
    euler_rate_rads.z = (sin_phi / cos_theta) * ang_vel_rads.y + (cos_phi / cos_theta) * ang_vel_rads.z;
    euler_rate_radso=[euler_rate_rads.x euler_rate_rads.y euler_rate_rads.z];
end

