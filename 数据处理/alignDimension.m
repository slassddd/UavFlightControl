function out = alignDimension(in)
% 将结构体in中的成员维数对齐
children = fieldnames(in);
nChild = length(children);
for i = 1:nChild 
    thisChild = in.(children{i});
    len(i) = length(thisChild);
end
maxLen = max(len);
num = 10;
for i = 1:nChild
    for j = 1:num-1
        in.(children{i})(maxLen-j+1) = in.(children{i})(maxLen-num+1);
    end
%     in.(children{i})(maxLen-1) = in.(children{i})(maxLen-2);
end
out = in;