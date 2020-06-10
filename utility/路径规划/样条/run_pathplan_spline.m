clc
points = [1,0;
          3,0;
          3,1;
          1,1;
          1,0;];

pp = spline(pi*[0:0.5:2],points');
yy = ppval(pp, linspace(0,2*pi,101));
      

figure;
plot(points(:,1),points(:,2),'ro');hold on;
plot(yy(1,:),yy(2,:),'k*');hold on;
grid on;