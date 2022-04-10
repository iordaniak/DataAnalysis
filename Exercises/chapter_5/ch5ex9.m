% Exercise 5.9 - Anesthesiology unit and man-power
datdir = 'C:\MyFiles\Teach\DataAnalysis\Data\';
dattxt = 'hospital';
varnameM = str2mat('ManHours','Cases','Eligible','OpRooms');
alpha = 0.05;

datM = load([datdir,dattxt,'.dat']);
yV = datM(:,1);
xM = datM(:,2:end);
k = size(xM,2);
n = length(yV);
zcrit = norminv(1-alpha/2);

for i=1:k
    x1M = [ones(n,1) xM(:,i)];
    [b1V,b1int,stats1] = regress(yV,x1M);
    yhat1V = x1M * b1V;
    e1V = yV-yhat1V;
    se12 = (1/(n-2))*(sum(e1V.^2));
    se1 = sqrt(se12);
    my = mean(yV);
    R21 = 1-(sum(e1V.^2))/(sum((yV-my).^2));
    adjR21 =1-((n-1)/(n-2))*(sum(e1V.^2))/(sum((yV-my).^2));
    estar1V = e1V / se1;

    figure((i-1)*2+1)
    clf
    plot(xM(:,i),yV,'.')
    hold on
    plot(xM(:,i),yhat1V,'r')
    title(sprintf('x=%s, R^2=%1.5f adjR^2=%1.5f',deblank(varnameM(i+1,:)),R21,adjR21))
    
    figure(i*2)
    clf
    plot(yV,estar1V,'o')
    hold on
    ax = axis;
    plot([ax(1) ax(2)],[0 0],'k')
    plot([ax(1) ax(2)],zcrit*[1 1],'c--')
    plot([ax(1) ax(2)],-zcrit*[1 1],'c--')
    xlabel('y')
    ylabel('e^*')
    title(sprintf('diagnostic plot, x=%s',deblank(varnameM(i+1,:))));
    pause;
end

my = mean(yV);
xregM = [ones(n,1) xM];
[ballV,ballint,rall,rallint,statsall] = regress(yV,xregM);
yhatallV = xregM * ballV;
eallV = yV-yhatallV;
seall2 = (1/(n-(k+1)))*(sum(eallV.^2));
seall = sqrt(seall2);
R2all = 1-(sum(eallV.^2))/(sum((yV-my).^2));
adjR2all =1-((n-1)/(n-(k+1)))*(sum(eallV.^2))/(sum((yV-my).^2));
estarallV = eallV / seall;

disp(['n = ',int2str(n)])
disp([' '])
fprintf('FULL MODEL: \n');
fprintf('x-variable \t beta \t estimate \t 95%% CI \n');
fprintf('const \t beta0 \t %2.5f \t [%2.5f,%2.5f] \n',ballV(1),ballint(1,1),ballint(1,2));
for i=2:k+1
    fprintf('%s \t beta%d \t %2.5f \t [%2.5f,%2.5f] \n',deblank(varnameM(i,:)),...
        i-1,ballV(i),ballint(i,1),ballint(i,2));
end
disp(['residual variance=',num2str(seall2)])
disp(['residual SD=',num2str(seall)])
fprintf('R^2 = %1.5f   adjR^2=%1.5f \n',R2all,adjR2all);
fprintf('\n');

zcrit = norminv(1-alpha/2);
figure(k*2+1)
clf
% paperfigure
plot(yV,estarallV,'o')
hold on
ax = axis;
plot([ax(1) ax(2)],[0 0],'k')
plot([ax(1) ax(2)],zcrit*[1 1],'c--')
plot([ax(1) ax(2)],-zcrit*[1 1],'c--')
xlabel('y')
ylabel('e^*')
title('diagnostic plot, full model');

[bV,sdbV,pvalV,inmodel,stats]=stepwisefit(xM,yV);
b0 = stats.intercept;
indxV = find(inmodel==1);
yhatV = xregM * ([b0;bV].*[1 inmodel]');
eV = yV-yhatV;
k1 = sum(inmodel);
se2 = (1/(n-(k1+1)))*(sum(eV.^2));
se = sqrt(se2);
R2 = 1-(sum(eV.^2))/(sum((yV-my).^2));
adjR2 =1-((n-1)/(n-(k1+1)))*(sum(eV.^2))/(sum((yV-my).^2));
estarV = eV / se;

disp([' '])
fprintf('MODEL FROM STEPWISE REGRESSION: \n');
fprintf('x-variable \t beta \t estimate \t 95%% CI \n');
fprintf('const \t beta0 \t %2.5f \n',b0);
tcrit = tinv(1-alpha/2,n-(k1+1));
for i=1:k1
    fprintf('%s \t beta%d \t %2.5f \t [%2.5f,%2.5f] \n',deblank(varnameM(indxV(i),:)),...
        indxV(i),bV(indxV(i)),bV(indxV(i))-tcrit*sdbV(indxV(i)),...
        bV(indxV(i))+tcrit*sdbV(indxV(i)));
end
disp(['residual variance=',num2str(se2)])
disp(['residual SD=',num2str(se)])
fprintf('R^2 = %1.5f   adjR^2=%1.5f \n',R2,adjR2);

figure((k+1)*2)
clf
% paperfigure
plot(yV,estarV,'o')
hold on
ax = axis;
plot([ax(1) ax(2)],[0 0],'k')
plot([ax(1) ax(2)],zcrit*[1 1],'c--')
plot([ax(1) ax(2)],-zcrit*[1 1],'c--')
xlabel('y')
ylabel('e^*')
title('diagnostic plot, model from stepwise regression');

for i=1:k
    indxV = setdiff([1:k],i);
    xregM = [ones(n,1) xM(:,indxV)];
    [bcolV,bcolint,rcol,rcolint,statscol] = regress(xM(:,i),xregM);
    yhatcolV = xregM * bcolV;
    ecolV = xM(:,i)-yhatcolV;
    secol2 = (1/(n-k))*(sum(ecolV.^2));
    secol = sqrt(secol2);
    mxi = mean(xM(:,i));
    R2col = 1-(sum(ecolV.^2))/(sum((xM(:,i)-mxi).^2));
    adjR2col =1-((n-1)/(n-k))*(sum(ecolV.^2))/(sum((xM(:,i)-mxi).^2));
    estarcolV = ecolV / secol;
    
    disp([' '])
    fprintf('MODEL OF REGRESSION OF %s : \n',deblank(varnameM(i+1,:)));
    disp(['residual variance=',num2str(secol2)])
    disp(['residual SD=',num2str(secol)])
    fprintf('R^2 = %1.5f   adjR^2=%1.5f \n',R2col,adjR2col);
end

figure((k+1)*2+1)
clf
plotmatrix(xM);
