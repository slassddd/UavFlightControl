clear,clc
syms dt
q0 = sym('q0','real');
q1 = sym('q1','real');
q2 = sym('q2','real');
q3 = sym('q3','real');
syms pn pe pd vn ve vd
syms dax_b day_b daz_b
syms dvx_b dvy_b dvz_b
syms magNavX magNavY magNavZ
syms magBiasX magBiasY magBiasZ
syms dvx dvy dvz 
syms dangx  dangy dangz
syms gnavx gnavy gnavz
syms square_dang_dab
q = [q0;q1;q2;q3];
% x = [q.',pn,pe,pd,vn,ve,vd,dax_b,day_b,daz_b,dvx_b,dvy_b,...
%      dvz_b,magNavX,magNavY,magNavZ,magX,magY,magZ];
q_pre = q; % ��һʱ�̵�quat
p = [pn;pe;pd];
v = [vn;ve;vd];
dv_b = [dvx_b;dvy_b;dvz_b]; % �ٶ�����ƫ��
da_b = [dax_b;day_b;daz_b;];  % ������ƫ��
dvel = [dvx;dvy;dvz]; % ʵ�ʲ����ٶ�����
dang = [dangx;dangy;dangz];
magNav = [magNavX;magNavY;magNavZ];
mag = [magBiasX;magBiasY;magBiasZ];
x = [q;p;v;da_b;dv_b;magNav;mag];
% quat��dt�ڵ�����
if 0 % �޽���
    dq = rotvec2quat(dang - da_b); 
else % ��תʸ������Ԫ����С������
    dq = [1;1/2*(dang - da_b)];
end
q_post = quaternionTimes(q_pre,dq);
gnav = [gnavx;gnavy;gnavz];
dv = dvel - dv_b; % �������ٶ�����
%% 1. stateTransFcn x
f = [
    q_post
    p + v*dt
    v + gnav*dt + RotateMatrixQuat(q_pre,'fromBodyToNav')*dv;
    da_b
    dv_b
    magNav
    mag];
%% 2. stateTransJacobianFcn dfdx
dfdx = jacobian(f,x);
dfdx = subs(dfdx,(dangx - dax_b)^2 + (dangy - day_b)^2 + (dangz - daz_b)^2,square_dang_dab);  %
dfdx = subs(dfdx,sin(square_dang_dab^(1/2)/2)/square_dang_dab^(1/2),1/2); % С�����ƣ�  sin(x)/x = 1
dfdx = subs(dfdx,cos(square_dang_dab^(1/2)/2),1); % С������ cos(x) = 1;
dfdx = subs(dfdx,sin(square_dang_dab^(1/2)/2),0); % 
%% 3. processNoiseJacobianFcn dwdx
syms daxCov dayCov dazCov dvxCov dvyCov dvzCov
u = [dang;dvel];
L = jacobian(f,u);
w = [daxCov dayCov dazCov dvxCov dvyCov dvzCov]; % ������������
W = diag(w*dt^2);
dwdx = L*W*L.';
%% 4. magMeasFcn z �����Ʋ���
magBias = [magBiasX magBiasY magBiasZ].';
z_mag = magBias + RotateMatrixQuat(q_pre,'fromNavToBody')*magNav;
%% 5. magMeasJacobianFcn dhdx �����Ʋ���Jacobi
dhdx_mag = jacobian(z_mag,x);