function qo=normalizeq(q)

    quatMag = norm(q,2);
    if (quatMag~=0) 
        qo = q/quatMag;
    else
        qo=q;       
    end   
end

