clear 
close all
clc

%%
rng(13)

%%
X = []; 
Y = [];
for i = 0:9
    tmpX = load(sprintf("Mnist%d.csv",i));
    tmpY = i*ones(size(tmpX,1),1);
    X = [X; tmpX]; %#ok<AGROW>
    Y = [Y; tmpY]; %#ok<AGROW>
end
X = min(1,max(-1,X*2-1 + 0.001*randn(size(X))));

%%
n = 1000*10;
i = randperm(length(Y));
XL = X(i(1:n),:);
YL = Y(i(1:n),:);
XT = X(i(n+1:end),:);
YT = Y(i(n+1:end),:);

%%
W = [];
Q = XL'*XL;
for i = 0:9
    Ytmp = (YL==i)*2-1;
    Wtmp = (Q+eye(size(XL,2)))\(XL'*Ytmp);
    Wtmp = Wtmp/sqrt(Wtmp'*Wtmp); %ho normalizatto già a 1 tutti i pesi
    W = [W, Wtmp]; %#ok<AGROW>
end

%%
[~, YP] = max(XT*W,[],2); YP = YP-1;
err = mean(YP ~= YT);
fprintf("Errore modello: %f\n",err);

%%
save main0 XL YL XT YT YP W err