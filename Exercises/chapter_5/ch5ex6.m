% Exercise 5.6 
data = [
2 98.2
3 91.7
8 81.3
16 64.0
32 36.4
48 32.6
64 17.1
80 11.3];
alpha = 0.05;
n = size(data,1);
X = data(:,1);
Y = data(:,2);
x0 = 25;

% Scatter plot of the raw data
figure(1)
clf
plot(X,Y,'o')
xlabel('km driven (in thousands)')
ylabel('percentage usable')

% Linear regression line on the raw data
Xones = [ones(n,1) X];
[bV, bint, r, rint, stats] = regress(Y,Xones);
Yhat = Xones * bV;
muY = mean(Y);
e = Y-Yhat;
R2 = 1-(sum(e.^2))/(sum((Y-muY).^2));
adjR2 =1-((n-1)/(n-2))*(sum(e.^2))/(sum((Y-muY).^2));
%pause;

figure(1)
hold on
plot(X,Yhat,'r')
ax = axis;
text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.2*(ax(4)-ax(3)),['R^2=',...
    num2str(R2,3)])
text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.1*(ax(4)-ax(3)),['adjR^2=',...
    num2str(adjR2,3)])
%pause;

% Diagnostic plot: residuals vs response (dependent variable)
se2 = (1/(n-1))*(sum((Y-Yhat).^2));
se = sqrt(se2);
estarV = e ./ se;
figure(2)
clf
plot(Y,estarV,'*')
hold on
ax = axis;
plot(xlim,[0 0]);
plot([ax(1) ax(2)],norminv(1-alpha/2)*[1 1],'c--')
plot([ax(1) ax(2)],-norminv(1-alpha/2)*[1 1],'c--')
xlabel('percentage usable')
ylabel('residuals of linear regression')
%pause;

% Ln-transform of the response and then linear regression 
Y_ln = log(Y);
[blV_ln, blnint,r,rint,stats] = regress(Y_ln,Xones);
Y_lnhat = Xones * blV_ln;
muY_ln = mean(Y_ln);
e_ln = Y_ln-Y_lnhat;
R2_ln = 1-(sum(e_ln.^2))/(sum((Y_ln-muY_ln).^2));
adjR2_ln =1-((n-1)/(n-2))*(sum(e_ln.^2))/(sum((Y_ln-muY_ln).^2));

% Scatter plot of the ln of response vs independent variable
figure(3)
clf
plot(X,Y_ln,'.')
xlabel('km driven (in thousands)')
ylabel('ln of percentage usable')
hold on
%pause;
plot(X,Y_lnhat,'r')
ax = axis;
text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.2*(ax(4)-ax(3)),['R^2(ln(y))=',...
    num2str(R2_ln,3)])
text(ax(1)+0.3*(ax(2)-ax(1)),ax(3)+0.1*(ax(4)-ax(3)),['adjR^2(ln(y))=',...
    num2str(adjR2_ln,3)])
if blV_ln(2)<0
    modtxt = sprintf('ln(y) = %2.2f - %2.2f x',blV_ln(1),abs(blV_ln(2))); 
else
    modtxt = sprintf('ln(y) = %2.2f + %2.2f x',blV_ln(1),abs(blV_ln(2))); 
end
ax = axis;
text(ax(2)-0.05*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)),modtxt,...
    'Horizontalalignment','Right')
%pause;

% Diagnostic plot: residuals vs ln of response
e_ln = Y_ln - Y_lnhat;
vareln = ((n-1)/(n-2))*(var(Y_ln)-blV_ln(2)^2*var(X));
sdeln = sqrt(vareln);
elnstarV = e_ln ./ sdeln;
figure(4)
clf
plot(Y_ln,elnstarV,'o')
hold on
ax = axis;
plot([ax(1) ax(2)],norminv(1-alpha/2)*[1 1],'c--')
plot([ax(1) ax(2)],-norminv(1-alpha/2)*[1 1],'c--')
xlabel('ln of percentage usable')
ylabel('residuals of linear (ln) regression')
%pause;

% The exponential fit on the raw data
b0_exp = exp(blV_ln(1));
Xgrid = linspace(min(X),max(X),1000);
Ygrid_exp = b0_exp * exp(blV_ln(2)*Xgrid);
Yhat_exp = b0_exp * exp(blV_ln(2)*X);
muY = mean(Y);
e_exp = Y-Yhat_exp;
R2_exp = 1-(sum(e_exp.^2))/(sum((Y-muY).^2));
adjR2_exp =1-((n-1)/(n-2))*(sum(e_exp.^2))/(sum((Y-muY).^2));

figure(1)
plot(Xgrid,Ygrid_exp,'r','linewidth',2)
modtxt = sprintf('y = %2.2f e^{%2.2f x}',b0_exp,blV_ln(2)); 
ax = axis;
text(ax(2)-0.05*(ax(2)-ax(1)),ax(4)-0.15*(ax(4)-ax(3)),modtxt,...
    'Horizontalalignment','Right')
%pause;
y0 = b0_exp*exp(blV_ln(2)*x0);
plot(x0*[1 1],[ax(3) y0],'b--')
plot([ax(1) x0],y0*[1 1],'b--')
text(ax(1)+0.4*(ax(2)-ax(1)),ax(3)+0.6*(ax(4)-ax(3)),['R^2(exp(y))=',...
    num2str(R2_exp,3)])
text(ax(1)+0.4*(ax(2)-ax(1)),ax(3)+0.5*(ax(4)-ax(3)),['adjR^2(exp(y))=',...
    num2str(adjR2_exp,3)])