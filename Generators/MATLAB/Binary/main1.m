clear
close all
clc

%%
load main0

%%
i = 2;
p = 4;
w_q = redprec(w,p);
X_q = redprec(XT(i,:)',p);
fprintf("X p digit Yt = %f\n",YT(i));
fprintf("X p digit Yp = %f\n",sign(X_q'*w_q));

alpha = 10;
X_a = redprec(X_q-YT(i)*alpha*w_q,p);
Y_o = X_a'*w_q;
Y_q = 0;
tmp = redprec(X_a.*w_q,p);
for j = 1:length(tmp)
    Y_q = redprec(Y_q+tmp(j),p);
end
fprintf("X attacco grande Y modello p digit conti 64 bit  = %f\n",Y_o);
fprintf("X attacco grande Y modello p digit conti p digit = %f\n",Y_q);

for alpha = linspace(0,alpha,1000000)
    X_a = redprec(X_q-YT(i)*alpha*w_q,p);
    Y_o = X_a'*w_q;
    Y_q = 0;
    tmp = redprec(X_a.*w_q,p);
    for j = 1:length(tmp) 
        Y_q = redprec(Y_q+tmp(j),p);
    end
    if (Y_o*Y_q<0)
        fprintf("X attacco min Y modello p digit conti 64 bit  = %f\n",Y_o);
        fprintf("X attacco min Y modello p digit conti p digit = %f\n",Y_q);
        fprintf("alpha = %f\n", alpha)
        break
    end
end

epsilon = 10^(-p);
X_v = redprec(X_a+YT(i)*epsilon*sign(w_q),p);
Y_o = X_v'*w_q;
Y_q = 0;
tmp = redprec(X_v.*w_q,p);
for j = 1:length(tmp)
    Y_q = redprec(Y_q+tmp(j),p);
end
fprintf("X vulnerabile Y modello p digit conti 64 bit  = %f\n",Y_o);
fprintf("X vulnerabile Y modello p digit conti p digit = %f\n",Y_q);

save main1 X_v

% @Stefano demarchi
% Prendi
% X_v, il punto vulnerabile quantizzato
% w_q, modello lineare quantizzato
% epsilon, grandezza attacco quantizzato a norma infinito
% Usi il podio della competizione + never per dire se è sicuro
% il punto che esiste che da divverenza è X_a perchè
% - con il modello quantizzato ma conti fatti a 64 è safe 
% - con il modello quantizzato ma conti fatti a p bit non è safe 

%%
f = YT(i)*w_q;
A = []; b = []; Aeq = []; beq = [];
lb = X_v-epsilon*ones(size(X_v));
ub = X_v+epsilon*ones(size(X_v));
x = linprog(f,A,b,Aeq,beq,lb,ub);
fprintf("Min/Max valore nella palla: %f", x'*w_q);