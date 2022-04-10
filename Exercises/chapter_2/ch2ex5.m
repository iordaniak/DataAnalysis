% n = 1000;
% meanX = 4;
% s2X = 0.01;
% sX = sqrt(s2X);
% 
% X = normrnd(meanX, sX, n, 1);
% 
% p = normcdf(3.9, meanX, sX);
% limit = norminv(0.01, meanX, sX);
% fprintf('\nThe propability is %3.3f\t\n', p);
% fprintf('The limit is %3.3f\t\n', limit);

%**********************************************************************************

% Exercise 2.5: Probabilities on Normal distribution
mu = 4;
sigmasq = 0.01;
x0 = 3.9;
p1 = 0.01;

% P(X<x0)
sigma = sqrt(sigmasq);
px0 = normcdf(x0,mu,sigma);
x1 = norminv(p1,mu,sigma);
fprintf('F_X(%3.3f)=P(X<%3.3f)=%3.3f \t F^{-1}_X(%3.3f)=%3.3f \n',x0,x0,...
    px0,p1,x1);