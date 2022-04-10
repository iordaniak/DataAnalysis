function [ norm1,norm2 ] = Group23Exe7Fun6( Country,limits1,limits2)
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % Normalizing data by dividing them with their sum
    norm1=Country(1,:)/sum(Country(1,limits1(1):limits1(2)));
    norm2=Country(1,:)/sum(Country(1,limits2(1):limits2(2)));
end

