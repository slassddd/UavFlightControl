function q = from_axis_angle(axisin, theta)
 axis.x=axisin(1);
 axis.y=axisin(2);
 axis.z=axisin(3);
    % axis must be a unit vector as there is no check for length
    if (theta==0)  
        q1=1.0;
        q2=0;
        q3=0;
        q4=0.0;
    else        
    st2 = sin(theta/2.0);
    q1 = cos(theta/2.0);
    q2 = axis.x * st2;
    q3 = axis.y * st2;
    q4 = axis.z * st2;
    end
      q=[q1 q2 q3 q4];
end

