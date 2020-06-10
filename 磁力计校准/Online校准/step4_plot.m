% 原始数据
figure(12);
subplot(121)
scatter3(x1(:,1),x1(:,2),x1(:,3));hold on;
subplot(122)
scatter3(x2(:,1),x2(:,2),x2(:,3));hold on;
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
% 本机离线标定数据
subplot(121)
scatter3(res1_xCorrect(:,1),res1_xCorrect(:,2),res1_xCorrect(:,3),'r*');hold on;
subplot(122)
scatter3(res2_xCorrect(:,1),res2_xCorrect(:,2),res2_xCorrect(:,3),'r*');hold on;
% 在线标定值
figure(12);
subplot(121)
scatter3(data.mag1B_correct(:,1),data.mag1B_correct(:,2),data.mag1B_correct(:,3),'k*');hold on;
ylabel('mag1')
subplot(122)
scatter3(data.mag2B_correct(:,1),data.mag2B_correct(:,2),data.mag2B_correct(:,3),'k*');hold on;
ylabel('mag2')
% legend
figure(12);
subplot(121)
legend('原始数据','离线标定值','在线标定值')
subplot(122)
legend('原始数据','离线标定值','在线标定值')