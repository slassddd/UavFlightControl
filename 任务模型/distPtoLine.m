function [dist,Pd,isIn] = distPtoLine(L0,Lf,P)
% 计算点到直线距离
% L0、Lf:直线端点坐标（x,y）
% P: 点
% example:
% [dist,Pd,isIn] = distPtoLine([0,0],[100,100],[0,100])
% [dist,Pd,isIn] = distPtoLine([0,0],[0,100],[100,100])
% [dist,Pd,isIn] = distPtoLine([0,0],[100,100],[0,200])
% [dist,Pd,isIn] = distPtoLine([0,0],[0,100],[100,-100])
x1 = L0(1);
y1 = L0(2);
x2 = Lf(1);
y2 = Lf(2);
xp = P(1);
yp = P(2);
if abs(x1-x2) > 10
    k = (y1-y2)/(x1-x2);
    b = y1 - k*x1;
    A = k;
    B = -1;
    C = b;
    dist = abs(A*xp+B*yp+C)/norm([A,B]);
    Pd = [(B*B*xp-A*B*yp-A*C)/norm([A,B]),(A*A*yp-A*B*xp-B*C)/norm([A,B])];
else % 直线接近于平行经线
    dist = abs(xp-(x1+x2)/2);
    Pd = [(x1+x2)/2,yp];
end
isIn = true;
if (Pd(1) > L0(1) && Pd(1) > Lf(1)) || (Pd(1) < L0(1) && Pd(1) < Lf(1)) || ...
        (Pd(2) > L0(2) && Pd(2) > Lf(2)) || (Pd(2) < L0(2) && Pd(2) < Lf(2))
    isIn = false;
end
    