% n = 1000;
% lambda = 1;
% bins = 20;
% 
% x = rand(n);
% RandomExpNumbers = -(1/lambda) * log(1-x);
% [Ny, Xy] = hist(RandomExpNumbers, bins)

%******************************************************************************************************

%hist(RandomExpNumbers);
%plot(RandomExpNumbers);
% Exercise 2 of Chp.2 
% Generation of data from exponential distribution using the inverse from uniform.
n = 1000;
lambda = 1;
bins = 20;

% Generate random numbers from exponential distribution and form bins 
% (as if to draw a histogram)
rV = rand(n,1);
yV = -(1/lambda)*log(1-rV);
[Ny,Xy]=hist(yV,bins);  % Xy has the centers of bins, Ny the frequencies

% First (simple) way to plot simulated (from histogram) together with
% analytic expression for the pdf. The y-axis has the scale for relative
% frequency.
ypdfV = lambda*exp(-lambda*Xy);
ypdfV = ypdfV / sum(ypdfV);
figure(1)
clf
plot(Xy,Ny/n,'.-k')
hold on
plot(Xy,ypdfV,'c')
legend('simulated','analytic')
xlabel('x')
ylabel('f_X(x) - relative frequency scale')
title(['Exponential distribution from ',int2str(n),' samples'])