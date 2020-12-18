clc

% aero_data = datcomimport('cessna_not_wing_only.dat');
% data2 = datcomimport('cessna.dat');
% data3 = datcomimport('cessna_wing_only.dat');
% data4 = datcomimport('for006.dat');

load asbSkyHoggData.mat
DATCOM_DYN.Ts = 0.012;

DATCOM_DYN.mass = 1e3;
DATCOM_DYN.inertia = diag([1e3,1e3,1e3]);
DATCOM_DYN.LatLong0 = [39,119]; % [deg]
DATCOM_DYN.heading0 = 0; % [deg]
DATCOM_DYN.Sref = statdyn{1}.sref; % m^2
DATCOM_DYN.bref = statdyn{1}.blref;
DATCOM_DYN.cbar = statdyn{1}.cbar;

DATCOM_DYN.wn_act = 100;
DATCOM_DYN.z_act = 0.7;
DATCOM_DYN.maxdef_aileron = 30;
DATCOM_DYN.mindef_aileron = -30;
DATCOM_DYN.maxdef_elevator = 30;
DATCOM_DYN.mindef_elevator = -30;
DATCOM_DYN.maxdef_rudder = 30;
DATCOM_DYN.mindef_rudder = -30;
DATCOM_DYN.Thrust = 2513;