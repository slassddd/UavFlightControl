function [val_mean,val_std,isBufFull] = smoothstd(curdata)
% data = IN_SENSOR.IMU1_0.accel_z;
% val_mean = zeros(size(data));
% val_std = zeros(size(data));
% for i = 1:length(data)
%     if rem(i,100) == 0
%         fprintf('step %d/%d\n',i,length(data));
%     end
%     [val_mean(i),val_std(i)] = smoothstd(data(i));
% end
% figure;
% subplot(221)
% plot(data);hold on;
% plot(val_std);hold on;
% subplot(223)
% plot(val_mean);
% subplot(224)
% plot(val_std);
persistent buf predata
nanflag = -99999;
if isempty(buf)
    buf = nanflag*ones(100,1); 
    predata = curdata;
end
if predata ~= curdata
    updateflag = true;
else
    updateflag =false;
end
% 更新标志
if updateflag
    buf(1:end-1) = buf(2:end);
    buf(end) = curdata;
end
% buffer满
if buf(1) ~= nanflag
    isBufFull = true;
else
    isBufFull = false;
end
if isBufFull
    val_mean = mean(buf);
    val_std = mean(abs(buf - mean(buf)));
else
    val_mean = 0;
    val_std = 0;
end
predata = curdata;