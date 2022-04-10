M = 100;
n = 10;
X = normrnd(0, 1, n, M);
conf = 0.95;
alpha = 1 - conf;

%(a)-(i)---------------------------------------------------------------------
meanX = mean(X);
varX = var(X);
ciStdLower = zeros(M, 1);
ciStdUpper = zeros(M, 1);
for i = 1:M
    ciStdLower(i) = sqrt(((n-1)*varX(i))/chi2inv(1-alpha/2, n-1));
    ciStdUpper(i) = sqrt(((n-1)*varX(i))/chi2inv(alpha/2, n-1));
end

%(a)-(ii)--------------------------------------------------------------------
ciBoot = zeros(2, M);
B = 1000;
for i = 1:M
    ciBoot(:,i) = bootci(B, @std, X(:,i));
end
%Histograms------------------------------------------------------------------
figure(1)
 histogram(ciStdLower,'BinWidth',0.1,'FaceColor','red')
 hold on
 histogram(ciBoot(1,:),'BinWidth',0.1,'FaceColor','blue')
 title('Lower Bound of Confidence Interval');
figure(2)
 histogram(ciStdUpper,'BinWidth',0.1,'FaceColor','red')
 hold on
 histogram(ciBoot(2,:),'BinWidth',0.1,'FaceColor','blue')
 title('Upper Bound of Confidence Interval');
 
 %*********************************************************************************
 
 
 % Exercise 8 of Chp.3
% Comparison of percentile bootstrap and parametric confidence interval of
% standard deviation (SD). 
% Note that the Matlab default bootstrap (bias corrected and accelerated 
% percentile method) is also called in for comparison. 
clear all
n = 10;
mu = 0;
sigma = 1;
M = 100;
B = 1000;
alpha = 0.05;
dosquare = 0; % If 1, do square transform first
nbin = 10;

% rng(1);
% Generation of all M samples
xM = mu*ones(n,M) + sigma*ones(n,M).*randn(n,M);
if dosquare
    xM = xM.^2;
    sigma = sqrt(2); % This is the SD of the Chi-square distribution with one degree of freedom.
end
xvarV = var(xM)';
cisdxM = NaN(M,6); % the two first are the limits of parametric ci for SD  
              % the other two for the percentile bootstrap ci for SD,
              % the final two for the bias corrected and accelerated 
              % percentile method, which is the default bootstrap in Matlab
klower = floor((B+1)*alpha/2);
kup = B+1-klower;
tailpercV = [klower kup]*100/B;
chi2c1 = chi2inv(alpha/2,n-1);
chi2c2 = chi2inv(1-alpha/2,n-1);
for iM = 1:M
    % Parametric confidence interval (ci) for SD
    varxciV = [(n-1)*xvarV(iM)/chi2c2 (n-1)*xvarV(iM)/chi2c1];
    cisdxM(iM,1:2) = sqrt(varxciV);
    % Percentile bootstrap ci for mean
    bootsdxV = NaN(B,1);
    for iB=1:B
        rV = unidrnd(n,n,1);
        xbV = xM(rV,iM);
        bootsdxV(iB) = std(xbV);
    end
    cisdxM(iM,3:4) = prctile(bootsdxV,tailpercV);
    cisdxM(iM,5:6) = bootci(B,@std,xM(:,iM));
end
% For min
mxmin = min(min(cisdxM(:,[1 3 5])));
mxmax = max(max(cisdxM(:,[1 3 5])));
xcenterV = linspace(mxmin,mxmax,nbin+1);
xcenterV = xcenterV(1:nbin)+0.5*(xcenterV(2)-xcenterV(1));
parNx = hist(cisdxM(:,1),xcenterV);
bootNx = hist(cisdxM(:,3),xcenterV);
boot2Nx = hist(cisdxM(:,5),xcenterV);
figure(1)
clf
plot(xcenterV,parNx/M,'.-','linewidth',1.5)
hold on
plot(xcenterV,bootNx/M,'.-r','linewidth',1.5)
plot(xcenterV,boot2Nx/M,'.-g','linewidth',1.5)
xlabel('lower ci limit')
ylabel('relative frequency')
title(sprintf('M=%d, B=%d n=%d, lower limit of ci of SD',M,B,n))
legend('parametric','Perc.bootstrap','BiasCorr.bootstrap','Location','Best')

% For max
mxmin = min(min(cisdxM(:,[2 4 6])));
mxmax = max(max(cisdxM(:,[2 4 6])));
xcenterV = linspace(mxmin,mxmax,nbin+1);
xcenterV = xcenterV(1:nbin)+0.5*(xcenterV(2)-xcenterV(1));
parNx = hist(cisdxM(:,2),xcenterV);
bootNx = hist(cisdxM(:,4),xcenterV);
boot2Nx = hist(cisdxM(:,6),xcenterV);
figure(2)
clf
plot(xcenterV,parNx/M,'.-','linewidth',1.5)
hold on
plot(xcenterV,bootNx/M,'.-r','linewidth',1.5)
plot(xcenterV,boot2Nx/M,'.-g','linewidth',1.5)
xlabel('upper ci limit')
ylabel('relative frequency')
title(sprintf('M=%d, B=%d n=%d, upper limit of ci of SD',M,B,n))
legend('parametric','Perc.bootstrap','BiasCorr.bootstrap','Location','Best')

iparV = find(cisdxM(:,1)<sigma & cisdxM(:,2)>sigma);
ibootV = find(cisdxM(:,3)<sigma & cisdxM(:,4)>sigma);
iboot2V = find(cisdxM(:,5)<sigma & cisdxM(:,6)>sigma);
fprintf('Coverage probability of %1.2f%% parametric ci of sigma=%1.2f= %1.2f \n',...
    (1-alpha)*100,sigma,length(iparV)/M); 
fprintf('Coverage probability of %1.2f%% percentile bootstrap ci of sigma=%1.2f= %1.2f \n',...
    (1-alpha)*100,sigma,length(ibootV)/M); 
fprintf('Coverage probability of %1.2f%% bias corrected and accelerated percentile bootstrap ci of sigma=%1.2f= %1.2f \n',...
    (1-alpha)*100,sigma,length(iboot2V)/M); 


