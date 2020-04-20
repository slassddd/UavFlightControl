function res = angluarSubsDeg(angle1,angle2,mode)
% 角度值相减[deg],并将结果归一化到指定区间
% angle: 最高支持2维向量
% mode: 1. '[-180,180)'    2. '[0,360)'
% example: res = angluarSubsDeg(179,181,'[-180,180)')
angle1 = rem(angle1,360);
angle2 = rem(angle2,360);
[nrow,ncol] = size(angle1);
err = zeros(nrow,ncol);
res = zeros(nrow,ncol);

for row = 1:nrow
    for col = 1:ncol
        err(row,col,1) = angle1(row,col) - angle2(row,col) - 360;
        err(row,col,2) = angle1(row,col) - angle2(row,col);
        err(row,col,3) = angle1(row,col) - angle2(row,col) + 360;
        [~,idx] = min(abs(err(row,col,:)));
        res(row,col) = rem(err(row,col,idx),180);
        if err(row,col,idx) == -180
            res(row,col) = -180;
        end
    end
end
switch mode
    case '[-180,180)'
        
    case '[0,360)'
        res = res+180;
    otherwise
        error('wrong angle range set!')
end