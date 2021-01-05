SIM_SENSOR_SET.IMU1.Rbs = diag([1,1,1]); % Vb = Rbs * Vs
SIM_SENSOR_SET.IMU2.Rbs = SIM_SENSOR_SET.IMU1.Rbs;
SIM_SENSOR_SET.IMU3.Rbs = SIM_SENSOR_SET.IMU1.Rbs;

SIM_SENSOR_SET.Mag1.Rbs = ...
    [ 0 -1  0;
    -1  0  0;
    0  0 -1;];
SIM_SENSOR_SET.Mag2.Rbs = SIM_SENSOR_SET.Mag1.Rbs;
if PlaneMode.mode == ENUM_plane_mode.V10_1
    SIM_SENSOR_SET.Mag1.Rbs = eye(3);
    SIM_SENSOR_SET.Mag2.Rbs = SIM_SENSOR_SET.Mag1.Rbs;
end
