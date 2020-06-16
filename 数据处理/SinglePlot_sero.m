figure;
plot(Engine.servo_out2);hold on;
plot(Engine.servo_out3);hold on;
plot(Engine.servo_out1);hold on;
plot(Engine.servo_out0);hold on;

plot(lowpass(Engine.servo_out2,10,100));hold on;
plot(Engine.servo_out3);hold on;
plot(Engine.servo_out1);hold on;
plot(Engine.servo_out0);hold on;