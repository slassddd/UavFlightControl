Lux=310/1000;
Luy=210/1000;
Ldx=205/1000;
Ldy=355.5/1000;
mg=49;
Lu=hypot(Lux,Luy);
Ld=hypot(Ldx,Ldy);
QLuy=6;
QLux=atand(tand(QLuy)*Luy/Lux);
tan_QLu=hypot(tand(QLux),tand(QLuy));
QLu=atand(tan_QLu);
tan_QLd=Ldy*tan_QLu*Lu/Luy/Ld;
tand_QLdx=tan_QLd*Ldy/Ld;
tand_QLdy=tan_QLd*Ldx/Ld;
QLdx=atand(tand_QLdx);
QLdy=atand(tand_QLdy);
QLd=atand(tan_QLd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fu=Ldy/(Ldy+Luy);
Fd=1-Fu;
Fu2=Fu/2*mg;
Fd2=Fd/2*mg;
Mu2=Fu2*tand(QLu)*Lu;
Md2=Fd2*tand(QLd)*Ld;
Mz=(Mu2+Md2)*2*0.8;

% QLdy=atand(tand(QLuy)*Ldy/Luy)
% QLdx=atand(tand(QLdy)*Ldy/Ldx)

% Q=20
% 4.6*tand(Q)*9
% hypot(4.6*tand(Q)*9,9)
% 4.6*tand(Q)*9*Ldx
% atand(4.6*tand(Q))
