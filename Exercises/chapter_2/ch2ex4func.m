function [A, B] = ch2ex4func( lowerPoint, upperPoint, n )
    X = unifrnd(lowerPoint, upperPoint, n, 1);

    A = mean(1./X);
    B = 1/mean(X);
end

