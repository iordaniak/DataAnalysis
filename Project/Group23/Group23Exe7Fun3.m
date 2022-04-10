function [b,maxR,index,adjR2] = Group23Exe7Fun3(Country,limits)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % For simple-linear regression with tau that gives the max R2
    n = limits(2)-limits(1)+1;
    R2=zeros(1,21);
    limits = limits + 10;
    X = zeros(n,21);
    Y = Country(2,limits(1):limits(2)).';
    for i=1:21
        X(:,i)=Country(1,limits(1)-i+1:limits(2)-i+1).';
        md1=fitlm(X(:,i),Y);      
        R2(i)=md1.Rsquared.Adjusted;
    end
    
    index=1;
    maxR=R2(1);
    for k=2:21  
        if R2(k)>maxR
            maxR=R2(k);
            index=k;
        end
    end
     
    %Finding best fitted LinearModel
    Xones = [ones(n,1) Country(1,limits(1)-index+1:limits(2)-index+1).'];
    [b,~,res,~,~] = regress(Country(2,limits(1):limits(2)).',Xones); 
    muY=mean(Country(2,limits(1):limits(2)));
    adjR2 =1-((n-1)/(n-2))*(sum(res.^2))/(sum((Country(2,limits(1):limits(2))-muY).^2));
end