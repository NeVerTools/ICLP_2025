function Y = pred_q(X,R,W,p)
    [d, r] = size(R);
    [~, c] = size(W);
    Y = zeros(1,r);
    tmp = redprec(repmat(X,1,r).*R,p);
    for j = 1:d
        Y = redprec(Y+tmp(j,:),p);
    end
    tmp = max(0,Y)';
    Y = zeros(1,c);
    tmp = redprec(repmat(tmp,1,c).*W,p);
    for j = 1:r
        Y = redprec(Y+tmp(j,:),p);
    end
    [~, Y] = max(Y,[],2);
    Y = Y - 1;
end

