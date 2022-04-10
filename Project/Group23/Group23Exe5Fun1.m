function [maxR2,tau,adjR2] = Group23Exe5Fun1(number,limits,country,countryName)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % The inputs are: 
    % 1.'number' is used to handle the figures 
    % 2.'limits' is an array that contains the start and end of the wave
    % 3.'country' is an array that contains the cases/deaths of the country
    % 4.'countryname' contains a string of the country's name
    % We call the function regess() of the x(t-tau),y(t) t~[0,20] to
    % calculate R2,adjR2 and then find the tau that gives the maximum R2
    % After that for this certain tau we calculate the residuals and also
    % display graphs of a scatter plot and a linear regression model for
    % the variables x(t-tau), y(t)
    
    
    n = limits(2)-limits(1)+1;
    R2 = zeros(1,21);
    alpha = 0.05;
    limits = limits + 8;
    for i = 1:21
        Xones = [ones(n,1) country(1,limits(1)-i+1:limits(2)-i+1).'];
        [~, ~,~,~,stats] = regress(country(2,limits(1):limits(2)).',Xones); 
        R2(i)=stats(1);
    end
    
    index = 1;
    maxR2 = R2(1);
     for k = 2:21  
        if R2(k)>maxR2
            maxR2 = R2(k);
            index = k;
        end
     end
     tau = index - 1;
     %calculating best linear Model and its residuals
     Xones = [ones(n,1) country(1,limits(1)-index+1:limits(2)-index+1).'];
     [bV, ~,res,~,~] = regress(country(2,limits(1):limits(2)).',Xones); 
     se2 = (1/(n-1))*(sum(res.^2));
     se = sqrt(se2);
     estarV = res ./ se;
          
     % ScatterPlot and Linear-Model
     f1 = @(x) bV(2)*x + bV(1);
     figure(number)    
     plot(country(1,limits(1)-index+1:limits(2)-index+1),country(2,limits(1):limits(2)),'o')
     hold on
     fplot(f1,[min(country(1,limits(1)-index+1:limits(2)-index+1)) max(country(1,limits(1)-index+1:limits(2)-index+1))])
     str1 = sprintf('%s: Scatter plot and fitted linear model',countryName);
     title(str1)
     xlabel('Cases')
     ylabel('Deaths')
               
     % Plotting Residuals
     figure(number+1)
     plot(country(2,limits(1):limits(2)),estarV,'.')      
     hold on
     ax = axis;
     plot(xlim,[0 0]);
     plot([ax(1) ax(2)],norminv(1-alpha/2)*[1 1],'c--')
     plot([ax(1) ax(2)],-norminv(1-alpha/2)*[1 1],'c--')
     xlabel('Deaths')
     ylabel('residuals of linear regression')
     str2 = sprintf('%s: Graph of Residuals',countryName);
     title(str2)
        
     % Calculating adjR2
     muY=mean(country(2,limits(1):limits(2)));
     adjR2 =1-((n-1)/(n-2))*(sum(res.^2))/(sum((country(2,limits(1):limits(2))-muY).^2));
end

