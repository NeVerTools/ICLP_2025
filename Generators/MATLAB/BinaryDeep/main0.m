clear 
close all
clc

%%
rng(13)

%%
X0 = load("../MNIST/Mnist0.csv");
X1 = load("../MNIST/Mnist1.csv");
X = [X0; X1];
Y = [-ones(size(X0,1),1); ones(size(X1,1),1)];
X = X*2-1 + 0.001*randn(size(X));

%%
n = 100;
nt = 1000;
i = randperm(length(Y));
XL = X(i(1:n),:);
YL = Y(i(1:n),:);
XT = X(i(n+1:n+nt),:);
YT = Y(i(n+1:n+nt),:);

%%
r = 1000;
d = size(XL,2);
R = randn(d,r); nR = sqrt(sum(R.^2)); R = R./repmat(nR,d,1);

XLR = max(0,XL*R);
XTR = max(0,XT*R);
w = (XLR'*XLR+eye(r))\(XLR'*YL);
w = w/sqrt(w'*w);

%%
save main0 XL YL XT YT R w

%%
YP = XTR*w;
err = mean(YP.*YT<=0)*100;
fprintf("Mean Error %%: %f\n",err);
for p = 1:4
    R_q = redprec(R,p);
    w_q = redprec(w,p);
    XT_q = redprec(XT,p);
    for i = 1:length(YP)
        YP(i) = pred_q(XT_q(i,:)',R_q,w_q,p); %pred_q_mex
    end
    err = mean(YP.*YT<=0)*100;
    fprintf("Mean Error implementation %d digits %%: %f\n",p,err);
end