clear
close all
clc

%%
load main0

%%
i = 8; %5 round %8 round
p = 3; %3       %3
[d, r] = size(R);
R_q = redprec(R,p);
w_q = redprec(w,p);
X_q = redprec(XT(i,:)',p);
fprintf("Y vera                          = %f\n",YT(i));
Y_o = max(0,X_q'*R_q)*w_q;
fprintf("Y modello p digit conti 64 bit  = %f\n",Y_o);
Y_q = zeros(1,r);
tmp = redprec(repmat(X_q,1,r).*R_q,p);
for j = 1:d
    Y_q = redprec(Y_q+tmp(j,:),p);
end
Y_q = max(0,Y_q);
for j = 2:r
    Y_q(1) = redprec(Y_q(1)+redprec(Y_q(j)*w_q(j),p),p);
end
Y_q = Y_q(1);
fprintf("Y modello p digit conti p digit = %f\n",Y_q);

alpha = 4;
delta = R*diag(X_q'*R>0)*w_q; delta = delta/sqrt(delta'*delta);
X_a = redprec(X_q-YT(i)*alpha*delta,p);
Y_o = max(0,X_a'*R_q)*w_q;
Y_q = zeros(1,r);
tmp = redprec(repmat(X_a,1,r).*R_q,p);
for j = 1:d
    Y_q = redprec(Y_q+tmp(j,:),p);
end
Y_q = max(0,Y_q);
for j = 2:r
    Y_q(1) = redprec(Y_q(1)+redprec(Y_q(j)*w_q(j),p),p);
end
Y_q = Y_q(1);
fprintf("X attacco grande Y modello p digit conti 64 bit  = %f\n",Y_o);
fprintf("X attacco grande Y modello p digit conti p digit = %f\n",Y_q);

for alpha = linspace(0,alpha,10000)
    X_a = redprec(X_q-YT(i)*alpha*delta,p);
    Y_o = max(0,X_a'*R_q)*w_q;
    Y_q = zeros(1,r);
    tmp = redprec(repmat(X_a,1,r).*R_q,p);
    for j = 1:d
        Y_q = redprec(Y_q+tmp(j,:),p);
    end
    Y_q = max(0,Y_q);
    for j = 2:r
        Y_q(1) = redprec(Y_q(1)+redprec(Y_q(j)*w_q(j),p),p);
    end
    Y_q = Y_q(1);
    if (Y_o*Y_q<0)
        fprintf("X attacco min Y modello p digit conti 64 bit  = %f\n",Y_o);
        fprintf("X attacco min Y modello p digit conti p digit = %f\n",Y_q);
        break
    end
end

%%
epsilon = 10^(-p);
X_v = redprec(X_a+YT(i)*epsilon*sign(delta),p);
Y_o = max(0,X_v'*R_q)*w_q;
Y_q = zeros(1,r);
tmp = redprec(repmat(X_v,1,r).*R_q,p);
for j = 1:d
    Y_q = redprec(Y_q+tmp(j,:),p);
end
Y_q = max(0,Y_q);
for j = 2:r
    Y_q(1) = redprec(Y_q(1)+redprec(Y_q(j)*w_q(j),p),p);
end
Y_q = Y_q(1);
fprintf("X vulnerabile Y modello p digit conti 64 bit  = %f\n",Y_o);
fprintf("X vulnerabile Y modello p digit conti p digit = %f\n",Y_q);