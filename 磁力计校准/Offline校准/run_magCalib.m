% clear,clc
%% ��������
% ��������360����ת������1�������ҵ�����
% dataFileName = 'magcalib_log_V8_1219.mat'; % �ų���λGs
% dataFileName = 'magcalib_log_DeadFat1219.mat'; % �ų���λGs
% dataFileName = 'magcalib_log_DeadFat1219new.mat'; % �ų���λGs
% dataFileName = 'magcalib_log_35.mat'; % �ų���λGs
% dataFileName = '�����Ʊ궨����_magcalib_V8_1920.mat'; % �ų���λGs
% dataFileName = '�����Ʊ궨����_̼�ṹ��_1223';
% dataFileName = '�����Ʊ궨����_̼�ṹ��֤_56';
% dataFileName = '�����Ʊ궨����_pangzi_1227';
% dataFileName = '�����Ʊ궨����_pangzi_1230';
% dataFileName = '�����Ʊ궨����_log_9';
folderPaht = '20200317';
dataFileName = ['�����Ʊ궨����_log_1_magcalib'];
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
    % ��ʾ��������
    figure(1);
    subplot(1,2,i)
    scatter3(x{i}(:,1),x{i}(:,2),x{i}(:,3),'r');hold on;
    xlabel('x (Gs)')
    ylabel('y (Gs)')
    zlabel('z (Gs)')
    axis equal
    %% ��õ��ر�׼�ش�����
    lla0 = mean(data.lla);
    [magXYZ, magHorizontalintensity, magDeclination, magInclination, totalIntensity] = ...
        wrldmagm(abs(lla0(3)), lla0(1), lla0(2), decyear(2015,7,4),'2015');
%     magXYZ = magXYZ/1e3; % nT�任ΪuT
    magXYZ = magXYZ/1e5; % nT�任ΪGs
    %% �궨
    % ͨ���궨���õ��궨����A��b��magNorm
    [A{i},b{i},magNorm,x_correct0] = magCalib_offline(x{i});
    k{i} = norm(magXYZ)/magNorm;
%     x_correct = k{i}*(x{i}-b{i})*A{i}; % ������ʽ
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
%     legend('ԭʼ��r��','����У��')
    legend('�̼�����','ԭʼ����','����У��')
    %% ���ɽ����ļ�
    [~,tempName] = fileparts(dataFileName);
    fileID = fopen(['res_',tempName,'_mag',num2str(i),'.txt'],'w');
    fprintf(fileID,'������ʽ: x_correct = k*(x-b)*A\n');
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