function Mat = RotateMatrixQuat(q,mode)
% 生成四元数对应的坐标转换矩阵
% 测试用例
% r = [3,-2.3,1.32];
% q = [1,2,3,4];
% q = q/norm(q);
% x1 = rotateframe(conj(quaternion(q)),r)';
% x2 = RotateMatrixQuat(q)*r';
% x1-x2

q0 = q(1);
q1 = q(2);
q2 = q(3);
q3 = q(4);
Mat = [q0^2+q1^2-q2^2-q3^2    -(2*q0*q3 - 2*q1*q2)   (2*q0*q2 + 2*q1*q3);
               (2*q0*q3 + 2*q1*q2)     q0^2-q1^2+q2^2-q3^2  -(2*q0*q1 - 2*q2*q3);
              -(2*q0*q2 - 2*q1*q3)     (2*q0*q1 + 2*q2*q3)    q0^2-q1^2-q2^2+q3^2;];
switch mode
    case 'fromBodyToNav'
        Mat = Mat;
    case 'fromNavToBody'
        Mat = Mat.';
end