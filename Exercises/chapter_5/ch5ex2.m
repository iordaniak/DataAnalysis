L = 1000;
n = 20;
alpha = 0.05;
muX = 0;
muY = 0;
sigmaX = 1;
sigmaY = 1;
rho = 0;
sigmaXY = rho * sigmaX * sigmaY;
covMatrix = [sigmaX^2 sigmaXY; sigmaXY sigmaY^2];
muMatrix = [muX muY];
XY = mvnrnd(muMatrix, covMatrix, n);
Y = XY(:,2);
X = XY(:,1);

rTemp = corrcoef(XY);
r = rTemp(1,2);
t0 = r * sqrt((n-2)/(1-r^2));

XL = zeros(n, L);
tL = zeros(L, 1);
for i = 1:L
    R = randperm(n);
    XL(:,i) = X(R);
    rTemp = corrcoef([XL(:,i) Y]);
    rL = rTemp(1,2);
    tL(i) = rL * sqrt((n-2)/(1-rL^2));
end
h=1;
tLsorted = sort(tL);
tLower = tLsorted((alpha/2)*L);
tUpper = tLsorted((1-alpha/2)*L);
if t0>tLower && t0<tUpper
    h = 0;
end
h

    

%*******************************************************************************


% % Exercise 5.2
% rho = 0.0; % 0.0, 0.5
% n = 20;
% M = 100;
% L = 1000;
% muxV = [0 0]';
% sdxV = [1 1]';
% bins = round(sqrt(M));
% binsL = round(sqrt(L));
% alpha = 0.05;
% ploteach = 0;
% 
% % randn('state',0);
% % rand('state',0);
% 
% rM = NaN*ones(L+1,M);
% for i=1:M
%     if mod(i,50)==1
%         fprintf('\n %d',i);
%     else
%         fprintf('.');
%     end
%     xM = mvnrnd(muxV',[sdxV(1)^2 rho; rho sdxV(2)^2],n);
%     xM = xM.^2;
%     tmpM=corrcoef(xM);
%     rM(1,i) = tmpM(1,2);
%     for j=1:L
%         zM = [xM(:,1) xM(randperm(n),2)];
%         tmpM=corrcoef(zM);
%         rM(1+j,i) = tmpM(1,2);
%     end
%     if ploteach
%         figure(1)
%         clf
%         hist(rM(2:L+1,i),binsL)
%         hold on
%         ax = axis;
%         plot(rM(1,i)*[1 1],[ax(3) ax(4)],'r')
%         xlabel('r')
%         ylabel('counts')
%         title(sprintf('rho=%1.2f n=%d L=%d r-randomized-histogram',rho,n,L))
%         pause;
%     end
% end
% fprintf('\n');
% % hypothesis test for H0: rho=0 using directly the r-statistic
% orM=sort(rM(2:L+1,:));
% lowlim = round((alpha/2)*L);
% upplim = round((1-alpha/2)*L); 
% rlV = orM(lowlim,:); 
% ruV = orM(upplim,:); 
% nrrej = length(find(rM(1,:)-rlV<0 | rM(1,:)-ruV>0));
% prrej = nrrej/M;
% % hypothesis test for H0: rho=0 using the t-statistic
% tM = rM.*sqrt((n-2)./(1-rM.^2));
% otM=sort(tM(2:L+1,:));
% lowlim = round((alpha/2)*L);
% upplim = round((1-alpha/2)*L);
% tlV = otM(lowlim,:); 
% tuV = otM(upplim,:);
% ntrej = length(find(tM(1,:)-tlV<0 | tM(1,:)-tuV>0));
% ptrej = ntrej/M;
% tcrit = tinv(1-alpha/2,n-2);
% 
% figure(1)
% clf
% hist(rM(1,:),bins)
% hold on
% ax = axis;
% plot(rho*[1 1],[ax(3) ax(4)],'r')
% xlabel('r')
% ylabel('counts')
% title(sprintf('rho=%1.2f n=%d M=%d L=%d alpha=%1.2f r-histogram',rho,n,...
%     M,L,alpha))
% % CI
% figure(2)
% clf
% hist(tlV,bins)
% hold on
% ax = axis;
% plot(-tcrit*[1 1],[ax(3) ax(4)],'r')
% xlabel('lower t')
% ylabel('counts')
% rholow = length(find(tM(1,:)-tlV<0));
% title(sprintf('rho=%1.2f n=%d M=%d L=%d alpha=%1.2f R p(rho<r_l)=%d/%d',rho,n,...
%     M,L,alpha,rholow,M))
% figure(3)
% clf
% hist(tuV,bins)
% hold on
% ax = axis;
% plot(tcrit*[1 1],[ax(3) ax(4)],'r')
% xlabel('upper t')
% ylabel('counts')
% rhoupp = length(find(tM(1,:)-tuV>0));
% title(sprintf('rho=%1.2f n=%d M=%d L=%d alpha=%1.2f R p(rho>r_u)=%d/%d',rho,n,...
%     M,L,alpha,rhoupp,M))
% % H0
% fprintf('rho=%1.2f n=%d M=%d L=%d alpha=%1.2f randomization test for H0:rho=0\n',rho,n,M,L,alpha);
% fprintf('percentage of rejection using r-statistic=%1.4f \n',prrej);
% fprintf('percentage of rejection using t-statistic=%1.4f \n',ptrej);
%  