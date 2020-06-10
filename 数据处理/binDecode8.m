function d=binDecode8(a,h,b,c)
    if(b==0)
        d=a(:,h);
    else
        e=a(:,h)>127;
        f=ones(length(e),1)-e;
        g=a(:,h);
        d=(e.*(g-256)+f.*(g))/128*c;
    end
end