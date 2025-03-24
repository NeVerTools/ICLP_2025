clear
close all
clc

%%
load main0

%%
%i = 1;
for i = 1:100
    p = 3;
    [d,c] = size(W);
    W_q = redprec(W,p);
    X_q = redprec(XT(i,:)',p);
    fprintf("%d - Y true \n",YT(i));
    Y_o_t = pred_o(X_q,W_q);
    fprintf("%d - Y predicted computation double \n",Y_o_t);
    Y_q = pred_q(X_q,W_q,p);
    fprintf("%d - Y predicted computation p digits \n",Y_q);
    
    if (Y_o_t ~= YT(i))
        % Not robust
        continue
    end

    alpha = 2;
    X_a = redprec(X_q-alpha*W_q(:,YT(i)+1),p);
    Y_o_f = pred_o(X_a,W_q);
    Y_q = pred_q(X_a,W_q,p);
    fprintf("%d - Big attack - Y predicted computation double \n",Y_o_f);
    fprintf("%d - Big attack - Y predicted computation p digits \n",Y_q);
    
    if (Y_o_f == Y_o_t)
        % Too much robust
        continue
    end

    lb = 0;
    ub = alpha;
    
    while (ub - lb > 10^(-p-1))
        mid = (lb + ub) / 2;
    
        X_a = redprec(X_q-mid*W_q(:,YT(i)+1),p);
        Y_o = pred_o(X_a,W_q);
        Y_q = pred_q(X_a,W_q,p);
    
        if (Y_q ~= Y_o_t)
            ub = mid;
        else
            lb = mid;
        end
    end
    
    
    if (Y_q ~= Y_o)
        fprintf("%d - Smaller attack - Y predicted computation double \n",Y_o);
        fprintf("%d - Smaller attack - Y predicted computation p digits \n",Y_q);
    end

    if (Y_o ~= Y_o_t)
        % Wrong side
        continue
    end
    
    %%
    epsilon = 10^(-p);
    X_v = redprec(X_a+epsilon*sign(W_q(:,YT(i)+1)),p);
    Y_o = pred_o(X_v,W_q);
    Y_q = pred_q(X_v,W_q,p);
    fprintf("%d - Verification Point - Y predicted computation double \n",Y_o);
    fprintf("%d - Verification Point - Y predicted computation p digits \n",Y_q);
    
    
    writematrix(W_q', sprintf('../../Data/weights/Multi Linear/w_%d_1_%d.csv', i-1, p))
    
    writematrix(X_v, sprintf('../../Data/points/Multi Linear/xv_%d_1_%d.csv', i-1, p))
    
    writematrix(YT(i), sprintf('../../Data/labels/Multi Linear/yt_%d_1_%d.csv', i-1, p))
end