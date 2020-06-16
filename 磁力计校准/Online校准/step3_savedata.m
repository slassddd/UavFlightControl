A{1} = modeloutput.simout1_A.Data(:,:,end);
b{1} = modeloutput.simout1_b.Data(:,:,end);
k{1} = modeloutput.simout1_magB.Data(end);
res1_xCorrect = k{1}*(x1-b{1})*A{1};
A{2} = modeloutput.simout2_A.Data(:,:,end);
b{2} = modeloutput.simout2_b.Data(:,:,end);
k{2} = modeloutput.simout2_magB.Data(end);
res2_xCorrect = k{2}*(x2-b{2})*A{2};
% 写txt
for i = 1:2
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
save(['CalibParam_',tempName],'A','b','k');