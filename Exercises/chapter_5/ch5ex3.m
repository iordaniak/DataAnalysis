datdir = 'C:\Users\konst\Documents\MATLAB\chapter_5\';
dat1txt = 'rain_3';
dat2txt = 'temperature_3';

X = load([datdir,dat1txt,'.txt']);
Y = load([datdir,dat2txt,'.txt']);

n = length(X(:,1));
m = length(X(1,:));


%*********************************************************************************


% % Exercise 5.3
% datdir = 'c:\MyFiles\Teach\DataAnalysis\Data\';
% dat1txt = 'rainThes59_97';
% dat2txt = 'tempThes59_97';
% L = 1000;
% binsL = round(sqrt(L));
% alpha = 0.05;
% ploteach = 1;
% 
% x1M = load([datdir,dat1txt,'.dat'])
% x2M = load([datdir,dat2txt,'.dat'])
% [n,m]=size(x1M);
% 
% lowlim = round((alpha/2)*L);
% upplim = round((1-alpha/2)*L);
% tcrit = tinv(1-alpha/2,n-2);
% for i=1:m
%     xM = [x1M(:,i) x2M(:,i)];
%     tmpM=corrcoef(xM);
%     r = tmpM(1,2);
%     rV = NaN*ones(L,1);
%     for j=1:L
%         zM = [xM(:,1) xM(randperm(n),2)];
%         tmpM=corrcoef(zM);
%         rV(j) = tmpM(1,2);
%     end
%     t = r*sqrt((n-2)/(1-r^2));
%     tV = rV.*sqrt((n-2)./(1-rV.^2));
%     otV=sort(tV);
%     tl = otV(lowlim); 
%     tu = otV(upplim);
%     fprintf('--- Month %d \n',i);
%     if abs(t)>tcrit
%         fprintf(' parametric test (alpha=0.05): abs(t-statistic)=%2.3f > %1.3f -> reject H0 \n',abs(t),tcrit);
%     else
%         fprintf(' parametric test (alpha=0.05): abs(t-statistic)=%2.3f < %1.3f -> no reject H0 \n',abs(t),tcrit);
%     end
%     if t<tl | t>tu
%         fprintf(' randomization test (alpha): t-statistic=%2.3f not in [%1.3f,%1.3f] -> reject H0 \n',t,tl,tu);
%     else
%         fprintf(' randomization test (alpha): t-statistic=%2.3f in [%1.3f,%1.3f] -> no reject H0 \n',t,tl,tu);
%     end    
%     if ploteach
%         figure(1)
%         clf
%         hist(rV,binsL)
%         hold on
%         ax = axis;
%         plot(r*[1 1],[ax(3) ax(4)],'r')
%         plot([0 0],[ax(3) ax(4)],'y')
%         xlabel('r')
%         ylabel('counts')
%         title(sprintf('n=%d L=%d r-randomized-histogram for month %d',n,L,i))
%         pause;
%     end
% end