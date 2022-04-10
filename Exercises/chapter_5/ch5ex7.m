% Exercise 5.7 
data = [
1 0.76 110
2 0.86 105
3 0.97 100
4 1.11 95
5 1.45 85
6 1.67 80
7 1.92 75
8 2.23 70
9 2.59 65
10 3.02 60
11 3.54 55
12 4.16 50
13 4.91 45
14 5.83 40
15 6.94 35
16 8.31 30
17 10.00 25
18 12.09 20
19 14.68 15
20 17.96 10
21 22.05 5
22 27.28 0
23 33.89 -5
24 42.45 -10
25 53.39 -15
26 67.74 -20
27 86.39 -25
28 111.30 -30
29 144.00 -35
30 188.40 -40
31 247.50 -45
32 329.20 -50 
];
kmax = 3; % the degree of the polynomial regression
alpha = 0.05;
nresol = 1000;

X = log(data(:,2));
Y = 1./(273.15 + data(:,3));
n = length(X);

XY = sortrows([X Y]);
X = XY(:,1);
Y = XY(:,2);

Xmin = min(X);
Xmax = max(X);
Xgrid = (linspace(Xmin,Xmax,nresol))';
zcrit = norminv(1-alpha/2);
for k=1:kmax
    switch k
        case 1
            data = [ones(n,1) X];
            xgridM = [ones(nresol,1) Xgrid];
        case 2
            data = [ones(n,1) X X.^2];
            xgridM = [ones(nresol,1) Xgrid Xgrid.^2];
        case 3
            data = [ones(n,1) X X.^2 X.^3];
            xgridM = [ones(nresol,1) Xgrid Xgrid.^2 Xgrid.^3];
        case 4
            data = [ones(n,1) X X.^2 X.^3 X.^4];
            xgridM = [ones(nresol,1) Xgrid Xgrid.^2 Xgrid.^3 Xgrid.^4];
    end
    [bV, bint,r,rint,stats] = regress(Y,data);
    Yhat = data * bV;
    Ygrid = xgridM * bV;
    Se2 = (1/(n-(k+1)))*(sum((Y-Yhat).^2));
    Se = sqrt(Se2);
    muY = mean(Y);
    e = Y-Yhat;
    estarV = e ./ Se;
    R2 = 1-(sum(e.^2))/(sum((Y-muY).^2));
    adjR2 =1-((n-1)/(n-(k+1)))*(sum(e.^2))/(sum((Y-muY).^2));
    
    figure(2*(k-1)+1)
    clf
    % paperfigure
    plot(X,Y,'k.','Markersize',10)
    hold on
    plot(Xgrid,Ygrid)
    ax = axis;
    xlabel('ln(R)')
    ylabel('1/T [^oK]')
    text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.2*(ax(4)-ax(3)),['R^2=',...
        num2str(R2,6)])
    text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.1*(ax(4)-ax(3)),['adjR^2=',...
        num2str(adjR2,6)])
    title(sprintf('Polynomial degree=%d',k))
    %pause;
    
    figure(2*k)
    clf
    % paperfigure
    plot(Y,estarV,'ko')
    hold on
    ax = axis;
    plot([ax(1) ax(2)],zcrit*[1 1], 'c--')
    plot([ax(1) ax(2)],-zcrit*[1 1], 'c--')
    xlabel('1/T')
    ylabel('e^*')
    title(sprintf('Polynomial degree=%d',k))
    %pause;
    
    fprintf('=== Polynomial degree=%d \n \t coefficients: \n',k);
    for i=1:k+1
        fprintf('b_%d = %1.10f \n',i-1,bV(i));
    end
    %pause;
end

% Steinhart-Hart's model
data = [ones(n,1) X X.^3];
xgridM = [ones(nresol,1) Xgrid Xgrid.^3];

[bV, bint,r,rint,stats] = regress(Y,data);
Yhat = data * bV;
Ygrid = xgridM * bV;
Se2 = (1/(n-(k+1)))*(sum((Y-Yhat).^2));
Se = sqrt(Se2);
muY = mean(Y);
e = Y-Yhat;
estarV = e ./ Se;
R2 = 1-(sum(e.^2))/(sum((Y-muY).^2));
adjR2 =1-((n-1)/(n-(k+1)))*(sum(e.^2))/(sum((Y-muY).^2));

figure(2*k+1)
clf
% paperfigure
plot(X,Y,'k.','Markersize',10)
hold on
plot(Xgrid,Ygrid)
ax = axis;
xlabel('ln(R)')
ylabel('1/T [^oK]')
text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.2*(ax(4)-ax(3)),['R^2=',...
    num2str(R2,6)])
text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.1*(ax(4)-ax(3)),['adjR^2=',...
    num2str(adjR2,6)])
title('Steinhart-Hart model')
%pause;

figure(2*(k+1))
clf
% paperfigure
plot(Y,estarV,'ko')
hold on
ax = axis;
plot([ax(1) ax(2)],zcrit*[1 1], 'c--')
plot([ax(1) ax(2)],-zcrit*[1 1], 'c--')
xlabel('1/T')
ylabel('e^*')
title('Steinhart-Hart model')
%pause;

fprintf('=== Steinhart-Hart model \n \t coefficients: \n');
fprintf('b_0 = %1.10f \n',bV(1));
fprintf('b_1 = %1.10f \n',bV(2));
fprintf('b_3 = %1.10f \n',bV(3));



%*********************************************************************************************************


% % Data Analysis 2020
% % Chapter 5 Excerise 7
% % Polynomial regression
% % Nick Kaparinos
% close all;
% clc;
% clear;
% data = [
% 1 0.76 110
% 2 0.86 105
% 3 0.97 100
% 4 1.11 95
% 5 1.45 85
% 6 1.67 80
% 7 1.92 75
% 8 2.23 70
% 9 2.59 65
% 10 3.02 60
% 11 3.54 55
% 12 4.16 50
% 13 4.91 45
% 14 5.83 40
% 15 6.94 35
% 16 8.31 30
% 17 10.00 25
% 18 12.09 20
% 19 14.68 15
% 20 17.96 10
% 21 22.05 5
% 22 27.28 0
% 23 33.89 -5
% 24 42.45 -10
% 25 53.39 -15
% 26 67.74 -20
% 27 86.39 -25
% 28 111.30 -30
% 29 144.00 -35
% 30 188.40 -40
% 31 247.50 -45
% 32 329.20 -50 
% ];
% 
% X = data(:,2);
% Y = data(:,3);
% 
% X = log(X);
% Y = (Y + 273).^-1;
% 
% % Scatterplot
% figure(100);
% scatter(X,Y);
% xlabel('ln(R)');
% ylabel('1/T');
% 
% % A
% k = 4;
% R2 = zeros(k+1,1);
% AdjustedR2 = zeros(k+1,1);
% maxAdjR2 = zeros(2,1);
% 
% % R2 and adjusted R2
% Rsq = @(ypred,y) 1-sum((ypred-y).^2)/sum((y-mean(y)).^2);
% adjRsq = @(ypred,y,n,k) ( 1 - (n-1)/(n-1-k)*sum((ypred-y).^2)/sum((y-mean(y)).^2) );
% rmse = @(residuals, n, dof) ( sqrt( 1/(n-dof) * sum(residuals.^2) ));
% 
% 
% for i = 1:k
%     % Polynomial regression
%     b = polyfit(X,Y,i);
%     Ypred = polyval(b,X);
%     
%     % Calculate R2 and find the max
%     R2(i) = Rsq(Ypred,Y);
%     AdjustedR2(i) = adjRsq(Ypred,Y,length(Y),i);
%     if(AdjustedR2(i) > maxAdjR2(1))
%         maxAdjR2(1) = AdjustedR2(i);
%         maxAdjR2(2) = i;
%     end
%     
%     % Plot Regression
%     figure(2*i);
%     scatter(X,Y);
%     hold on;
%     plot(X,Ypred);
%     title('Data and regression, k =  ' + i);
%     xlabel('ln(R)');
%     ylabel('1/T');
%     
%     % Diagnostic plot
%     residuals = Y - Ypred;
%     se = sqrt( 1/(length(X)-k-1) * (sum(residuals.^2)));
%     figure(2*i+1)
%     scatter(Y,residuals./se);
%     hold on;
%     plot(Y,repmat(2,1,length(Y)));
%     plot(Y,zeros(1,length(Y)));
%     plot(Y,repmat(-2,1,length(Y)));
%     title('Diagnostic plot, k = ' + i);
%     xlabel('1/T');
%     ylabel('Standardised Error');
% 
% end
% 
% % Steinhart-Hart
% k = 2;
% Xinput = [ones(length(X),1) X X.^3];
% fetModel = fitlm(Xinput,Y);
% b = regress(Y,Xinput);
% Ypred = Xinput*b;
% 
% fetRmse = rmse(fetModel.Residuals.Raw, length(X),3);
% 
% R2(i+1) = Rsq(Ypred,Y);
% AdjustedR2(i+1) = adjRsq(Ypred,Y,length(Y),3);
% 
% % Plot Regression
% figure(2*(i+1));
% scatter(X,Ypred);
% hold on;
% plot(X,Ypred);
% title('Data and Steinhart-Hart regression');
% xlabel('ln(R)');
% ylabel('1/T');
% 
% % Diagnostic plot
% residuals = Y - Ypred;
% se = sqrt( 1/(length(X)-1) * (sum(residuals.^2)));
% figure(2*(i+1)+1)
% fet2 = residuals./fetModel.RMSE;
% scatter(Y,residuals./se);
% hold on;
% plot(Y,repmat(2,1,length(Y)));
% plot(Y,zeros(1,length(Y)));
% plot(Y,repmat(-2,1,length(Y)));
% title('Diagnostic plot, Steinhart-Hart');
% xlabel('1/T');
% ylabel('Standardised Error');
% 
% if( maxAdjR2 > AdjustedR2(end) )
%     disp('Polynomial regression is better');
% end