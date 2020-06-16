function  update_throttle_filter()
global armed
global throttle_in
global throttle_cutoff_frequency
global throttle_filter
global dt
    if (armed)  
        if(throttle_cutoff_frequency<=0)
        throttle_filter=throttle_in;
        end
        rc=1/(2*pi*throttle_cutoff_frequency);
        alpha = constrain_value(dt/(dt+rc), 0.0, 1.0);
        throttle_filter= throttle_filter+(throttle_in - throttle_filter) * alpha;
        if(throttle_filter<0)
            throttle_filter=0;
        end
        if(throttle_filter>1)
        throttle_filter=1;
        end  
    else
        throttle_filter=0;
    end

