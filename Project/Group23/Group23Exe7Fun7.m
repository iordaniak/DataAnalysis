function [ adjR2_1,adjR2_2 ] = Group23Exe7Fun7( index,CountryName,Country,norm1,norm2,limits1,limits2)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % Multi-linear regression model
    limits1 = limits1 + 10;
    [md,~,adjR2_1] = Group23Exe7Fun4([norm1;Country(2,:)],limits1);
    
    %Prediction of second wave with 21-variable model
    X2 = zeros(limits2(2)-limits2(1)+1,21);
    for i=1:21
        X2(:,i)=norm2(1,limits2(1)-i+1:limits2(2)-i+1).';
    end
    pred = predict(md,X2);
    
    %AdjR2 for predicted values
    res = Country(2,limits2(1):limits2(2)).'-pred;
    muY = mean(Country(2,limits2(1):limits2(2)));
    n = limits2(2)-limits2(1);
    adjR2_2 = 1-((n-1)/(n-2))*(sum(res.^2))/(sum((Country(2,limits2(1):limits2(2))-muY).^2));
    figure(index)
    plot(limits2(1):limits2(2),pred,'*');
    hold on
    plot(limits2(1):limits2(2),Country(2,limits2(1):limits2(2)),'*','Color','r');
    legend('Prediction Values','Real Values')
    str = strcat(CountryName,' - 21 Variable Model');
    title(str);
    xlabel('Normalized Cases');
    ylabel('Deaths');
end

