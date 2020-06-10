function v =to_axis_angle(q)
q1=q(1);
q2=q(2);
q3=q(3);
q4=q(4);  
l = sqrt((q2)^2+(q3)^2+(q4)^2);
v = [q2,q3,q4];
    if (l~=0)        
        v =v/ l;
        v =v* wrap_PI(2.0 * atan2(l,q1));
    end
end

