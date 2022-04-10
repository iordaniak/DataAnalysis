
function [ index ] = Group23Exe3Fun1 ( CasesOrDeaths, Distribution )

    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % The purpose of this function is to predict the peak of the first wave
    % cases/deaths. To do so it fits the best fitting distribution that was 
    % found in the previous exercise which is given as input. It then finds
    % the maximum value, of this distribution, and returns its index
   
    x = 1:length(CasesOrDeaths);

    pd = fitdist(x.', Distribution, 'Frequency', CasesOrDeaths);
    y = pdf(pd, x);
    max = y(1);
    index = 1;
    for i = 1:length(y)
        if y(i) > max
            max = y(i);
            index = i;
        end
    end
end

