lowerPoint = 1;
upperPoint = 2;
%n = [10 100 1000 10000 100000];
n = 2.^(2:17)';
nn = length(n);
A = zeros(nn,1);
B = zeros(nn,1);
for i = 1:nn
    [A(i) B(i)] = ch2ex4func( lowerPoint, upperPoint, n(i) );
end

bar([A B])

%%***************************************************************************************************

% Exercise 4 of Chp.2
% Generation of uniform data and computation of the 1/E[x] and E[1/x].
a = -1; % The edges [a,b] of the interval for the uniform distribution
b = 1; % Try [a,b]=[1,2], [a,b]=[0,1], [a,b]=[-1,1], 
nV = 2.^(2:17)';

m = (a+b)/2; % The true mean
nn = length(nV);
mxM = NaN*ones(nn,2); % 1/E[x] and E[1/x] for each n in the two columns 
for in=1:nn
    n = nV(in);
    fprintf('%d.',n);
    xV = a + (b-a).*rand(n,1);
    mxM(in,1) = mean(1./xV);
    mxM(in,2) = 1/mean(xV);
end
fprintf('\n');
figure(1)
clf
plot(log2(nV),mxM(:,1),'.-k')
hold on
plot(log2(nV),mxM(:,2),'.-r')
plot([log(nV(1)) log(nV(nn))],(1/m)*[1 1],'--c')
legend('E[1/x]','1/E[x]')
xlabel('sample size 2^n')
ylabel('mean')
title(sprintf('Check whether E[1/x]=1/E[x], U[%1.2f,%1.2f]\n',a,b))