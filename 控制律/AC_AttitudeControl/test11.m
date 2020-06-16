% a=rand(3,3)
q_matlab=quaternion(a','rotmat','frame')
q_px4=from_rotation_matrix(a')
%  quat2eul(q_matlab)
 euler_matlab=euler(q_matlab,'ZYX','frame')
  [roll pitch yaw]=q_to_euler(q_px4);
  [roll pitch yaw]
% % quat2eul(q_matlab)
% eul2quat([ pitch yaw roll],'frame')