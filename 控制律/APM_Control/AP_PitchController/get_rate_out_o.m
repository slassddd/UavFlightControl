function  get_rate_out_o(  desired_rate,   scaler)
%  Function returns an equivalent elevator deflection in centi-degrees in the range from -4500 to 4500
%  A positive demand is up
%  Inputs are: 
%  1) demanded pitch rate in degrees/second
%  2) control gain scaler = scaling_speed / aspeed
%  3) boolean which is true when stabilise mode is active
%  4) minimum FBW airspeed (metres/sec)
%  5) maximum FBW airspeed (metres/sec)
global aspeed
      get_rate_out(desired_rate, scaler, 0, aspeed);
 
end

