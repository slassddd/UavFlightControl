function [A_real,b,magB,x_correct] = magCalib(d)
    % 进行椭圆矫正参数计算
    x = d(:,1);
    y = d(:,2);
    z = d(:,3);
    [A,bCol,magB] = bestfit(x,y,z);
    bCol = real(bCol);
    A_real = real(A);
    magB = real(magB);
    b = bCol(:).'; % make a row vector 
    % 矫正公式：x_correct =（x-b）*A;
    x_correct = bsxfun(@minus,d,b)*A_real;
%     d(d==emptyVecFlag(1)) = 0;
%     if numD > maxNum
%         x_correct = bsxfun(@minus,d(1:maxNum,:),b)*A_real;
%     else
%         x_correct(1:numD,:) = bsxfun(@minus,d,b)*A_real;
%     end
end

function [A,b,magB] = bestfit(x,y,z)
% 在三种拟合结果中选择最佳值 （4, 7 or 10 parameter），若需降低计算量，
% 可选择其中一种计算方法

    [A,b,magB, er] = correctEllipsoid4(x,y,z);
    
    [A7,b7,magB7, er7, ispd7] = correctEllipsoid7(x,y,z);
    if ispd7 && isreal(sum(imag(A7(:)))) && (er7 < er)
        A = real(A7);
        b = real(b7);
        magB = magB7;
        er = er7;
    end
    
    [A10,b10,magB10, er10, ispd10] = correctEllipsoid10(x,y,z);
    if ispd10 && isreal(sum(imag(A10(:)))) && (er10 < er)
        A = real(A10);
        b = real(b10);
        magB = magB10;
    end
end

function [Winv, V,B, er, ispd] = correctEllipsoid4(x,y,z)
% R is the identity

    bv = x.*x + y.*y + z.*z;

    A3 = [x,y,z];
    A = [A3 ones(numel(x),1, 'like', x)];

    soln = A\bv;
    Winv = eye(3, 'like', x);
    V = 0.5*soln(1:3);
    B = sqrt(soln(4) + sum(V.*V));
    
    if nargout > 3
        res = A*soln - bv;
        er = (1/(2*B*B) * sqrt( res.'*res / numel(x)));
        ispd = 1;
    else
        er = -ones(1, 'like',x);
        ispd = -1;
    end
    er = real(er);
end

function [Winv, V,B,er, ispd] = correctEllipsoid10(x,y,z)

    d = [...
        x.*x, ...
        2*x.*y, ...
        2*x.*z, ...
        y.*y, ...
        2*y.*z, ...
        z.*z, ...
        x, ...
        y, ...
        z, ...
        ones(size(x))];

    dtd = d.' * d;

    [evc, evlmtx] = eig(dtd);

    eigvals = diag(evlmtx);
    [~, idx] = min(eigvals);

    beta = evc(:,idx); %solution has smallest eigenvalue

    A = beta([1 2 3; 2 4 5; 3 5 6]); %make symmetric
    dA = real(det(A));

    if dA < 0
        A = -A;
        beta = -beta;
        dA = -dA; %Compensate for -A.
    end

    V = -0.5*(A\beta(7:9)); %hard iron offset

    B = sqrt(abs(sum([...
        A(1,1)*V(1)*V(1), ...
        2*A(2,1)*V(2)*V(1), ...
        2*A(3,1)*V(3)*V(1), ...
        A(2,2)*V(2)*V(2), ...
        2*A(3,2)*V(2)*V(3), ...
        A(3,3)*V(3)*V(3), ...
        -beta(end)] ...
    )));
  
    % We correct Winv and B by det(A) because we don't know which has the
    % gain. By convention, normalize A.

    det3root = nthroot(dA,3);
    det6root = sqrt(det3root);
    Winv = sqrtm(A./det3root);
    B = B./det6root;
    
    if nargout > 3 
        res = residual(Winv,V,B, [x,y,z]);
        er = (1/(2*B*B))*sqrt(res.'*res/numel(x));
        [~,p] = chol(A);
        ispd = (p == 0);
    else
        er = -ones(1, 'like',x);
        ispd = -1;
    end
    er = real(er);

end

function [Winv, V,B,er, ispd] = correctEllipsoid7(x,y,z)

    d = [...
        x.*x, ...
        y.*y, ...
        z.*z, ...
        x, ...
        y, ...
        z, ...
        ones(size(x))];


    dtd = d.' * d;

    [evc, evlmtx] = eig(dtd);

    eigvals = diag(evlmtx);
    [~, idx] = min(eigvals);

    beta = evc(:,idx); %solution has smallest eigenvalue
    A = diag(beta(1:3));
    dA = real(det(A));

    if dA < 0
        A = -A;
        beta = -beta;
        dA = -dA; %Compensate for -A.
    end
    V = -0.5*(beta(4:6)./beta(1:3)); %hard iron offset

    B = sqrt(abs(sum([...
        A(1,1)*V(1)*V(1), ...
        A(2,2)*V(2)*V(2), ...
        A(3,3)*V(3)*V(3), ...
        -beta(end)] ...
    )));
  

    % We correct Winv and B by det(A) because we don't know which has the
    % gain. By convention, normalize A.

    det3root = nthroot(dA,3);
    det6root = sqrt(det3root);
    Winv = sqrtm(A./det3root);
    B = B./det6root;
    
    if nargout > 3
        res = residual(Winv,V,B, [x,y,z]);
        er = (1/(2*B*B))*sqrt(res.'*res/numel(x));
        [~,p] = chol(A);
        ispd = (p == 0);
    else
        er = -ones(1, 'like',x);
        ispd = -1;
    end
    er = real(er);
end

function r = residual(Winv, V, B, data)
% Residual error after correction

spherept = (Winv * bsxfun(@minus,data.',V)).'; % a point on the unit sphere
radsq = sum(spherept.^2,2);

r = radsq - B.^2;
end