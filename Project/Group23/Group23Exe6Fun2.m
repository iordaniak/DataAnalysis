function [maxR,index,adjR2] = Group23Exe6Fun2(number,Country,limits)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492

    
    % Linear regression with indepedent variable: x(t-tau) with tau that 
    % gives the maximum R2 (from previous exercise calculated again)
    % and depedent variable: y(t)
    
    % Simple linear regression
    n = limits(2)-limits(1)+1;
    R2 = zeros(1,21);
    alpha = 0.05;
    limits = limits+10;
    X = zeros(n,21);
    Y = Country(2,limits(1):limits(2)).';
    for i = 1:21
        X(:,i) = Country(1,limits(1)-i+1:limits(2)-i+1).';
        md1 = fitlm(X(:,i),Y);      
        R2(i) = md1.Rsquared.Adjusted;
    end
    index=1;
    maxR=R2(1);
     for k=2:21  
        if R2(k)>maxR
            maxR=R2(k);
            index=k;
        end
     end
     
     % Calculating Residuals
     Xones = [ones(n,1) Country(1,limits(1)-index+1:limits(2)-index+1).'];
     [~,~,res,~,~] = regress(Country(2,limits(1):limits(2)).',Xones); 
     se2 = (1/(n-1))*(sum(res.^2));
     se = sqrt(se2);
     estarV = res ./ se;
     
     % Calculating adjR2
     muY = mean(Country(2,limits(1):limits(2)));
     adjR2 = 1-((n-1)/(n-2))*(sum(res.^2))/(sum((Country(2,limits(1):limits(2))-muY).^2));
     
     % Plotting Residuals
     figure(number)
     plot(Country(2,limits(1):limits(2)),estarV,'.')      
     hold on
     ax = axis;
     plot(xlim,[0 0]);
     plot([ax(1) ax(2)],norminv(1-alpha/2)*[1 1],'c--')
     plot([ax(1) ax(2)],-norminv(1-alpha/2)*[1 1],'c--')
     xlabel('Deaths')
     ylabel('Residuals of linear regression')  
end