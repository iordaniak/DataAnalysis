n = 10;
X = normrnd(0, 1, n, 1);
meanX = mean(X);
B = 1000;

%(a)------------------------------------------------------
%bootstat = bootstrp(B, @mean, X);
[meanBootsam,bootsam] = bootstrp(B, @mean, X);
hist(meanBootsam, 20);
hold on
yaxV = ylim;
plot(meanX * [1 1],yaxV,'r')

%(b)------------------------------------------------------
meanMeanBootsam = mean(meanBootsam);
S = 0;
for i =1:B
    S = S + (meanBootsam(i)-meanMeanBootsam)^2;
end
seMean = sqrt(1/(B-1) * S);
parsemu = std(X)/sqrt(n);
fprintf('\nstandard error from Bootstrap is: %1.3f\n', seMean);
fprintf('standard error from parametric is: %1.3f\n', parsemu);
parsemu = std(X)/sqrt(n);
bootsemu = std(meanBootsam);

%**********************************************************************

% % Exercise 6 of Chp.3
% % on bootstrap estimate of standard error of sample mean
% n = 10;
% mu = 0;
% sigma = 1;
% B = 1000;
% doexponential = 0; % If 1 do exponential transform first
% 
% % rng(1);
% xV = mu+sigma*randn(n,1);
% % (c) If doexponential=1 do exponential transform first
% if doexponential
%     xV = exp(xV);
% end
% mx = mean(xV);
% 
% bootmxV = NaN(B,1);
% for iB=1:B
%     rV = unidrnd(n,n,1);
%     xbV = xV(rV);
%     bootmxV(iB) = mean(xbV);
% end
% 
% % (a) Draw the histogram of bootstrap statistics.
% figure(1)
% clf
% hist(bootmxV)
% hold on
% yaxV = ylim;
% plot(mx*[1 1],yaxV,'r')
% xlabel('$\bar{x}$','Interpreter','latex')
% ylabel('empirical f of $\bar{x}$','Interpreter','latex')
% title(sprintf('B=%d bootstrap means for sample of size n=%d',B,n))
% 
% % (b) Bootstrap estimate of standard error of sample mean
% parsemu = std(xV)/sqrt(n);
% bootsemu = std(bootmxV);
% fprintf('Estimate of standard error of sample mean = %1.3f \n', parsemu);
% fprintf('Estimate of standard error of sample mean = %1.3f \n', bootsemu);
