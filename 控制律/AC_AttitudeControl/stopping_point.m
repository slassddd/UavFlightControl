function  output=stopping_point(  first_ord_mag,   p,   second_ord_lim)

% Inverse proportional controller with piecewise sqrt sections to constrain second derivative
     if ((second_ord_lim>0) && (p==0))  
        output= (first_ord_mag * first_ord_mag) / (2.0 * second_ord_lim);
        return
     elseif ((second_ord_lim<=0) && ~p)  
        output= first_ord_mag / p;
        return
     elseif( (second_ord_lim<=0) && p==0)  
        output=0;
        return
     end
     
    % calculate the velocity at which we switch from calculating the stopping point using a linear function to a sqrt function
      linear_velocity = second_ord_lim / p;

    if (abs(first_ord_mag) < linear_velocity)  
        % if our current velocity is below the cross-over point we use a linear function
        output= first_ord_mag / p;
    else  
          linear_dist = second_ord_lim / p/p;
          overshoot = (linear_dist * 0.5) + (first_ord_mag)^2 / (2.0* second_ord_lim);
        if ((first_ord_mag>0))  
            output= overshoot;
          else  
            output= -overshoot;   
        end
    end
end

