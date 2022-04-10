function [adjR2_1,adjR2_2] = Group23Exe8Fun2(index,CountryName,norm1,norm2,Country,limits1,limits2)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % For stepwise regression
    limits1=limits1+10;
    n1 = limits1(2)-limits1(1);

    X = zeros(n1+1,21);
    for i=1:21
        X(:,i)=norm1(1,limits1(1)-i+1:limits1(2)-i+1).';
    end
    Y = Country(2,limits1(1):limits1(2)).';

    md1 = stepwiselm(X,Y);

    % Calculating adjR2
    adjR2_1 = md1.Rsquared.Adjusted;

    % Prediction for 2nd wave with stepwise model
    n2 = limits2(2)-limits2(1);
    X2 = zeros(n2+1,21);
    for i = 1:21
        X2(:,i) = norm2(1,limits2(1)-i+1:limits2(2)-i+1).';
    end
    pred = predict(md1,X2);
    
    % AdjR2 for predicted values
    res = Country(2,limits2(1):limits2(2)).'-pred;
    muY = mean(Country(2,limits2(1):limits2(2)));
    adjR2_2 = 1-((n2-1)/(n2-2))*(sum(res.^2))/(sum((Country(2,limits2(1):limits2(2))-muY).^2));
    clc;
    % Graph
    figure(index)
    plot(limits2(1):limits2(2),pred,'*');
    hold on
    plot(limits2(1):limits2(2),Country(2,limits2(1):limits2(2)),'*','Color','r');
    legend('Prediction Values','Real Values')
    str = strcat(CountryName,' - StepWise Model');
    title(str);
    xlabel('Normalized Cases');
    ylabel('Deaths');
end
