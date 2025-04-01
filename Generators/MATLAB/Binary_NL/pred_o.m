function Y = pred_o(X,R,w)
    Y = max(0,X'*R)*w;
end