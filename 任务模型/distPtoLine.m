function [dist,Pd,isIn] = distPtoLine(L0,Lf,P)
% 计算点到直线距离
% L0、Lf:直线端点坐标（x,y）
% P: 点
% example:
% [dist,Pd,isIn] = distPtoLine([0,0],[100,100],[0,100])
% [dist,Pd,isIn] = distPtoLine([0,0],[0,100],[100,100])
% [dist,Pd,isIn] = distPtoLine([0,0],[100,100],[0,200])
% [dist,Pd,isIn] = distPtoLine([0,0],[0,100],[100,-100]);fprintf('dist: %.0f m       Pd: [%.0f,%.0f]          isIn: %.0f\n',dist,Pd,isIn)
% P0=[0,0];Pf=[100,100];Pc=[100,0];[dist,Pd,isIn] = distPtoLine(P0,Pf,Pc); fprintf('dist: %.0f m       Pd: [%.0f,%.0f]          isIn: %.0f\n',dist,Pd,isIn);

% P0=[0,0];Pf=[100,100];Pc=100*randn(1,2);[dist,Pd,isIn] = distPtoLine(P0,Pf,Pc); 
% fprintf('dist: %.0f m       Pd: [%.0f,%.0f]          isIn: %.0f\n',dist,Pd,isIn);
% figure;plot([P0(1),Pf(1)],[P0(2),Pf(2)]);hold on;plot(Pc(1),Pc(2),'o');hold on;plot(Pd(1),Pd(2),'bo');grid on;axis equal

% P0=100*randn(1,2);Pf=100*randn(1,2);Pc=100*randn(1,2);[dist,Pd,isIn] = distPtoLine(P0,Pf,Pc); 
% fprintf('dist: %.0f m       Pd: [%.0f,%.0f]          isIn: %.0f\n',dist,Pd,isIn);
% figure;plot([P0(1),Pf(1)],[P0(2),Pf(2)]);hold on;plot(Pc(1),Pc(2),'o');hold on;plot(Pd(1),Pd(2),'bo');grid on;axis equal
x1 = L0(1);
y1 = L0(2);
x2 = Lf(1);
y2 = Lf(2);
xp = P(1);
yp = P(2);
if abs(x1-x2) > 1
    k = (y1-y2)/(x1-x2);
    b = y1 - k*x1;
    A = k;
    B = -1;
    C = b;
    dist = abs(A*xp+B*yp+C)/norm([A,B]);
    
    kk = -1/k;
    bb = yp - kk*xp;
    Pdx = -(b-bb)/(k-kk);
    Pdy = k*Pdx + b;
    Pd = [Pdx,Pdy];
%     Pd1 = [(B*B*xp-A*B*yp-A*C)/norm([A,B]),(A*A*yp-A*B*xp-B*C)/norm([A,B])];
%     test = 1;
else % 直线接近于平行经线
    dist = abs(xp-(x1+x2)/2);
    Pd = [(x1+x2)/2,yp];
end
isIn = true;
if (Pd(1) > L0(1) && Pd(1) > Lf(1)) || (Pd(1) < L0(1) && Pd(1) < Lf(1)) || ...
        (Pd(2) > L0(2) && Pd(2) > Lf(2)) || (Pd(2) < L0(2) && Pd(2) < Lf(2))
    isIn = false;
end