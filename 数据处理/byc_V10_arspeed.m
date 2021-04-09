%read_arspeeed
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mat 格式转换为画图
% global PathName
% if PathName~=0
%     cd(PathName);
%     [FileName,PathName,~] = uigetfile([PathName,'\\*.*']); % 读取雷达数据
% else
%     [FileName,PathName,~] = uigetfile('*.*'); % 读取雷达数据
% end
% if FileName==0
%     return;
% end
% fileID = fopen([PathName,'\\',FileName]);
function out = byc_V10_arspeed(filename)
filename = which([filename,'.TXT']);
fileID = fopen(filename);
C = fread(fileID);
fclose(fileID);
len=length(C);
BLOCK_SIZE=24;
m=floor(len/BLOCK_SIZE)-1;
arspeed1=zeros(m,1);
temperature1=zeros(m,1);
ADC1=zeros(m,1);
i=1;
j=1;
while(i<m*BLOCK_SIZE)
    if(C(i)==hex2dec('AA')&&C(i+1)==hex2dec('AA')&&C(i+2)==hex2dec('F1')&&C(i+3)==hex2dec('14'))
        arspeed1(j)=double(typecast(uint8(C(i+7:-1:i+4)),'single')');
        temperature1(j)=double(typecast(uint8(C(i+11:-1:i+8)),'single')');
        ADC1(j)=double(typecast(uint8([C(i+13),C(i+12)]),'int16')');      
%         j=j+1;
%         i=i+BLOCK_SIZE;
        if(C(i+BLOCK_SIZE)==mod(sum(C(i:i+BLOCK_SIZE-1)),256))
            j=j+1;
            i=i+BLOCK_SIZE+1;
        else
            i=i+1;
        end   
    else
        i=i+1;
    end
end
t=((1:j-1)*0.003*1.1030*1.0074)';
arspeed1(j:end)=[];
temperature1(j:end)=[];
ADC1(j:end)=[];
data_ck=[t -arspeed1 temperature1 ADC1];
% fid=fopen([PathName,'\\',FileName,'arspeed'],'w');
% fprintf(fid,'t arspeeed1 temperature1 ADC1\n');
% fclose(fid);
% save([PathName,'\\',FileName,'arspeed'],'data_ck','-ascii','-append' )
out.time = t;
out.arspeed = arspeed1;