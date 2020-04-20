function dist = distOfTwoLL(LL1,LL2)
relpos = lla2ned([LL1,0],LL2);
dist = norm(relpos);