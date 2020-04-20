%mode_Multicopter
m=5;
g=9.8;
Jx=186222*1e-6;
Jy=164400*1e-6;
Jz=336920*1e-6;
% Jx=186222*1e-5;
% Jy=164400*1e-5;
% Jz=336920*1e-5;
J=diag([Jx Jy Jz]);

Lux=310/1000;
Luy=210/1000;
Ldx=205/1000;
Ldy=355.5/1000;
Lu=hypot(Lux,Luy);
Ld=hypot(Ldx,Ldy);
Ku=32;
% Kd=18;
Kd=Ku*Luy/Ldy;
Kx=(Ku-Kd)/(Ku+Kd);
Qd=10;
Qu=asind(Kd*sind(Qd)*Ld/(Ku*Lu));
Kc=(Ku*Lux)/(Ldx*Kd);


% Qd
