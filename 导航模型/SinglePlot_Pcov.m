            timePcov = out.NavFilterRes.Pdiag.Time;
            Pcov = 3*out.NavFilterRes.Pdiag.Data.^0.5;
            ncol = 5;
            nrow = 3;
            figure(1);
            % ��̬
            idxrow = 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,4));hold on;grid on;ylabel('q3');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,2));hold on;grid on;ylabel('q1');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,3));hold on;grid on;ylabel('q2');
            % λ��
            idxrow = idxrow + 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,5));hold on;grid on;ylabel('Pn');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,6));hold on;grid on;ylabel('Pe');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,7));hold on;grid on;ylabel('Pd');        
            % �ٶ�
            idxrow = idxrow + 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,8));hold on;grid on;ylabel('Vn');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,9));hold on;grid on;ylabel('Ve');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,10));hold on;grid on;ylabel('Vd');  
            % ������
            idxrow = idxrow + 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,11));hold on;grid on;ylabel('Dangle_x');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,12));hold on;grid on;ylabel('Dangle_y');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,13));hold on;grid on;ylabel('Dangle_z');        
            % �ٶ�����
            idxrow = idxrow + 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,14));hold on;grid on;ylabel('Dvel_x');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,15));hold on;grid on;ylabel('Dvel_y');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,16));hold on;grid on;ylabel('Dvel_z'); 
            % �ش�
            idxrow = idxrow + 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,17));hold on;grid on;ylabel('mag_x');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,18));hold on;grid on;ylabel('mag_y');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,19));hold on;grid on;ylabel('mag_z');     
            % �ش�ƫ��
            idxrow = idxrow + 1;
            subplot(7,3,1+(idxrow-1)*3);
            plot(timePcov,Pcov(:,20));hold on;grid on;ylabel('Dmag_x');
            subplot(7,3,2+(idxrow-1)*3);
            plot(timePcov,Pcov(:,21));hold on;grid on;ylabel('Dmag_y');            
            subplot(7,3,3+(idxrow-1)*3);
            plot(timePcov,Pcov(:,22));hold on;grid on;ylabel('Dmag_z');      