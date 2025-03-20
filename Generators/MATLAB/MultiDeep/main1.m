clear
close all
clc

%%
load main0

%%
i = 6; %6
p = 3; %4
R_q = redprec(R,p);
W_q = redprec(W,p);
X_q = redprec(XT(i,:)',p);
fprintf("%d - Y true \n",YT(i));
Y_o_t = pred_o(X_q,R_q,W_q);
fprintf("%d - Y predicted computation double \n",Y_o_t);
Y_q = pred_q(X_q,R_q,W_q,p);
fprintf("%d - Y predicted computation p digits \n",Y_q);

alpha = 1;
delta = R_q*diag(X_q'*R_q>0)*W_q(:,YT(i)+1); delta = delta/sqrt(delta'*delta);
X_a = redprec(X_q-alpha*delta,p);
Y_o_f = pred_o(X_a,R_q,W_q);
Y_q = pred_q(X_a,R_q,W_q,p);
fprintf("%d - Big attack - Y predicted computation double \n",Y_o_f);
fprintf("%d - Big attack - Y predicted computation p digits \n",Y_q);

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
else
    %% The binary search did not find the right spot, use linear search
    for alpha = linspace(0,alpha,10^p*alpha*10)
        X_a = redprec(X_q-alpha*delta,p);
        Y_o = pred_o(X_a,R_q,W_q);
        Y_q = pred_q(X_a,R_q,W_q,p);
        if (Y_o ~= Y_q)
            fprintf("%d - Smaller attack - Y predicted computation double \n",Y_o);
            fprintf("%d - Smaller attack - Y predicted computation p digits \n",Y_q);
            break
        end
    end
end

%%
epsilon = 10^(-p);
X_v = redprec(X_a+epsilon*sign(delta),p);
Y_o = pred_o(X_v,R_q,W_q);
Y_q = pred_q(X_v,R_q,W_q,p);
fprintf("%d - Verification Point - Y predicted computation double \n",Y_o);
fprintf("%d - Verification Point - Y predicted computation p digits \n",Y_q);

writematrix(R_q', '../Data/fc1_5_3_3.csv')
writematrix(W_q', '../Data/fc2_5_3_3.csv')

writematrix(X_v, '../Data/xv_5_3_3.csv')

writematrix(YT(i), '../Data/yt_5_3_3.csv')