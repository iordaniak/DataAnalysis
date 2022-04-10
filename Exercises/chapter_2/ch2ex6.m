% n = 100;
% X = zeros(n, 1);
% N = 10000;
% Y = zeros(N, 1);
% 
% for i = 1:N
%     X = unifrnd(0, 1, n, 1);
%     Y(i) = mean(X);
% end
% figure(1)
% bins = 100;
% histfit(Y, bins)

%***************************************************************************

% Exercise 2.6: Simulation of the central limiti theorem
nvar = 100;
n = 10000;
bins = 100;

yV = mean(rand(nvar,n));
figure(1)
clf
histfit(yV,bins);
xlabel('x')
ylabel('counts')
title(sprintf('%d means of %d uniform variables',n,nvar))