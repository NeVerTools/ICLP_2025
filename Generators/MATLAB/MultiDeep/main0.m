clear 
close all
clc

%%
rng(13)

%%
X = []; 
Y = [];
for i = 0:9
    tmpX = load(sprintf("../MNIST/Mnist%d.csv",i));
    tmpY = i*ones(size(tmpX,1),1);
    X = [X; tmpX]; %#ok<AGROW>
    Y = [Y; tmpY]; %#ok<AGROW>
end
X = X*2-1 + 0.001*randn(size(X));

%%
n  = 1000*10;
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
W = [];
Q = XLR'*XLR;
for i = 0:9
    Ytmp = (YL==i)*2-1;
    Wtmp = (Q+eye(size(XLR,2)))\(XLR'*Ytmp);
    Wtmp = Wtmp/sqrt(Wtmp'*Wtmp);
    W = [W, Wtmp]; %#ok<AGROW>
end

%%
save main0 XL YL XT YT R W

%%
[~, YP] = max(XTR*W,[],2); YP = YP-1;
err = mean(YP~=YT)*100;
fprintf("Mean Error %%: %f\n",err);
for p = 1:4
    R_q = redprec(R,p);
    W_q = redprec(W,p);
    XT_q = redprec(XT,p);
    for i = 1:length(YP)
        YP(i) = pred_q(XT_q(i,:)',R_q,W_q,p);
    end
    err = mean(YP~=YT)*100;
    fprintf("Mean Error implementation %d digits %%: %f\n",p,err);
end