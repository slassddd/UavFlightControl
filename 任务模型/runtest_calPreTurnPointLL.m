clear curLL
LL0 = [40.120,116.5];
LL1 = [40.120,116.505];
R = 50;
curLL(1,:) = [40.115,116.503];
curLL(2,:) = LL0;
curLL(3,:) = LL1;
curLL = [curLL;LL0 + 0.01*randn(20,2)];
for i = 1:size(curLL,1)
    calPreTurnPointLL(LL0,LL1,curLL(i,:),50)
    cla
end