% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

load('data.mat')
load('limits.mat')
import java.util.Stack

% Fixing Spain's data
stack = Stack();
Spain = Group23Exe1Fun1(Spain,stack);

% Selecting a number of European countries (from previously)
nCountries = 14;
countries = {'UnitedKingdom';'Croatia';'Czechia';'Denmark';'Italy';'France';'Germany';
             'Sweden';'Switzerland';'Austria';'Romania';'Norway';'Netherlands';'Spain'};
limits = [limitsUnitedKingdom;limitsCroatia;limitsCzechia;limitsDenmark;limitsItaly;limitsFrance;limitsGermany;
          limitsSweden;limitsSwitzerland;limitsAustria;limitsRomania;limitsNorway;limitsNetherlands;limitsSpain;];
      
% Finding the maximum value of the fitting distribution of each country for
% both cases and deaths.(more details in function: Group23Exe3Fun2)
maxCases = zeros(1,nCountries);
maxDeaths = zeros(1,nCountries);
for i = 1:nCountries
    country = eval(countries{i});
    maxCases(i) = Group23Exe3Fun1(country(1,limits(i,1):limits(i,2)), 'Loglogistic');
    maxDeaths(i) = Group23Exe3Fun1( country(2,limits(i,1):limits(i,2)), 'Lognormal');
end
% Calculating the differences(in number of days) between the peaks of cases-deaths
differences = maxDeaths - maxCases;

% 95% parametric confidence interval of mean
conf = 0.95;
alpha = 1 - conf;
n = length(differences);
ciMeanLower = mean(differences) - tinv(1 -alpha/2, n-1) * (std(differences)/sqrt(n));
ciMeanUpper = mean(differences) + tinv(1 -alpha/2, n-1) * (std(differences)/sqrt(n));

% Bootstrap confidence interval of mean
B = 1000;
bootCI = bootci(B, @mean, differences);

% Hypothesis testing that the mean of differences is 14
givenMean = 14;
[h, pValue, ciMean] = ttest(differences, givenMean, alpha);

% Printing the results
fprintf('\n\t ~ Confidence Interval of mean is [%2.3f , %2.3f] \n', ciMeanLower, ciMeanUpper);
fprintf('\n\t ~ Bootstrap confidence Interval of mean is [%2.3f , %2.3f] \n', bootCI(1),bootCI(2));
fprintf('\n\t ~ The null hypothesis, that the deaths'' peak is 14 days delayed, is rejected');
fprintf('\n\t   at 5%% significance level as it returned p-Value= %f  (<0.05)\n\n',pValue);