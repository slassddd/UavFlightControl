function  rate_out=get_rate_out_o( desired_rate,  scaler)
%  Function returns an equivalent elevator deflection in centi-degrees in the range from -4500 to 4500
%  A positive demand is up
%  Inputs are: 
%  1) desired roll rate in degrees/sec
%  2) control gain scaler = scaling_speed / aspeed
     rate_out=get_rate_out(desired_rate, scaler, 0);
 
end

