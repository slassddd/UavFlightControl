function quat = rotvec2quat(r)
% 旋转矢量转换为四元数
% 测试用例
% r = [3,1,-2];
% quat = compact(quaternion(r,'rotvec'));
% quat1 = rotvec2quat(r);
% fprintf('q1-q2 = %.2f\n',quat1-quat);

n = size(r,1);
a = ones(n,1, 'like', r);
b = zeros(n,1, 'like', r);
c = b;
d = b;

theta = sqrt(sum(r.^2,2));
ct = cos(theta/2);
st = sin(theta/2);

for i = 1:n
    if theta(i) ~= 0
        qimag = (r(i,:)./theta(i)).*st(i);
        a(i) = ct(i);
        b(i) = qimag(1);
        c(i) = qimag(2);
        d(i) = qimag(3);
    end
end
quat = [a,b,c,d];