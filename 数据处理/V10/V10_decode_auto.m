function V10Log = V10_decode_auto(logFile)
% example: V10Log = V10_decode_auto('log_105.bin-459717.mat')
% computer name: DESKTOP-QLU0EFU
% generate date: 02-Jan-2021
% Matlab version: 9.9.0.1467703 (R2020b)
% protocol file: V10ÿÿÿÿÿÿÿÿÿ_v20201231.txt
% data file: log_105.bin-459717.mat
% logFile: .mat log file
load(logFile);
%% ALD1
V10Log.AlgoParam1.TimeUS = ALD1(:,2); %||TimeUS|TimeUS|[U64]|[12:12]|
V10Log.AlgoParam1.CNT = ALD1(:,3); %||CNT|CNT|[U32]|[12:12]|
V10Log.AlgoParam1.time = ALD1(:,4); %||time|time|[U64]|[12:12]|
V10Log.AlgoParam1.mode = ALD1(:,5); %||mode|mode|[U8]|[12:12]|
V10Log.AlgoParam1.palne_mode = ALD1(:,6); %||pl_mode|palne_mode|[U8]|[12:12]|
V10Log.AlgoParam1.PathMode = ALD1(:,7); %||pamode|PathMode|[U8]|[12:12]|
V10Log.AlgoParam1.limit_pos_up = ALD1(:,8); %||posup|limit_pos_up|[U8]|[12:12]|
V10Log.AlgoParam1.throttle_upper = ALD1(:,9); %||th_upper|throttle_upper|[U8]|[12:12]|
V10Log.AlgoParam1.throttle_lower = ALD1(:,11); %||th_lowe|throttle_lower|[U8]|[12:12]|
%% ALD2
V10Log.ALD2.roll = ALD2(:,2); %||rol|roll|[F]|[12:12]|
V10Log.ALD2.pitch = ALD2(:,3); %||pit|pitch|[F]|[12:12]|
V10Log.ALD2.yaw = ALD2(:,4); %||yaw|yaw|[F]|[12:12]|
V10Log.ALD2.roll_in = ALD2(:,5); %||rin|roll_in|[F]|[12:12]|
V10Log.ALD2.pitch_in = ALD2(:,6); %||pin|pitch_in|[F]|[12:12]|
V10Log.ALD2.yaw_in = ALD2(:,7); %||yin|yaw_in|[F]|[12:12]|
V10Log.ALD2.throttle_in = ALD2(:,8); %||tin|throttle_in|[F]|[12:12]|
V10Log.ALD2.pwm_out(:,1) = ALD2(:,9); %||pw0|pwm_out[0]|[F]|[12:12]|
V10Log.ALD2.pwm_out(:,2) = ALD2(:,10); %||pw1|pwm_out[1]|[F]|[12:12]|
V10Log.ALD2.pwm_out(:,3) = ALD2(:,11); %||pw2|pwm_out[2]|[F]|[12:12]|
V10Log.ALD2.pwm_out(:,4) = ALD2(:,12); %||pw3|pwm_out[3]|[F]|[12:12]|
V10Log.ALD2.tail_tilt = ALD2(:,13); %||tail|tail_tilt|[F]|[12:12]|
V10Log.ALD2.pwm_tail = ALD2(:,14); %||pwmtail|pwm_tail|[F]|[12:12]|
V10Log.ALD2.Sum = ALD2(:,15); %||Sum|Sum|[F]|[12:12]|
%% ALD3
V10Log.ALD3.current_loc(:,1) = ALD3(:,2); %||cul0|current_loc[0]|[F]|[12:12]|
V10Log.ALD3.current_loc(:,2) = ALD3(:,3); %||cul1|current_loc[1]|[F]|[12:12]|
V10Log.ALD3.curr_vel(:,1) = ALD3(:,4); %|ALD3|cuv0|curr_vel[0]|[F]|[12:12]|
V10Log.ALD3.curr_vel(:,2) = ALD3(:,5); %||cuv1|curr_vel[1]|[F]|[12:12]|
V10Log.ALD3.curr_pos(:,1) = ALD3(:,6); %||cuv2|curr_pos[0]|[F]|[12:12]|
V10Log.ALD3.curr_pos(:,2) = ALD3(:,7); %||cup0|curr_pos[1]|[F]|[12:12]|
V10Log.ALD3.throttle_in = ALD3(:,8); %||cup1|throttle_in|[F]|[12:12]|
V10Log.ALD3.rate_target_ang_vel(:,1) = ALD3(:,9); %||ravl0|rate_target_ang_vel[0]|[F]|[12:12]|
V10Log.ALD3.rate_target_ang_vel(:,2) = ALD3(:,10); %||ravl1|rate_target_ang_vel[1]|[F]|[12:12]|
V10Log.ALD3.rate_target_ang_vel(:,3) = ALD3(:,11); %||ravl3|rate_target_ang_vel[2]|[F]|[12:12]|
V10Log.ALD3.Sum = ALD3(:,12); %||Sum|Sum|[F]|[12:12]|
