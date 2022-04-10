M = 100;
n = 10;
X = normrnd(0, 1, n, M);
conf = 0.95;
alpha = 1 - conf;

%(a)-(i)---------------------------------------------------------------------
meanX = mean(X);
varX = var(X);
ciMeanLower = zeros(M, 1);
ciMeanUpper = zeros(M, 1);
for i = 1:M
    ciMeanLower(i) = meanX(i) - tinv(1 - alpha/2, n-1) * sqrt(varX(i)/n);
    ciMeanUpper(i) = meanX(i) + tinv(1 - alpha/2, n-1) * sqrt(varX(i)/n);
end

%(a)-(ii)--------------------------------------------------------------------
ciBoot = zeros(2, M);
B = 1000;
for i = 1:M
    ciBoot(:,i) = bootci(B, @mean, X(:,i));
end
%Histograms------------------------------------------------------------------
figure(1)
 histogram(ciMeanLower,'BinWidth',0.1,'FaceColor','red')
 hold on
 histogram(ciBoot(1,:),'BinWidth',0.1,'FaceColor','blue')
 title('Lower Bound of Confidence Interval');
figure(2)
 histogram(ciMeanUpper,'BinWidth',0.1,'FaceColor','red')
 hold on
 histogram(ciBoot(2,:),'BinWidth',0.1,'FaceColor','blue')
 title('Upper Bound of Confidence Interval');
 
 %***********************************************************************************************
 
 % Exercise 7 of Chp.3
% Comparison of percentile bootstrap and parametric confidence interval of
% mean. 
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
    mu = 1; % This is the mean of the Chi-square distribution with one degree of freedom.
end
xmV = mean(xM)';
xsdV = std(xM)';
cimxM = NaN(M,6); % the two first are the limits of parametric ci for mean  
              % the other two for the percentile bootstrap ci for mean,
              % the final two for the bias corrected and accelerated 
              % percentile method, which is the default bootstrap in Matlab
klower = floor((B+1)*alpha/2);
kup = B+1-klower;
tailpercV = [klower kup]*100/B;
tcrit = tinv(1-alpha/2,n-1);
for iM = 1:M
    % Parametric confidence interval (ci) for mean
    mx1err = tcrit * xsdV(iM) / sqrt(n);
    cimxM(iM,1:2) = [xmV(iM)-mx1err xmV(iM)+mx1err];
    % Percentile bootstrap ci for mean
    bootmxV = NaN(B,1);
    for iB=1:B
        rV = unidrnd(n,n,1);
        xbV = xM(rV,iM);
        bootmxV(iB) = mean(xbV);
    end
    cimxM(iM,3:4) = prctile(bootmxV,tailpercV);
    cimxM(iM,5:6) = bootci(B,@mean,xM(:,iM));
end
% For min
mxmin = min(min(cimxM(:,[1 3 5])));
mxmax = max(max(cimxM(:,[1 3 5])));
xcenterV = linspace(mxmin,mxmax,nbin+1);
xcenterV = xcenterV(1:nbin)+0.5*(xcenterV(2)-xcenterV(1));
parNx = hist(cimxM(:,1),xcenterV);
bootNx = hist(cimxM(:,3),xcenterV);
boot2Nx = hist(cimxM(:,5),xcenterV);
figure(1)
clf
plot(xcenterV,parNx/M,'.-','linewidth',1.5)
hold on
plot(xcenterV,bootNx/M,'.-r','linewidth',1.5)
plot(xcenterV,boot2Nx/M,'.-g','linewidth',1.5)
xlabel('lower ci limit')
ylabel('relative frequency')
title(sprintf('M=%d, B=%d n=%d, lower limit of ci of mean',M,B,n))
legend('parametric','Perc.bootstrap','BiasCorr.bootstrap','Location','Best')

% For max
mxmin = min(min(cimxM(:,[2 4 6])));
mxmax = max(max(cimxM(:,[2 4 6])));
xcenterV = linspace(mxmin,mxmax,nbin+1);
xcenterV = xcenterV(1:nbin)+0.5*(xcenterV(2)-xcenterV(1));
parNx = hist(cimxM(:,2),xcenterV);
bootNx = hist(cimxM(:,4),xcenterV);
boot2Nx = hist(cimxM(:,6),xcenterV);
figure(2)
clf
plot(xcenterV,parNx/M,'.-','linewidth',1.5)
hold on
plot(xcenterV,bootNx/M,'.-r','linewidth',1.5)
plot(xcenterV,boot2Nx/M,'.-g','linewidth',1.5)
xlabel('upper ci limit')
ylabel('relative frequency')
title(sprintf('M=%d, B=%d n=%d, upper limit of ci of mean',M,B,n))
legend('parametric','Perc.bootstrap','BiasCorr.bootstrap','Location','Best')

iparV = find(cimxM(:,1)<mu & cimxM(:,2)>mu);
ibootV = find(cimxM(:,3)<mu & cimxM(:,4)>mu);
iboot2V = find(cimxM(:,5)<mu & cimxM(:,6)>mu);
fprintf('Coverage probability of %1.2f%% parametric ci of mu=%1.2f= %1.3f \n',...
    (1-alpha)*100,mu,length(iparV)/M); 
fprintf('Coverage probability of %1.2f%% percentile bootstrap ci of mu=%1.2f= %1.3f \n',...
    (1-alpha)*100,mu,length(ibootV)/M); 
fprintf('Coverage probability of %1.2f%% bias corrected and accelerated percentile bootstrap ci of mu=%1.2f= %1.3f \n',...
    (1-alpha)*100,mu,length(iboot2V)/M); 


