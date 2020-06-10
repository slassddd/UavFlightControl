function dist = distOfTwoLL(LL1_in,LL2_in)
% 计算两个纬度经度位置的距离[m]
LL1 = reshape(LL1_in,[1,2]);
LL2 = reshape(LL2_in,[1,2]);
relpos = lla2ned([LL1,0],LL2);
dist = norm(relpos);