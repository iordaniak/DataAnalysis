function [ meansArray ] = ch3ex1func( M , n , lamda )
    matrix = poissrnd(lamda, n, M);
    meansArray = mean(matrix);
end

