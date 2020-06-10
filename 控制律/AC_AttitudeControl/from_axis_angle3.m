function q=from_axis_angle3(v)
    theta = norm(v,2);
    if ( theta==0 )  
        q1 = 1.0 ;
        q2=0;
        q3=0;
        q4=0.0 ;
    q=[q1 q2 q3 q4];
    else    
    v =v/theta;
    q=from_axis_angle(v,theta);
    end

end

