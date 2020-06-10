% 计算圆切点
function [t1,t2] = findTangencyPoints(Cx,Cy,Px,Py,R)
nP = 72;
x = zeros(1,nP);
y = zeros(1,nP);
resdual = ones(1,nP);
dist = ones(1,nP);
for i = 1:nP
    angle = 2*pi/nP*(i-1);
    x(i) = Cx + R*cos(angle);
    y(i) = Cy + R*sin(angle);
    xy = [x(i),y(i)];
    v1 = xy-[Px,Py];
    v2 = xy-[Cx,Cy];
    v1n = norm(v1);
    v2n = norm(v2);
    if v1n~=0
        v1 = v1/v1n;
    else
        v1 = [0,0];
    end
    if v2n~=0
        v2 = v2/v2n;
    else
        v2 = [0,0];
    end
    resdual(i) = abs(dot(v1,v2));
    dist(i) = v1n;
end
[~,idx] = sort(resdual);
idxSel = idx(1:2);
tmp = 1;
t1 = [x(idxSel(tmp)),y(idxSel(tmp))];
tmp = 2;
t2 = [x(idxSel(tmp)),y(idxSel(tmp))];