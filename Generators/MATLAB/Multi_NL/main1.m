clear
close all
clc

%%
load main0

%%
%i = 27;
for i=1:100
    p = 3;
    R_q = redprec(R,p);
    W_q = redprec(W,p);
    X_q = redprec(XT(i,:)',p);
    fprintf("%d - Y true \n",YT(i));
    Y_o_t = pred_o(X_q,R_q,W_q);
    fprintf("%d - Y predicted computation double \n",Y_o_t);
    Y_q = pred_q(X_q,R_q,W_q,p);
    fprintf("%d - Y predicted computation p digits \n",Y_q);
    
    if (Y_o_t ~= YT(i))
        % Not robust
        continue
    end

    alpha = 2;
    delta = R_q*diag(X_q'*R_q>0)*W_q(:,YT(i)+1); delta = delta/sqrt(delta'*delta);
    X_a = redprec(X_q-alpha*delta,p);
    Y_o_f = pred_o(X_a,R_q,W_q);
    Y_q = pred_q(X_a,R_q,W_q,p);
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
    
        X_a = redprec(X_q-mid*delta,p);
        Y_o = pred_o(X_a,R_q,W_q);
        Y_q = pred_q(X_a,R_q,W_q,p);
    
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
    X_v = redprec(X_a+epsilon*sign(delta),p);
    Y_o = pred_o(X_v,R_q,W_q);
    Y_q = pred_q(X_v,R_q,W_q,p);
    fprintf("%d - Verification Point - Y predicted computation double \n",Y_o);
    fprintf("%d - Verification Point - Y predicted computation p digits \n",Y_q);
    
    writematrix(R_q', sprintf('../../Data/weights/Multi_NL/fc1_%d_3_%d.csv', i-1, p))
    writematrix(W_q', sprintf('../../Data/weights/Multi_NL/fc2_%d_3_%d.csv', i-1, p))
    
    writematrix(X_v, sprintf('../../Data/points/Multi_NL/xv_%d_3_%d.csv', i-1, p))
    
    writematrix(YT(i), sprintf('../../Data/labels/Multi_NL/yt_%d_3_%d.csv', i-1, p))
end