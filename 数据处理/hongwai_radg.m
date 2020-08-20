%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mat 格式转换为画图
global PathName
if PathName~=0
    cd(PathName);
    [FileName,PathName,~] = uigetfile([PathName,'\\*.*']); % 读取雷达数据
else
    [FileName,PathName,~] = uigetfile('*.*'); % 读取雷达数据
end
if FileName==0
    return;
end

fileID = fopen([PathName,'\\',FileName]);
C = fread(fileID);
fclose(fileID);
len=length(C);
BLOCK_SIZE=9;
m=floor(len/BLOCK_SIZE);
Dist=zeros(m,1);
Strength=zeros(m,1);
Temp=zeros(m,1);
i=1;
j=1;
while(i<(m-1)*BLOCK_SIZE)
    if(C(i)==hex2dec('59')&&C(i+1)==hex2dec('59'))
        Dist(j)=double(typecast(uint8([C(i+2),C(i+3)]),'int16')')*0.01;
        Strength(j)=double(typecast(uint8([C(i+4),C(i+5)]),'int16')')*0.01;
        Temp(j)=double(typecast(uint8([C(i+6),C(i+7)]),'int16')')*0.01;
        if(C(i+8)==mod(sum(C(i:i+7)),256))
            j=j+1;
            i=i+9;
        else
            i=i+1;
        end
    else
        i=i+1;
    end
end
t=((1:j-1)*0.01)';
Dist(j:end)=[];
Strength(j:end)=[];
Temp(j:end)=[];
data_ck=[t Dist Strength Temp];
fid=fopen([PathName,'\\',FileName,'hongwai'],'w');
fprintf(fid,'t Dist Strength Temp\n');
fclose(fid);
save([PathName,'\\',FileName,'hongwai'],'data_ck','-ascii','-append' )
figure;plot(t,Dist)