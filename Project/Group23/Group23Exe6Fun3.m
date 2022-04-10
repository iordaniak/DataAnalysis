function [md1,R2,adjR2] = Group23Exe6Fun3(index,Country,limits)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % To decrease the number of indepedent variables we chose the stepwise
    % regression
    
    % Stepwise regression
    n = limits(2)-limits(1)+1;
    limits = limits + 10;
    X = zeros(n,21);
    for i=1:21
        X(:,i) = Country(1,limits(1)-i+1:limits(2)-i+1).';
    end
    Y = Country(2,limits(1):limits(2)).';
    md1 = stepwiselm(X,Y);

    % Calculating Residuals
    res = md1.Residuals.Raw.';
    se2 = (1/(n-1))*sum(res.^2);
    se = sqrt(se2);
    estarV = res ./ se;
    alpha = 0.05;
    
    % Calculating adjR2
    adjR2 = md1.Rsquared.Adjusted;
    R2 = md1.Rsquared.Ordinary;
    
    % Plotting Residuals
    figure(index)
    plot(Y,estarV,'.')      
    hold on
    ax = axis;
    plot(xlim,[0 0]);
    plot([ax(1) ax(2)],norminv(1-alpha/2)*[1 1],'c--')
    plot([ax(1) ax(2)],-norminv(1-alpha/2)*[1 1],'c--')
    xlabel('Deaths')
    ylabel('residuals of linear regression')  
    
end