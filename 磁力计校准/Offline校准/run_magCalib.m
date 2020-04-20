% clear,clc
%% 载入数据
% 尽量均匀360°旋转，生成1分钟左右的数据
% dataFileName = 'magcalib_log_V8_1219.mat'; % 磁场单位Gs
% dataFileName = 'magcalib_log_DeadFat1219.mat'; % 磁场单位Gs
% dataFileName = 'magcalib_log_DeadFat1219new.mat'; % 磁场单位Gs
% dataFileName = 'magcalib_log_35.mat'; % 磁场单位Gs
% dataFileName = '磁力计标定数据_magcalib_V8_1920.mat'; % 磁场单位Gs
% dataFileName = '磁力计标定数据_碳结构机_1223';
% dataFileName = '磁力计标定数据_碳结构验证_56';
% dataFileName = '磁力计标定数据_pangzi_1227';
% dataFileName = '磁力计标定数据_pangzi_1230';
% dataFileName = '磁力计标定数据_log_9';
folderPaht = '20200317';
dataFileName = ['磁力计标定数据_log_1_magcalib'];
data = load([folderPaht,'\',dataFileName,'.mat']);
N = size(data.mag1B,1);
%
if 1
    try
        for i = 1:2
            x_flightcorrect{i} = eval(['data.mag',num2str(i),'B_correct;']);
            figure(1);
            subplot(1,2,i)
            scatter3(x_flightcorrect{i}(:,1),x_flightcorrect{i}(:,2),x_flightcorrect{i}(:,3),'b*');hold on;
            xlabel('x (Gs)')
            ylabel('y (Gs)')
            zlabel('z (Gs)')
            axis equal
        end
    end
end
for i = 1:2
    x{i} = eval(['data.mag',num2str(i),'B;']);
    %     x{i} = eval(['data.mag',num2str(i),'B_correct;']);
    x{i} = x{i}(1:round(N),:); %
    % 显示数据特性
    figure(1);
    subplot(1,2,i)
    scatter3(x{i}(:,1),x{i}(:,2),x{i}(:,3),'r');hold on;
    xlabel('x (Gs)')
    ylabel('y (Gs)')
    zlabel('z (Gs)')
    axis equal
    %% 获得当地标准地磁向量
    lla0 = mean(data.lla);
    [magXYZ, magHorizontalintensity, magDeclination, magInclination, totalIntensity] = ...
        wrldmagm(abs(lla0(3)), lla0(1), lla0(2), decyear(2015,7,4),'2015');
%     magXYZ = magXYZ/1e3; % nT变换为uT
    magXYZ = magXYZ/1e5; % nT变换为Gs
    %% 标定
    % 通过标定，得到标定参数A、b、magNorm
    [A{i},b{i},magNorm,x_correct0] = magCalib_offline(x{i});
    k{i} = norm(magXYZ)/magNorm;
%     x_correct = k{i}*(x{i}-b{i})*A{i}; % 矫正公式
    x_correct{i} = zeros(size(x{i}));
    idxsel = 4145;
    xtest = round(x{i}(idxsel,:),4);
    Atest = [1.010 -0.025 -0.041;-0.025 1.010 0.011;-0.041 0.011 0.983];
    btest = [0.096,-0.014,0];
    ktest = 2.502;
    xtest_out = magCorrectEqu(xtest,Atest,btest,ktest);
    xtest_correct = magCorrectEqu(xtest,A{i},b{i},k{i});
%     x_flightcorrect{i}(idxsel,:)
    for j = 1:length(x{i})
        x_correct{i}(j,:) = magCorrectEqu(x{i}(j,:),A{i},b{i},k{i});
    end
    figure(1);
    subplot(1,2,i)
    scatter3(x_correct{i}(:,1),x_correct{i}(:,2),x_correct{i}(:,3),'k');hold on;
    axis equal
%     legend('原始数r据','地面校正')
    legend('固件矫正','原始数据','地面校正')
    %% 生成矫正文件
    [~,tempName] = fileparts(dataFileName);
    fileID = fopen(['res_',tempName,'_mag',num2str(i),'.txt'],'w');
    fprintf(fileID,'矫正公式: x_correct = k*(x-b)*A\n');
    fprintf(fileID,'a11: %.3f\n',A{i}(1,1));
    fprintf(fileID,'a12: %.3f\n',A{i}(1,2));
    fprintf(fileID,'a13: %.3f\n',A{i}(1,3));
    fprintf(fileID,'a22: %.3f\n',A{i}(2,2));
    fprintf(fileID,'a23: %.3f\n',A{i}(2,3));
    fprintf(fileID,'a33: %.3f\n',A{i}(3,3));
    fprintf(fileID,'b11: %.3f\n',b{i}(1));
    fprintf(fileID,'b21: %.3f\n',b{i}(2));
    fprintf(fileID,'b31: %.3f\n',b{i}(3));
    fprintf(fileID,'k: %.3f\n',k{i});
    fclose(fileID);   
end
save(['CalibParam_',dataFileName],'A','b','k');
% 
% 
% figure
% plot3(40,0,0,'r+');hold on;
% plot3(0,40,0,'g+');hold on;
% plot3(0,0,40,'b+');hold on;
% plot3(-40,0,0,'ro');hold on;
% plot3(0,-40,0,'go');hold on;
% plot3(0,0,-40,'bo');hold on;
% grid on;
% axis equal
% xlabel('x')
% ylabel('y')
% zlabel('z')
% for i =1:100:size(x{1},1)
%     plot3(x{1}(i,1),x{1}(i,2),x{1}(i,3),'o');hold on;
%     drawnow
% end