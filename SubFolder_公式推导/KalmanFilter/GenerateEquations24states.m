% IMPORTANT - This script requires the Matlab symbolic toolbox and takes ~3 hours to run

% Derivation of Navigation EKF using a local NED earth Tangent Frame and 
% XYZ body fixed frame
% Sequential fusion of velocity and position measurements
% Fusion of true airspeed
% Sequential fusion of magnetic flux measurements
% 24 state architecture.
% IMU data is assumed to arrive at a constant rate with a time step of dt
% IMU delta angle and velocity data are used as time varying parameters,
% not observations

% Author:  Paul Riseborough
% Last Modified: 3 Dec 2013

% State vector:
% quaternions (q0, q1, q2, q3)
% Velocity - m/sec (North, East, Down)
% Position - m (North, East, Down)
% Delta Angle bias - rad (X,Y,Z)
% Delta Velocity Bias - m/sec (X,Y,Z)
% Wind Vector  - m/sec (North,East)
% Earth Magnetic Field Vector - milligauss (North, East, Down)
% Body Magnetic Field Vector - milligauss (X,Y,Z)

% Observations:
% NED velocity - m/s
% NED position - m
% True airspeed - m/s
% XYZ magnetic flux - milligauss

% Time varying parameters:
% XYZ delta angle measurements in body axes - rad
% XYZ delta velocity measurements in body axes - m/sec


clear all;

%% define symbolic variables and constants
syms dax day daz real % IMU delta angle measurements in body axes - rad
syms dvx dvy dvz real % IMU delta velocity measurements in body axes - m/sec
syms q0 q1 q2 q3 real % quaternions defining attitude of body axes relative to local NED
syms vn ve vd real % NED velocity - m/sec
syms pn pe pd real % NED position - m
syms dax_b day_b daz_b real % delta angle bias - rad
syms dvx_b dvy_b dvz_b real % delta velocity bias - m/sec
syms dt real % IMU time step - sec
syms gnavx gnavy gnavz real % NED gravity vector - m/sec^2
% syms gn ge gd real % NED gravity vector - m/sec^2
syms omn ome omd real; % Earth rotation vector in local NED axes rad/sec - rad/sec
syms daxCov dayCov dazCov dvxCov dvyCov dvzCov real; % IMU delta angle and delta velocity measurement variances
syms vwn vwe real; % NE wind velocity - m/sec
syms magX magY magZ real; % XYZ body fixed magnetic field measurements - milligauss
syms magNavX magNavY magNavZ real; % NED earth fixed magnetic field components - milligauss
% syms magN magE magD real; % NED earth fixed magnetic field components - milligauss
syms R_VN R_VE R_VD real % variances for NED velocity measurements - (m/sec)^2
syms R_PN R_PE R_PD real % variances for NED position measurements - m^2
syms R_TAS real  % variance for true airspeed measurement - (m/sec)^2
syms R_MAG real  % variance for magnetic flux measurements - milligauss^2

%% define the process equations

% Define the state vector & number of states
stateVector = [q0;q1;q2;q3;pn;pe;pd;vn;ve;vd;dax_b;day_b;daz_b;dvx_b;dvy_b;dvz_b;magNavX;magNavY;magNavZ;magX;magY;magZ;vwn;vwe;];
nStates=numel(stateVector);

% define the measured Delta angle and delta velocity vectors
da = [dax; day; daz];
dv = [dvx; dvy; dvz];

% define the delta angle and delta velocity bias errors
da_b = [dax_b; day_b; daz_b];
dv_b = [dvx_b; dvy_b; dvz_b];

% derive the body to nav direction cosine matrix
Tbn = Quat2Tbn([q0,q1,q2,q3]);


% define the bias corrected delta angle
% Ignore coning compensation and earths rotation as these effect are
% negligible in terms of covariance growth compared to other efects for our
% grade of sensor
% deltaAngle = da - da_b + 1/12*cross(da_prev,da) - transpose(Cbn)*([omn; ome; omd])*dt;
deltaAngle = da - da_b;

% define the bias corrected delta velocity
% Ignore sculling as this effect is negligible in terms of covariance growth 
% compared to other effects for our grade of sensor
% deltaVelocity = dv - dv_b + 0.5*cross(da,dv) + 1/12*(cross(da_prev,dv) + cross(dv_prev,da));
deltaVelocity = dv - dv_b;

% define the quaternion rotation vector
quat = [q0;q1;q2;q3];

% define the attitude update equations
% use a first order expansion of rotation to calculate the quaternion increment
% acceptable for propagation of covariances
delQuat = [1;
    0.5*deltaAngle(1);
    0.5*deltaAngle(2);
    0.5*deltaAngle(3);
    ];
qNew = QuatMult(quat,delQuat);

% define the velocity update equations
vNew = [vn;ve;vd] + [gnavx;gnavy;gnavz]*dt + Tbn*deltaVelocity;% - cross(2*[omn; ome; omd],[vn;ve;vd])*dt;

% define the position update equations
pNew = [pn;pe;pd] + [vn;ve;vd]*dt;

% define the IMU bias error update equations
dabNew = [dax_b; day_b; daz_b];
dvbNew = [dvx_b; dvy_b; dvz_b];

% define the wind velocity update equations
vwnNew = vwn;
vweNew = vwe;

% define the earth magnetic field update equations
magNnew = magNavX;
magEnew = magNavY;
magDnew = magNavZ;

% define the body magnetic field update equations
magXnew = magX;
magYnew = magY;
magZnew = magZ;

% Define the process equations output vector
processEqns = [qNew;pNew;vNew;dabNew;dvbNew;magNnew;magEnew;magDnew;magXnew;magYnew;magZnew;vwnNew;vweNew;];
% processEqns = [qNew;vNew;pNew;dabNew;dvbNew;vwnNew;vweNew;magNnew;magEnew;magDnew;magXnew;magYnew;magZnew];

%% derive the state transition matrix

% derive the state transition matrix
F = jacobian(processEqns, stateVector);
try
    [F,SF]=OptimiseAlgebra(F,'SF');
catch
    disp('SF error')
end
%% derive the covariance prediction equation
% This reduces the number of floating point operations by a factor of 6 or
% more compared to using the standard matrix operations in code

% Define the control (disturbance) vector. Error growth in the inertial
% solution is assumed to be driven by 'noise' in the delta angles and
% velocities, after bias effects have been removed. This is OK becasue we
% have sensor bias accounted for in the state equations.
distVector = [da;dv];

% derive the control(disturbance) influence matrix
G = jacobian(processEqns, distVector);
try
    [G,SG]=OptimiseAlgebra(G,'SG');
catch
    disp('SG error')
end
% derive the state error matrix
% Note - this derivation of the covariance update equations does not include
% any general state noise - this will be added at the implementation stage
% by adding an approriately scaled diagonal process noise matrix to the 
% covariance matrix
imuNoise = diag([daxCov dayCov dazCov dvxCov dvyCov dvzCov]);
Q = G*imuNoise*transpose(G);
try
    [Q,SQ]=OptimiseAlgebra(Q,'SQ');
catch
    disp('SQ error')
end
% define a symbolic covariance matrix using strings to represent 
% '_lp_' to represent '( '
% '_c_' to represent ,
% '_rp_' to represent ')' 
% these can be substituted later to create executable code
for rowIndex = 1:nStates
    for colIndex = 1:nStates
        eval(['syms OP_lp_',num2str(rowIndex),'_c_',num2str(colIndex), '_rp_ real']);
        eval(['P(',num2str(rowIndex),',',num2str(colIndex), ') = OP_lp_',num2str(rowIndex),'_c_',num2str(colIndex),'_rp_;']);
    end
end

% Derive the predicted covariance matrix using the standard equation
PP = F*P*transpose(F) + Q;

% Collect common expressions to optimise processing
try
    [PP,SPP]=OptimiseAlgebra(PP,'SPP');
catch
    disp('SPP error')
end
%% derive equations for sequential fusion of velocity and position measurements
H_VN= jacobian(vn,stateVector); % measurement Jacobian
K_VN = (P*transpose(H_VN))/(H_VN*P*transpose(H_VN) + R_VN);

H_VE= jacobian(ve,stateVector); % measurement Jacobian
K_VE = (P*transpose(H_VE))/(H_VE*P*transpose(H_VE) + R_VE);

H_VD= jacobian(vd,stateVector); % measurement Jacobian
K_VD = (P*transpose(H_VD))/(H_VD*P*transpose(H_VD) + R_VD);

H_PN= jacobian(pn,stateVector); % measurement Jacobian
K_PN = (P*transpose(H_PN))/(H_PN*P*transpose(H_PN) + R_PN);

H_PE= jacobian(pe,stateVector); % measurement Jacobian
K_PE = (P*transpose(H_PE))/(H_PE*P*transpose(H_PE) + R_PE);

H_PD= jacobian(pd,stateVector); % measurement Jacobian
K_PD = (P*transpose(H_PD))/(H_PD*P*transpose(H_PD) + R_PD);

% combine into a single H and K matrix (note these matrices cannot be used
% for a single step fusion, so each row|column mst be used in a separate
% fusion step
H_VP  = [H_VN;H_VE;H_VD;H_PN;H_PE;H_PD];
clear    H_VN H_VE H_VD H_PN H_PE H_PD
K_VP = [K_VN,K_VE,K_VD,K_PN,K_PE,K_PD];
clear   K_VN K_VE K_VD K_PN K_PE K_PD
try
    [K_VP,SK_VP]=OptimiseAlgebra(K_VP,'SK_VP');
catch
    disp('SK_VP error')
end
%% derive equations for fusion of true airspeed measurements
Tbn = [[ q0^2 + q1^2 - q2^2 - q3^2,         2*q1*q2 - 2*q0*q3,         2*q0*q2 + 2*q1*q3]
    [         2*q0*q3 + 2*q1*q2, q0^2 - q1^2 + q2^2 - q3^2,         2*q2*q3 - 2*q0*q1]
    [         2*q1*q3 - 2*q0*q2,         2*q0*q1 + 2*q2*q3, q0^2 - q1^2 - q2^2 + q3^2]];
% 三轴速度
vned = [vn;ve;vd];
vNav_b = transpose(Tbn)*vned;
vNav_b_x = vNav_b(1);
vw_b = Tbn'*[vwn;vwe;0];
vw_b_x = vw_b(1);
VtasPred = abs(vNav_b_x - vw_b_x);
VtasPred1 = (vNav_b_x - vw_b_x);
% 水平速度
vned_horizon = [vn;ve;0];
vNav_b = transpose(Tbn)*vned_horizon;
vNav_b_x = vNav_b(1);
vw_b = Tbn'*[vwn;vwe;0];
vw_b_x = vw_b(1);
VtasPred_horizon = (vNav_b_x - vw_b_x);
% vNav_b = transpose(Tbn)*[vn;ve;vd];
% VtasPred = sqrt((vNav_b(1)-vwn)^2 + (vNav_b(2)-vwe)^2 + vNav_b(3)^2); % predicted measurement
% VtasPred = sqrt((vn-vwn)^2 + (ve-vwe)^2 + vd^2); % predicted measurement
H_TAS = jacobian(VtasPred,stateVector); % measurement Jacobian
H_TAS1 = jacobian(VtasPred1,stateVector); % measurement Jacobian
H_TAS_horizon = jacobian(VtasPred_horizon,stateVector); % measurement Jacobian
try
    [H_TAS,SH_TAS]=OptimiseAlgebra(H_TAS,'SH_TAS'); % optimise processing
catch
    disp('SH_TAS error')
end
K_TAS = (P*transpose(H_TAS))/(H_TAS*P*transpose(H_TAS) + R_TAS);
try
    [K_TAS,SK_TAS]=OptimiseAlgebra(K_TAS,'SK_TAS'); % Kalman gain vector
catch
    disp('SH_MAG error')
end
%% derive equations for fusion of magnetic field measurement
magMeas = transpose(Tbn)*[magNavX;magNavY;magNavZ] + [magX;magY;magZ]; % predicted measurement
H_MAG = jacobian(magMeas,stateVector); % measurement Jacobian
try
    [H_MAG,SH_MAG]=OptimiseAlgebra(H_MAG,'SH_MAG');
catch
    disp('SH_MAG error')
end
K_MX = (P*transpose(H_MAG(1,:)))/(H_MAG(1,:)*P*transpose(H_MAG(1,:)) + R_MAG); % Kalman gain vector
try
    [H_MAG,SH_MAG]=OptimiseAlgebra(H_MAG,'SH_MAG');
catch
    disp('SK_MX error')
end
K_MY = (P*transpose(H_MAG(2,:)))/(H_MAG(2,:)*P*transpose(H_MAG(2,:)) + R_MAG); % Kalman gain vector
try
    [K_MY,SK_MY]=OptimiseAlgebra(K_MY,'SK_MY');
catch
    disp('SK_MY error')
end
K_MZ = (P*transpose(H_MAG(3,:)))/(H_MAG(3,:)*P*transpose(H_MAG(3,:)) + R_MAG); % Kalman gain vector
try
    [K_MZ,SK_MZ]=OptimiseAlgebra(K_MZ,'SK_MZ');
catch
    disp('SK_MZ error')
end
%% Save output and convert to m and c code fragments
nStates = length(PP);
fileName = strcat('SymbolicOutput',int2str(nStates),'.mat');
save(fileName);
SaveScriptCode(nStates);
ConvertToM(nStates);
ConvertToC(nStates);