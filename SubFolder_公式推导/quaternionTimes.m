function out = quaternionTimes(p,q)
% 四元数乘法
% 测试用例
% p = rand(1,4);
% q = rand(1,4);
% p_quat = quaternion(p);
% q_quat = quaternion(q);
% r_quat = compact(p_quat*q_quat);
% r = quaternionTimes(p,q);
% fprintf('r-r_quat = [%.4f, %.4f, %.4f, %.4f]\n',r'-r_quat);

ap = p(1);
bp = p(2);
cp = p(3);
dp = p(4);
aq = q(1);
bq = q(2);
cq = q(3);
dq = q(4);
out = [ap*aq-bp*bq-cp*cq-dp*dq;
       ap*bq+bp*aq+cp*dq-dp*cq;
       ap*cq-bp*dq+cp*aq+dp*bq;
       ap*dq+bp*cq-cp*bq+dp*aq;];