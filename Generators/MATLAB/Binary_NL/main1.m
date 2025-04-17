clear
close all
clc

%%
load main0
p = 4;
R_q = redprec(R,p);
w_q = redprec(w,p);
writematrix(R_q', sprintf("../../Data/weights/Binary_NL/fc1_2_%d.csv", p))
writematrix(w_q', sprintf("../../Data/weights/Binary_NL/fc2_2_%d.csv", p))

%%
for i = 1:100
    X_q = redprec(XT(i,:)',p);
    fprintf("%+f - Y true \n",YT(i));
    Y_o_t = pred_o(X_q,R_q,w_q);
    fprintf("%+f - Y predicted computation double \n",Y_o_t);
    Y_q = pred_q(X_q,R_q,w_q,p);
    fprintf("%+f - Y predicted computation p digits \n",Y_q);
    
    if (Y_o_t * YT(i) < 0)
        % Not robust
        continue
    end

    alpha = 10;
    delta = R_q*diag(X_q'*R_q>0)*w_q; delta = delta/sqrt(delta'*delta);
    X_a = redprec(X_q-YT(i)*alpha*delta,p);
    Y_o_f = pred_o(X_a,R_q,w_q);
    Y_q = pred_q(X_a,R_q,w_q,p);
    fprintf("%+f - Big attack - Y predicted computation double \n",Y_o_f);
    fprintf("%+f - Big attack - Y predicted computation p digits \n",Y_q);
    
    if (Y_o_f * Y_o_t > 0)
        % Too much robust
        continue
    end

    lb = 0;
    ub = alpha;
    
    while (ub - lb > 10^(-p-1))
        mid = (lb + ub) / 2;
    
        X_a = redprec(X_q-YT(i)*mid*delta,p);
        Y_o = pred_o(X_a,R_q,w_q);
        Y_q = pred_q(X_a,R_q,w_q,p);
    
        if (Y_q * Y_o_t < 0)
            ub = mid;
        else
            lb = mid;
        end
    end
    
    if (Y_o*Y_o_t > 0 && Y_o*Y_q<0)
        fprintf("%+f - Smaller attack - Y predicted computation double \n",Y_o);
        fprintf("%+f - Smaller attack - Y predicted computation p digits \n",Y_q);

        %%
        epsilon = 10^(-p);
        X_v = redprec(X_a+YT(i)*epsilon*sign(delta),p);
        Y_o = pred_o(X_v,R_q,w_q);
        Y_q = pred_q(X_v,R_q,w_q,p);

        if (Y_o*Y_q > 0)
            fprintf("*** INDEX %d ***\n", i-1);
            fprintf("%+f - Verification Point - Y predicted computation double \n",Y_o);
            fprintf("%+f - Verification Point - Y predicted computation p digits \n",Y_q);
            
            writematrix(X_v, sprintf("../../Data/points/Binary_NL/xv_%d_2_%d.csv", i-1, p))
            writematrix(YT(i), sprintf("../../Data/labels/Binary_NL/yt_%d_2_%d.csv", i-1, p))
        end
    end
end