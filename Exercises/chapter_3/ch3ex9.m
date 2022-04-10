M = 100;
conf = 0.95;
alpha = 1 - conf;
B = 1000;

n = 10;
muX = 0;
sigmaX = 1;
X = normrnd(muX, sigmaX, n, M);
meanX = mean(X);
varX = var(X);

m = 12;
muY = 0;
sigmaY = 1;
Y = normrnd(muY, sigmaY, m, M);
meanY = mean(Y);
varY = var(Y);

ciDiffmeanLower = zeros(M, 1);
ciDiffmeanUpper = zeros(M, 1);
temp1 = 0;
bootCIdiffmeanLower = zeros(M, 1);
bootCIdiffmeanUpper = zeros(M, 1);
temp2 = 0;
for i = 1:M
    Sp = sqrt( ((n-1)*varX(i) + (m-1)*varY(i))/(n+m-2) );
    ciDiffmeanLower(i) = (meanX(i) - meanY(i)) - tinv(1 - alpha/2, n+m-2)* Sp * sqrt(1/n + 1/m); 
    ciDiffmeanUpper(i) = (meanX(i) - meanY(i)) + tinv(1 - alpha/2, n+m-2)* Sp * sqrt(1/n + 1/m); 
    if ciDiffmeanLower(i)<0 && ciDiffmeanUpper(i)>0
        temp1 = temp1 + 1;
    end
    
    bootMeansX = bootstrp(B, @mean, X(:,i));
    bootMeansY = bootstrp(B, @mean, Y(:,i));
    bootDiffMeans = bootMeansX - bootMeansY;
    bootDiffMeans_sorted = sort(bootDiffMeans);
    bootCIdiffmeanLower(i) = bootDiffMeans_sorted(round((alpha/2)*B));
    bootCIdiffmeanUpper(i) = bootDiffMeans_sorted(round((1-(alpha/2))*B));
    if bootCIdiffmeanLower(i)<0 && bootCIdiffmeanUpper(i)>0
        temp2 = temp2 + 1;
    end
end
percentage1 = 1 - (temp1 / M);
percentage2 = 1 - (temp2 / M);

%***********************************************************************************************

% % Exercise 10 of Chp.3
% % Statistical test for equal means using percentile bootstrap and
% % random permutation (randomization) along with the parametric test.
% clear all
% n = 10;
% mux = 0;
% sigmax = 1;
% m = 10;
% muy = 0;
% sigmay = 1;
% M = 100;
% B = 1000;
% alpha = 0.05;
% dosquare = 0; % If 1, do square transform first
% nbin = 10;
% 
% % rng(1);
% % Generation of all M samples
% xM = mux*ones(n,M) + sigmax*ones(n,M).*randn(n,M);
% yM = muy*ones(m,M) + sigmay*ones(m,M).*randn(m,M);
% if dosquare
%     xM = xM.^2;
%     yM = yM.^2;
% end
% xmV = mean(xM)';
% xsdV = std(xM)';
% ymV = mean(yM)';
% ysdV = std(yM)';
% pvaldmxM = NaN(M,3); % the first column is for the p-values of the parametric
%                      % tests and the second for the bootstrap tests, and
%                      % the third for the randomization test
% klower = floor((B+1)*alpha/2);
% kup = B+1-klower;
% tailpercV = [klower kup]*100/B;
% tcrit = tinv(1-alpha/2,n+m-2);
% for iM = 1:M
%     %% Parametric hypothesis testing for mean difference
%     dmx = xmV(iM) - ymV(iM);
%     vardxt = (xsdV(iM)^2*(n-1)+ysdV(iM)^2*(m-1)) / (n+m-2);
%     sddxt = sqrt(vardxt);
%     tsample = dmx / (sddxt * sqrt(1/n+1/m));
%     pvaldmxM(iM,1) = 2*(1-tcdf(abs(tsample),n+m-2)); % p-value for two-sided test
%     %% Bootstrap hypothesis testing for mean difference
%     bootdmxV = NaN(B,1);
%     for iB=1:B
%         rV = unidrnd(n+m,n+m,1);
%         xyV = [xM(:,iM); yM(:,iM)];
%         xbV = xyV(rV(1:n));
%         ybV = xyV(rV(n+1:n+m));
%         bootdmxV(iB) = mean(xbV)-mean(ybV);
%     end
%     alldmxV = [dmx; bootdmxV];
%     [~,idmxV] = sort(alldmxV);
%     rankdmx0 = find(idmxV == 1);
%     % With the following, strange situations are handled, such as all
%     % statistics (original and bootstrap) are identical or there are
%     % bootstrap statistics identical to the original.
%     multipledmxV = find(alldmxV==alldmxV(1));
%     if length(multipledmxV)==B+1
%         rankdmx0=round(n/2); % If all identical give rank in the middle
%     elseif length(multipledmxV)>=2
%         irand = unidrnd(length(multipledmxV));
%         rankdmx0 = rankdmx0+irand-1; % If at least one bootstrap statistic 
%                % identical to the original pick the rank of one of them at
%                % random  
%     end
%     if rankdmx0 > 0.5*(B+1)
%         pvaldmxM(iM,2) = 2*(1-rankdmx0/(B+1));
%     else
%         pvaldmxM(iM,2) = 2*rankdmx0/(B+1);
%     end
%     %% Randomization hypothesis testing for mean difference
%     randdmxV = NaN(B,1);
%     for iB=1:B
%         rV = randperm(n+m);
%         xyV = [xM(:,iM); yM(:,iM)];
%         xbV = xyV(rV(1:n));
%         ybV = xyV(rV(n+1:n+m));
%         randdmxV(iB) = mean(xbV)-mean(ybV);
%     end
%     alldmxV = [dmx; randdmxV];
%     [~,idmxV] = sort(alldmxV);
%     rankdmx0 = find(idmxV == 1);
%     % With the following, strange situations are handled, such as all
%     % statistics (original and randomized) are identical or there are
%     % randomized statistics identical to the original.
%     multipledmxV = find(alldmxV==alldmxV(1));
%     if length(multipledmxV)==B+1
%         rankdmx0=round(n/2); % If all identical give rank in the middle
%     elseif length(multipledmxV)>=2
%         irand = unidrnd(length(multipledmxV));
%         rankdmx0 = rankdmx0+irand-1; % If at least one randstrap statistic 
%                % identical to the original pick the rank of one of them at
%                % random  
%     end
%     if rankdmx0 > 0.5*(B+1)
%         pvaldmxM(iM,3) = 2*(1-rankdmx0/(B+1));
%     else
%         pvaldmxM(iM,3) = 2*rankdmx0/(B+1);
%     end
% end
% % For min
% mxmin = min(min(pvaldmxM));
% mxmax = max(max(pvaldmxM));
% xcenterV = linspace(mxmin,mxmax,nbin+1);
% xcenterV = xcenterV(1:nbin)+0.5*(xcenterV(2)-xcenterV(1));
% parNx = hist(pvaldmxM(:,1),xcenterV);
% bootNx = hist(pvaldmxM(:,2),xcenterV);
% randNx = hist(pvaldmxM(:,3),xcenterV);
% figure(1)
% clf
% plot(xcenterV,parNx/M,'.-','linewidth',1.5)
% hold on
% plot(xcenterV,bootNx/M,'.-r','linewidth',1.5)
% plot(xcenterV,randNx/M,'.-c','linewidth',1.5)
% xlabel('p-value')
% ylabel('relative frequency')
% title(sprintf('M=%d, B=%d n=%d, p-value of test for mean difference',M,B,n))
% legend('parametric','bootstrap','randomization','Location','Best')
% 
% fprintf('Probability of rejection of equal mean at alpha=%1.3f, parametric = %1.3f \n',...
%     alpha,sum(pvaldmxM(:,1)<alpha)/M); 
% fprintf('Probability of rejection of equal mean at alpha=%1.3f, bootstrap = %1.3f \n',...
%     alpha,sum(pvaldmxM(:,2)<alpha)/M); 
% fprintf('Probability of rejection of equal mean at alpha=%1.3f, randomization = %1.3f \n',...
%     alpha,sum(pvaldmxM(:,3)<alpha)/M); 