% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

% We defined the start/end of the first wave for each country and stored them in the file: limits.mat
load('data.mat')
load('limits.mat')

% Selecting a number of European countries
nCountries = 13;
countries = {'UnitedKingdom';'Croatia';'Czechia';'Denmark';'Italy';'France';'Germany';
             'Sweden'; 'Switzerland'; 'Austria'; 'Romania'; 'Norway'; 'Netherlands'};
% Defining start/end of the first wave for both cases and deaths
limits1 = [limitsUnitedKingdom;limitsCroatia;limitsCzechia;limitsDenmark;limitsItaly;limitsFrance;
          limitsGermany;limitsSweden;limitsSwitzerland;limitsAustria;limitsRomania;limitsNorway;limitsNetherlands];
limits2 = [[77 188];[84 150];[82 146];[75 167];[67 163];[76 145];
          [79 166];[77 207];[76 144];[76 138];[82 160];[72 143];[74 154]];


% Fitting the distributions that were found in the previous excersise to both cases and deaths 
casesMSE = zeros(nCountries,1);
deathsMSE = zeros(nCountries,1);
flag = 0; index = 0;
for i = 1:nCountries
    country1 = eval(countries{i});
    casesMSE(i)  = Group23Exe2Fun1(flag,index,country1(1,limits1(i,1):limits1(i,2)).','Loglogistic');
    deathsMSE(i) = Group23Exe2Fun1(flag,index,country1(2,limits2(i,1):limits2(i,2)).','Lognormal');
end

% Ranking the countries with the first country being the one with the lowest MSE. 
pointers = (1:nCountries).';
sortedMSEcases = sortrows([casesMSE pointers]);
sortedMSEdeaths = sortrows([deathsMSE pointers]);
fprintf('\n The rankings for cases are: \n\n');
for i = 1:nCountries
    %The if-statements below are used to display the results nicely
    if length(countries{sortedMSEcases(i,2)})>10
        fprintf('\t\t%d.%s\t\t\t MSE=%f \n',i,countries{sortedMSEcases(i,2)},sortedMSEcases(i,1));
    elseif length(countries{sortedMSEcases(i,2)})==5
        fprintf('\t\t%d.%s\t\t\t\t\t MSE=%f \n',i,countries{sortedMSEcases(i,2)},sortedMSEcases(i,1));
    else
         fprintf('\t\t%d.%s\t\t\t\t MSE=%f \n',i,countries{sortedMSEcases(i,2)},sortedMSEcases(i,1));
    end
end
fprintf('\n The rankings for deaths are: \n\n');
for i = 1:nCountries
    %The if-statements below are used to display the results nicely
    if length(countries{sortedMSEdeaths(i,2)})>10
        fprintf('\t\t%d.%s\t\t\t MSE=%f \n',i,countries{sortedMSEdeaths(i,2)},sortedMSEdeaths(i,1));
    elseif length(countries{sortedMSEdeaths(i,2)})==5
        fprintf('\t\t%d.%s\t\t\t\t\t MSE=%f \n',i,countries{sortedMSEdeaths(i,2)},sortedMSEdeaths(i,1));
    else
         fprintf('\t\t%d.%s\t\t\t\t MSE=%f \n',i,countries{sortedMSEdeaths(i,2)},sortedMSEdeaths(i,1));
    end
end

% Graphs
flag = 1;
index = 1;
country1 = eval(countries{sortedMSEcases(1,2)});
Group23Exe2Fun1(flag,index,country1(1,limits1(sortedMSEcases(1,2),1):limits1(sortedMSEcases(1,2),2)).','Loglogistic');
hold on
str = sprintf('Cases for %s - Loglogistic',countries{sortedMSEcases(1,2)});
title(str)
index = 2;
country2 = eval(countries{sortedMSEdeaths(1,2)});
Group23Exe2Fun1(flag,index,country2(2,limits2(sortedMSEdeaths(1,2),1):limits2(sortedMSEdeaths(1,2),2)).','Lognormal');
hold on
str = sprintf('Deaths for %s - Lognormal',countries{sortedMSEdeaths(1,2)});
title(str)

% Sxolia---------------------------------------------------------------------
% Se oti afora ta kroysmata fainetai pws h katanomh loglogistic
% prosarmozetai ikanopoihtika kathws ta MSE pou prokuptoun einai polu mikra
% kai gia tis 13 xwres. Se oti afora toys thanatoys ta sfalmata
% eksakolouthoun na einai mikra megalutera omws apo auta twn kroysmatwn.
% Epeidh to prwto kuma kathoristhke apo ta cases kai oxi apo ta deaths
% kai logw ths xronikhs diaforas twn duo, opws perimename h
% katanomh lognormal den prosarmozetai idanika.