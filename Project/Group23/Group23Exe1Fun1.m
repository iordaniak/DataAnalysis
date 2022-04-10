function [ Country ] = Group23Exe1Fun1( Country, stack )
    
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % The purpose of this function is to correct the data by removing the NaN 
    % and negative values for both cases and deaths. 
    % We use a stack to store the indexes of those values.
    
    n = 0;
    for i = 1:length(Country(1,:))
        if Country(1,i) < 0 || isnan(Country(1,i)) || Country(2,i)<0 || isnan(Country(2,i))
            stack.push(i);
            n = n + 1;
        end
    end

    temp = zeros(1,n);
    for i = 1:n
        temp(i) = stack.pop();
    end
    Country(:, temp) = [];

end
