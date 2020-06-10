function m=rotation_matrix(q)
 
    q1=q(1);
    q2=q(2);
    q3=q(3);
    q4=q(4);
    q3q3 = q3 * q3;
    q3q4 = q3 * q4;
    q2q2 = q2 * q2;
    q2q3 = q2 * q3;
    q2q4 = q2 * q4;
    q1q2 = q1 * q2;
    q1q3 = q1 * q3;
    q1q4 = q1 * q4;
    q4q4 = q4 * q4;
    m=zeros(3,3);
    m(1,1) = 1.0-2.0*(q3q3 + q4q4);
    m(1,2) = 2.0*(q2q3 - q1q4);
    m(1,3) = 2.0*(q2q4 + q1q3);
    m(2,1) = 2.0*(q2q3 + q1q4);
    m(2,2) = 1.0-2.0*(q2q2 + q4q4);
    m(2,3) = 2.0*(q3q4 - q1q2);
    m(3,1) = 2.0*(q2q4 - q1q3);
    m(3,2) = 2.0*(q3q4 + q1q2);
    m(3,3) = 1.0-2.0*(q2q2 + q3q3);
end

