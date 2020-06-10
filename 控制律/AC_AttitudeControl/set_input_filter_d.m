function set_input_filter_d(  input,reset_filter)
 

    % reset input filter to value received
    if (reset_filter==1)  
        reset_filter = 0;
        input = input;
        derivative = 0.0;
    end

    % update filter and calculate derivative

        derivative = (input - _input) / _dt;
        derivative = _derivative + get_filt_alpha() * (derivative-_derivative);
 

    _input = input;
 
end

