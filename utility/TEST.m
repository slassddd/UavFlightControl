
dataFileName = 'SubFolder_飞行数据\仿真用的数据__pangzi_roll_1231';
temp = load(dataFileName,'IN_SENSOR','sensors');
dataFileName = 'SubFolder_飞行数据\仿真用的数据__pangzi_roll_1231_new';
temp_new = load(dataFileName,'IN_SENSOR','sensors');

sum(temp.IN_SENSOR.IMU1.accel_x - temp_new.IN_SENSOR.IMU1.accel_x)
sum(temp.IN_SENSOR.IMU1.accel_y + temp_new.IN_SENSOR.IMU1.accel_y)
sum(temp.IN_SENSOR.IMU1.accel_z + temp_new.IN_SENSOR.IMU1.accel_z)

sum(temp.IN_SENSOR.IMU1.gyro_x - temp_new.IN_SENSOR.IMU1.gyro_x)
sum(temp.IN_SENSOR.IMU1.gyro_y + temp_new.IN_SENSOR.IMU1.gyro_y)
sum(temp.IN_SENSOR.IMU1.gyro_z + temp_new.IN_SENSOR.IMU1.gyro_z)