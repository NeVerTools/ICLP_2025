function Y = pred_q(X,w,p)
    Y = 0;
    tmp = redprec(X.*w,p);
    for j = 1:length(tmp)
        Y = redprec(Y+tmp(j),p);
    end
end

