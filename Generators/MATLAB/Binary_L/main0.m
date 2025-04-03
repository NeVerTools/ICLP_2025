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
X = X*2-1+0.001*randn(size(X));

%%
n = 100;
nt = 1000;
i = randperm(length(Y));
XL = X(i(1:n),:);
YL = Y(i(1:n),:);
XT = X(i(n+1:n+nt),:);
YT = Y(i(n+1:n+nt),:);

%%
w = (XL'*XL+eye(size(XL,2)))\(XL'*YL);
w = w/sqrt(w'*w);

%%
save main0 XL YL XT YT w

%%
YP = XT*w;
err = mean(YP.*YT<=0)*100;
fprintf("Mean Error %%: %f\n",err);
for p = 1:5
    w_q = redprec(w,p);
    XT_q = redprec(XT,p);
    for i = 1:length(YP)
        YP(i) = pred_q(XT_q(i,:)',w_q,p);
    end
    err = mean(YP.*YT<=0)*100;
    fprintf("Mean Error implementation %d digits %%: %f\n",p,err);
end