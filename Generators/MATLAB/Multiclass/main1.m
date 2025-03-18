clear
close all
clc

%%
load main0

%%
i     = 2;
cifre = 3;

fprintf("Y vera         = %f\n",YT(i));
fprintf("Y predetta     = %f\n",YP(i));

W_o = W;
W_q = round(W*10^cifre)/10^cifre;
X_o = XT(i,:)';
X_q = (round(XT(i,:)')*10^cifre)/10^cifre;

for alpha = linspace(0,1,10000)
    offset = (-alpha*W(:,YP(i)+1)*10^cifre)/10^cifre;
    X_a = min(1,max(-1,X_o+offset));
    X_aq = (round(X_a)*10^cifre)/10^cifre;
    [~, tmp] = max(X_a' *W_o,[],2); Y_oo = tmp-1;
    [~, tmp] = max(X_aq'*W_q,[],2); Y_qq = tmp-1;
    if (Y_oo ~= Y_qq)
        fprintf("alpha = %f - ",alpha);
        fprintf("Y_oo = %f - ",Y_oo);
        fprintf("Y_qq = %f \n",Y_qq);
    end
end