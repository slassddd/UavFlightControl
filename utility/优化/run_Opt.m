clear,clc
mode = '+-+-'; % '+-+-' '+--+' '++--'
mode = '+-+-+-';% '+-++--'  '+-+-+-' '+++---'
nRotor = length(mode);
options = optimoptions(@linprog,'Algorithm','dual-simplex','Display','iter');
A = eye(nRotor);
b = 100*ones(nRotor,1);
Aeq = getAeq(mode);
lb = 0*ones(1,nRotor);
f = ones(1,nRotor);
beqs = [...
    1  0  0;
   -1  0  0;
    0  1  0;
    0 -1  0;
    0  0  1;
    0  0 -1;];
labels = {'Mx+','Mx-','My+','My-','Mz+','Mz-'};
for i = 1:size(beqs,1)
    beq = beqs(i,:)';
    [x,feval] = linprog(f,A,b,Aeq,beq,lb);
    if isempty(x)
        
    else
        fprintf('%s: %.0f\n',labels{i},f*x);
        fprintf('\t%.1f',Aeq*x);fprintf('\n\n')
        fprintf('\t%.3f\n ',x);
    end
end

%%
function out = getAeq(mode)
switch mode
    case '+-+-'
        out = [1 -1 -1 1;1 1 -1 -1;1 -1 1 -1];
    case '+--+'
        out = [1 -1 -1 1;1 1 -1 -1;1 -1 -1 1];
    case '+---'
        out = [1 -1 -1 1;1 1 -1 -1;1 -1 -1 -1];
    case '++--'
        out = [1 -1 -1 1;1 1 -1 -1;1 1 -1 -1];
    case '+-++--'
        out = [1 -1 -1 -1 1 1;1 1 0 -1 -1 0;1 -1 1 1 -1 -1];
    case '+-+-+-'
        out = [1 -1 -1 -1 1 1;1 1 0 -1 -1 0;1 -1 1 -1 1 -1];
    case '+++---'
        out = [1 -1 -1 -1 1 1;1 1 0 -1 -1 0;1 1 1 -1 -1 -1];
end
end