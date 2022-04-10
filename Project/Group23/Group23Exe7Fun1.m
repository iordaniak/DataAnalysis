function [ adjR2_1,adjR2_2 ] = Group23Exe7Fun1(  index,CountryName,Country,norm1,norm2,limits1,limits2 )
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % Stepwise Model
    [md,~,adjR2_1] = Group23Exe7Fun5([norm1;Country(2,:)],limits1);
    clc;
 
    %Prediction of second wave with stepwise model
    X2=zeros(limits2(2)-limits2(1)+1,21);
    for i=1:21
        X2(:,i)=norm2(1,limits2(1)-i+1:limits2(2)-i+1).';
    end
    pred = predict(md,X2);
    
    %AdjR2 for predicted Values
    res = Country(2,limits2(1):limits2(2)).'-pred;
    muY = mean(Country(2,limits2(1):limits2(2)));
    n = limits2(2)-limits2(1);
    adjR2_2 = 1-((n-1)/(n-2))*(sum(res.^2))/(sum((Country(2,limits2(1):limits2(2))-muY).^2));
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

