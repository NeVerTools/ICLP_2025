clear 
close all
clc

%%
rng(13)

%%
X0 = load("Mnist0.csv");
X1 = load("Mnist1.csv");
X = [X0; X1];
y = [-ones(size(X0,1),1); ones(size(X1,1),1)];
X = X*2-1 + 0.001*randn(size(X));

%%
n = 100;
i = randperm(length(y));
XL = X(i(1:n),:);
YL = y(i(1:n),:);
XT = X(i(n+1:end),:);
YT = y(i(n+1:end),:);

%%
r = 1000;
d = size(XL,2);
R = randn(d,r); nR = sqrt(sum(R.^2)); R = R./repmat(nR,d,1);

XLR = max(0,XL*R);
XTR = max(0,XT*R);
w = (XLR'*XLR+eye(r))\(XLR'*YL);
w = w/sqrt(w'*w);

%%
YP = XTR*w;
err = mean(YP.*YT<=0)*100;
fprintf("Errore modello %%: %f\n",err);

%%
save main0 XL YL XT YT YP R w err