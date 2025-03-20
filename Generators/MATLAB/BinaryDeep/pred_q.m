function Y = pred_q(X,R,w,p)
    [d, r] = size(R);
    Y = zeros(1,r);
    tmp = redprec(repmat(X,1,r).*R,p);
    for j = 1:d
        Y = redprec(Y+tmp(j,:),p);
    end
    Y = max(0,Y);
    for j = 2:r
        Y(1) = redprec(Y(1)+redprec(Y(j)*w(j),p),p);
    end
    Y = Y(1);
end

