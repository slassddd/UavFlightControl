function    V=sqrt_controller_pos(  error,   p,   second_ord_lim)
 
    if (second_ord_lim < 0.0 || second_ord_lim==0 || p==0)  
          V=[error(1) * p, error(2) * p, error(3)];
          return
    end
     
      linear_dist = second_ord_lim /p/p;
      error_length = norm([error(1), error(2)],2);
    if (error_length > linear_dist)  
          first_order_scale = sqrt(2.0 * second_ord_lim * (error_length - (linear_dist * 0.5))) / error_length;
          V=[error(1) * first_order_scale, error(2) * first_order_scale, error(3)];
        
    else  
          V=[error(1) * p, error(2) * p, error(3)];
    end
     
end

