function d=binDecode(a,h,b,c)
    if(b==0)
        d=a(:,h)+a(:,h+1)*256;
    else
        e=a(:,h+1)>127;
        f=ones(length(e),1)-e;
        g=a(:,h)+a(:,h+1)*256;
        d=(e.*(g-65536)+f.*(g))/32768*c;
    end
end