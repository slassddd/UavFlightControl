function  update_energies( )
 
global SPE_dem
global hgt_dem_adj
global GRAVITY_MSS
global TAS_dem_adj
global hgt_rate_dem
global TAS_state
global TAS_rate_dem
global height
global SKE_dem
global SPEdot_dem
global SKEdot_dem
global SPE_est
global SKE_est
global SPEdot
global SKEdot
global climb_rate
global vel_dot
    % Calculate specific energy demands
    SPE_dem = hgt_dem_adj * GRAVITY_MSS;
    SKE_dem = 0.5 * TAS_dem_adj * TAS_dem_adj;

    % Calculate specific energy rate demands
    SPEdot_dem = hgt_rate_dem * GRAVITY_MSS;
    SKEdot_dem = TAS_state * TAS_rate_dem;

    % Calculate specific energy
    SPE_est = height * GRAVITY_MSS;
    SKE_est = 0.5 * TAS_state * TAS_state;

    % Calculate specific energy rate
    SPEdot = climb_rate * GRAVITY_MSS;
    SKEdot = TAS_state * vel_dot;

end

