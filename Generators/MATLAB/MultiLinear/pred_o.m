function Y = pred_o(X,W)
    [~, Y] = max(X'*W,[],2); 
    Y = Y - 1;
end