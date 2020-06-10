function  update_throttle_with_airspeed()
global TASmax
global SKE_dem
global TASmin
global SPE_dem
global SPE_est
global SKE_est
global STE_error
global SPEdot_dem
global SKEdot_dem
global STEdot_min
global STEdot_max
global SPEdot
global SKEdot
global STEdotErrLast
global timeConstant
global throttle_cruise
global rot_body_to_ned
global rollComp
global THRmaxf
global THRminf
global thrDamp
global throttle_dem
global throttle_slewrate
global last_throttle_dem
global dt
global integGain
global integTHR_state
 % calculate throttle demand - airspeed enabled case
 
 
    % Calculate limits to be applied to potential energy error to prevent over or underspeed occurring due to large height errors
      SPE_err_max = 0.5  * TASmax * TASmax - SKE_dem;
      SPE_err_min = 0.5  * TASmin * TASmin - SKE_dem;
    
    % Calculate total energy error
    STE_error = constrain_value((SPE_dem - SPE_est), SPE_err_min, SPE_err_max) + SKE_dem - SKE_est;
    STEdot_dem = constrain_value((SPEdot_dem + SKEdot_dem), STEdot_min, STEdot_max);
    STEdot_error = STEdot_dem - SPEdot - SKEdot;

    % Apply 0.5 second first order filter to STEdot_error
    % This is required to remove accelerometer noise from the  measurement
    STEdot_error = 0.2*STEdot_error + 0.8*STEdotErrLast;
    STEdotErrLast = STEdot_error;

    % Calculate throttle demand
    % If underspeed condition is set, then demand full throttle
     
        % Calculate gain scaler from specific energy error to throttle
        % (_STEdot_max - _STEdot_min) / (_THRmaxf - _THRminf) is the derivative of STEdot wrt throttle measured across the max allowed throttle range.
        K_STE2Thr = 1 / (timeConstant * (STEdot_max - STEdot_min) / (THRmaxf - THRminf));
        
        % Calculate feed-forward throttle
%         ff_throttle = 0;
        nomThr = throttle_cruise * 0.01;
%          Use the demanded rate of change of total energy as the feed-forward demand, but add
%         additional component which scales with (1/cos(bank angle) - 1) to compensate for induced
%         drag increase during turns.
        cosPhi = sqrt((rot_body_to_ned(1,2)*rot_body_to_ned(1,2)) + (rot_body_to_ned(2,2)*rot_body_to_ned(2,2)));
        STEdot_dem = STEdot_dem + rollComp * (1.0/constrain_value(cosPhi * cosPhi , 0.1, 1.0) - 1.0);
        ff_throttle = nomThr + STEdot_dem / (STEdot_max - STEdot_min) * (THRmaxf - THRminf);

        % Calculate PD + FF throttle
         throttle_damp = thrDamp;

        throttle_dem = (STE_error + STEdot_error * throttle_damp) * K_STE2Thr + ff_throttle;

        % Constrain throttle demand
        throttle_dem = constrain_value(throttle_dem, THRminf, THRmaxf);

         THRminf_clipped_to_zero = constrain_value(THRminf, 0, THRmaxf);

        % Rate limit PD + FF throttle
        % Calculate the throttle increment from the specified slew time
        if (throttle_slewrate ~= 0)  
             thrRateIncr = dt * (THRmaxf - THRminf_clipped_to_zero) * throttle_slewrate * 0.01;

            throttle_dem = constrain_value(throttle_dem,last_throttle_dem - thrRateIncr,last_throttle_dem + thrRateIncr);
            last_throttle_dem = throttle_dem;
        end

        % Calculate integrator state upper and lower limits
        % Set to a value that will allow 0.1 (10%) throttle saturation to allow for noise on the demand
        % Additionally constrain the integrator state amplitude so that the integrator comes off limits faster.
         maxAmp = 0.5*(THRmaxf - THRminf_clipped_to_zero);
         integ_max = constrain_value((THRmaxf - throttle_dem + 0.1),-maxAmp,maxAmp);
         integ_min = constrain_value((THRminf - throttle_dem - 0.1),-maxAmp,maxAmp);

        % Calculate integrator state, constraining state
        % Set integrator to a max throttle value during climbout
        integTHR_state = integTHR_state + (STE_error * integGain) * dt * K_STE2Thr;              
        integTHR_state = constrain_value(integTHR_state, integ_min, integ_max);
         

        % Sum the components.
        throttle_dem = throttle_dem + integTHR_state;
    % Constrain throttle demand
    throttle_dem = constrain_value(throttle_dem, THRminf, THRmaxf);
 
end

