function [ adjR2_1,adjR2_2 ] = Group23Exe8Fun1( index,CountryName,norm1,norm2,Country,limits1,limits2 )
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492

    limits1=limits1+10;
    n2 = limits2(2)- limits2(1);
    X2 = zeros(n2+1,21);
    for i=1:21
        X2(:,i) = norm2(1,limits2(1)-i+1:limits2(2)-i+1).';
    end
    Y2 = Country(2,limits2(1):limits2(2)).';
    
    n1 = limits1(2)-limits1(1);
    X = zeros(n1+1,21);
    for i = 1:21
        X(:,i) = norm1(1,limits1(1)-i+1:limits1(2)-i+1).';
    end
    Y = Country(2,limits1(1):limits1(2)).';

    [~,~,~,~,BETA,~,~,~] = plsregress(X,Y,10);
    % Prediction with PLS for First Wave
    yfit1 = [ones(size(X,1),1) X]*BETA;
    res1 = Y - yfit1;
    muY = mean(Country(2,limits1(1):limits1(2)));
    n1 = limits1(2)-limits1(1);
    adjR2_1 = 1-((n1-1)/(n1-2))*(sum(res1.^2))/(sum((Country(2,limits1(1):limits1(2))-muY).^2));

    % Prediction with PLS for second wave
    yfit2 = [ones(size(X2,1),1) X2]*BETA;
    res2 = Y2-yfit2;
    muY = mean(Country(2,limits2(1):limits2(2)));
    n2 = limits2(2)-limits2(1);
    adjR2_2 = 1-((n2-1)/(n2-2))*(sum(res2.^2))/(sum((Country(2,limits2(1):limits2(2))-muY).^2));
    clc;
    %Graph
    figure(index)
    plot(limits2(1):limits2(2),yfit2,'*');
    hold on
    plot(limits2(1):limits2(2),Country(2,limits2(1):limits2(2)),'*','Color','r');
    legend('Prediction Values','Real Values')
    str = strcat(CountryName,' - PLS Model');
    title(str)
    xlabel('Normalized Cases');
    ylabel('Deaths');
end

