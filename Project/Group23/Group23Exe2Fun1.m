function [ mse ] = Group23Exe2Fun1(flag, index, CasesOrDeaths, Distribution)
    
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % The purpose of this function is to:
    % 1. Normalize the samples of cases,deaths for each given country
    % 2. Fit the distribution that is given as input to the function
    % 3. Compute the MSE between the normalized data and the distribution
    % 4. Display figures that are handled by the inputs 'index','flag'
    %    with info and graphs
    
    % Fitting Distribution
    x = 1:length(CasesOrDeaths);
    pd = fitdist(x.',Distribution,'Frequency',CasesOrDeaths);
    y = pdf(pd, x);
    
    % Normalization
    max1 = max(CasesOrDeaths);
    normalizedValues = CasesOrDeaths/(max1/max(y));
    
    % MSE computation
    e2 = (normalizedValues-y').^2;
    mse = sum(e2)/length(CasesOrDeaths);
    
    % Graphs
    if flag == 1
      if index == 1
           name = 'Normalized Cases';
      else 
          name = 'Normalized Deaths';
      end
       figure(index)
       title(Distribution)
       hold on
       ylabel(name);
       xlabel('Days');
       bar(normalizedValues);
       plot(x,y,'r');
    end

end
