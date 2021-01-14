function [data,Count] = readBinFile(fullname,blockSize)
fp = fopen(fullname,'r');
data = fread(fp);
fclose(fp);

n=length(data);
i=1;
m=floor(n/blockSize);
data=reshape(data(1:blockSize*m)',[blockSize,m]);
data=data';

Count=binDecode(data,1,0,0);
indexn=find(mod(Count,8)==1);
if( indexn(1) >1 )
    data=data(indexn(1):end,:);
end

[m,~]=size(data);
m=floor(m/8)*8;
data=data(1:m,:);
Count=binDecode(data,1,0,0);