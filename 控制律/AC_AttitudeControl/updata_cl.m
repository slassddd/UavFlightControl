function updata_cl()
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global rot_body_to_ned
global roll pitch yaw
global accel_x accel_y accel_z
global GRAVITY_MSS
global z_accel_meas
 qtemp=from_euler([roll pitch yaw]);
 rot_body_to_ned=rotation_matrix(qtemp);
 accel_ef=rot_body_to_ned*[accel_x accel_y accel_z]';
z_accel_meas= -(accel_ef(3)+GRAVITY_MSS)*100;
 
end

