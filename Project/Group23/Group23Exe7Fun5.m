function [md1,R2,adjR2] = Group23Exe7Fun5(Country,limits )
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % For stepwise regression
    n = limits(2)-limits(1)+1;
    limits=limits+10;
    X = zeros(n,21);
    for i=1:21
        X(:,i)=Country(1,limits(1)-i+1:limits(2)-i+1).';
    end
    Y=Country(2,limits(1):limits(2)).';

    md1=stepwiselm(X,Y);

    %Residuals
    adjR2=md1.Rsquared.Adjusted;
    R2=md1.Rsquared.Ordinary;
end

