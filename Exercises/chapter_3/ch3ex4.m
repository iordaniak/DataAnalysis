sample = importdata('sample.txt');
n = length(sample);
conf = 0.95;
alpha = 1 - conf;
sampleVariance = var(sample);
sampleMean = mean(sample);

confIntervalVar_Lower = ((n - 1) * sampleVariance) / chi2inv(1 - (alpha/2), n - 1);
confIntervalVar_Upper = ((n - 1) * sampleVariance) / chi2inv(alpha/2, n - 1);
fprintf('\n(a) Confidence Interval of Variance is [ %2.3f , %2.3f ] \n', confIntervalVar_Lower, confIntervalVar_Upper);

givenStd = 5;
[h,pvar,civarV] = vartest(sample, givenStd^2, alpha);
fprintf('\n(b) The p-Value for standar deviation = %1.5f\n', pvar);
fprintf('\tConfidence interval calculated by vartest: [%2.3f, %2.3f]\n', civarV(1), civarV(2));

confIntervalMean_Lower = sampleMean - tinv(1 - alpha/2, n - 1) * sqrt(sampleVariance / n);
confIntervalMean_Upper = sampleMean + tinv(1 - alpha/2, n - 1) * sqrt(sampleVariance / n);
fprintf('\n(c) Confidence Interval of Mean is [ %2.3f , %2.3f ] \n', confIntervalMean_Lower, confIntervalMean_Upper);

givenMean = 52;
statcontrol2 = (sampleMean - givenMean)/ sqrt(sampleVariance / n);
pValue2 = 2 - 2 * tcdf(abs(statcontrol2), n-1);
fprintf('\n(d) The p-Value for mean = %1.5f\n', pValue2);

[h,p] = chi2gof(sample);
fprintf('\n(e) The p-value for fit of goodness is: %1.5f\n', p);


%********************************************************************************

% Exercise 3.4
% Data from dropout voltage in an electric circuit.
% Estimation and hypothesis testing on mean, variance and hypothesis
% testing for goodness of fit to normal distribution.
datdir = 'C:\Users\konst\Documents\MATLAB\chapter_3\';
dattxt = 'sample';
sigma0 = 5;
varalpha = 0.05;
mu0 = 52;
mualpha = 0.05;
tittxt = 'dropout voltage';

eval(['load ',datdir,dattxt,'.txt'])
eval(['xV = ',dattxt,';'])
n = length(xV);
nbin = round(sqrt(n));
figure(1)
clf
histfit(xV,nbin)
xlabel('x')
ylabel('counts')
title(sprintf('%s: n=%d ',tittxt,n))
figure(2)
clf
boxplot(xV)
title(sprintf('%s: n=%d ',tittxt,n))

% (a) and (b)
[h,pvar,civarV]=vartest(xV,sigma0^2,varalpha);
fprintf('---- 3.4 (a) ----- \n');
fprintf('CI for var(X)=[%2.3f,%2.3f] \n',civarV(1),civarV(2));
fprintf('CI for sigma(X)=[%2.3f,%2.3f] \n',sqrt(civarV(1)),sqrt(civarV(2)));
fprintf('---- 3.4 (b) ----- \n');
fprintf('p-value (for H:sigma=%2.2f) = %1.5f \n',sigma0,pvar);
% (c) and (d)
[h,pmu,cimuV]=ttest(xV,mu0,mualpha);
fprintf('---- 3.4 (c) ----- \n');
fprintf('CI for mu(X)=[%2.3f,%2.3f] \n',cimuV(1),cimuV(2));
fprintf('---- 3.4 (d) ----- \n');
fprintf('p-value (for H:mu=%2.2f) = %1.5f \n',mu0,pmu);
% (e)
% [h,pgof,gofstats]=chi2gof(xV,'nbins',nbin)
[h,pgof,gofstats]=chi2gof(xV);
fprintf('---- 3.4 (e) ----- \n');
fprintf('p-value (for H:normal fit) = %1.5f \n',pgof);
fprintf('\t observed \t expected frequencies \n');
Kc = length(gofstats.O);
for i=1:Kc
    fprintf('\t %3.3f \t %3.3f \n',gofstats.O(i),gofstats.E(i));
end
