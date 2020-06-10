SmoothFcn.time = 0:0.001:20;
SmoothFcn.u_sine = 1*sin(10*SmoothFcn.time);
SmoothFcn.u_noise = 0.1*randn(size(SmoothFcn.time));
SmoothFcn.u = SmoothFcn.u_sine + SmoothFcn.u_noise;
SmoothFcn.y_mean = movmean(SmoothFcn.u,12);
for i = 1:length(SmoothFcn.time)
    SmoothFcn.y_sl(i) = SimLib_IMU1movmean(SmoothFcn.u(i),SmoothFcn.u(i),...
        SmoothFcn.u(i),SmoothFcn.u(i),SmoothFcn.u(i),SmoothFcn.u(i));
end
figure;
subplot(121)
plot(SmoothFcn.time,SmoothFcn.u,'r--');hold on;
plot(SmoothFcn.time,SmoothFcn.u_sine,'k--');hold on;
plot(SmoothFcn.time,SmoothFcn.y_mean,'b');hold on;
plot(SmoothFcn.time,SmoothFcn.y_sl,'g');hold on;
grid on;
xlabel('time (s)')
ylabel('signal')
legend('‘Î…˘–≈∫≈','‘≠–≈∫≈','movmean12','slmean')
subplot(122)
[pxx_mean,f] = pwelch(SmoothFcn.time,SmoothFcn.y_mean);
pxx_sl = pwelch(SmoothFcn.time,SmoothFcn.y_sl);
plot(f,pow2db(pxx_sl))
hold on
plot(f,pow2db(pxx_mean))
hold off
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
legend('pwelch','maxhold','minhold')