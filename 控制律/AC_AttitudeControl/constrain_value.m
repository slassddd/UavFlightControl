function amto = constrain_value( amt, low, high)
 
    amto=amt;
    if (amt < low) 
        amto=low;
    end
    if (amt > high) 
        amto=high;
    end
end

