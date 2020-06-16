function  euler_angle= to_euler(q)
q1=q(1);
q2=q(2);
q3=q(3);
q4=q(4);
roll=atan2(2.0*(q1*q2 + q3*q4), 1.0 - 2.0*(q2*q2 + q3*q3));
pitch=asin(2.0*(q1*q3 - q4*q2));
yaw=atan2(2.0*(q1*q4 + q2*q3), 1.0 - 2.0*(q3*q3 + q4*q4));
euler_angle=[roll,pitch,yaw];
end

