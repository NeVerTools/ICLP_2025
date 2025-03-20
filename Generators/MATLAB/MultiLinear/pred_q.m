function Y = pred_q(X,W,p)
    [d,c] = size(W);
    Y = zeros(1,c);
    tmp = redprec(repmat(X,1,c).*W,p);
    for j = 1:d
        Y = redprec(Y+tmp(j,:),p);
    end
    [~, Y] = max(Y,[],2);
    Y = Y - 1;
end

