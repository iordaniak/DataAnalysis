M = 100;
n = 10000;
lamda = 10;
X = zeros(1, M);
X = ch3ex1func(M, n, lamda);
bins = 50;
hist(X, bins);