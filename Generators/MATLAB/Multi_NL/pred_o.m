function Y = pred_o(X,R,W)
    [~, Y] = max(max(0,X'*R)*W,[],2); 
    Y = Y - 1;
end