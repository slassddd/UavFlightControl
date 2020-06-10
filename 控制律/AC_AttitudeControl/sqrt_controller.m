function correction_rate = sqrt_controller( error,  p,  second_ord_lim, dt)
    if(second_ord_lim<=0) 
       %second order limit is zero or negative.       
                correction_rate = error * p;  
    elseif (p==0)      
                % P term is zero but we have a second order limit.
            if (error>0) 
                correction_rate = sqrt(2.0 * second_ord_lim * (error));
            elseif (error<0)
                correction_rate = -sqrt(2.0 * second_ord_lim * (-error));
            else 
                correction_rate = 0.0;
            end           
    else
        % Both the P and second order limit have been defined.
         linear_dist = second_ord_lim / p/p;
        if (error > linear_dist) 
            correction_rate = sqrt(2.0 * second_ord_lim * (error - (linear_dist / 2.0)));
        elseif (error < -linear_dist) 
            correction_rate = -sqrt(2.0 * second_ord_lim * (-error - (linear_dist / 2.0)));
        else 
            correction_rate = error * p;
        end
        
    end
    correction_rate=constrain_value(correction_rate,-abs(error)/dt,abs(error)/dt);
end

