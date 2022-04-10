% Exercise 3 of Chp.2
% Check that Var[x+y]=Var[x]+Var[y] does not hold when X,Y are correlated.
n = 10000;
muV = [0 0];
sigma1sq = 1;
sigma2sq = 1;
rho = 0.8;
bins = 20;

sigma12 = rho*sqrt(sigma1sq*sigma2sq);
covvarM = [sigma1sq sigma12; sigma12 sigma2sq];
xM = mvnrnd(muV,covvarM,n);
varxy = var(xM(:,1)+xM(:,2));
varx = var(xM(:,1));
vary = var(xM(:,2));
fprintf('\n');
fprintf('Var[X+Y]=%3.3f  Var[X]+Var[Y]=%3.3f+%3.3f=%3.3f \n',varxy,varx,...
    vary,varx+vary);
fprintf('Theoretical values (given Var[X]=%f, Var[Y]=%f, rho=%f): \n',...
    sigma1sq, sigma2sq, rho);
fprintf('1. Var[X] + Var[Y] = %f + %f = %f \n',sigma1sq, sigma2sq, ...
    sigma1sq + sigma2sq);
fprintf('2. Var[X+Y]  = Var[X] + Var[Y] + 2*Cov(X,Y) \n');
fprintf('   Var[X] + Var[Y] + 2*rho*sqrt(Var[X]Var[Y]) \n');
fprintf('   %f + %f + 2 x %f x %f x %f = %f \n',sigma1sq, sigma2sq, rho, ...
    sqrt(sigma1sq), sqrt(sigma2sq),sigma1sq+sigma2sq+2*sigma12);
