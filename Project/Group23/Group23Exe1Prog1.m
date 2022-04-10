% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

% The country A that is associated to our group(AEM=9492) is Spain

% The file data.mat contains the same data from the 2 excel files but only the ones that we use
load('data.mat')
import java.util.Stack

% Fixing data (More details in function: Group23Exe1Fun1)
stack = Stack();
Spain = Group23Exe1Fun1(Spain,stack);

% Defining the first wave for Spain for both cases and deaths.(setting the limits)
limits1 = [60 134];
limits2 = [66 140];
% Fitting 6 different distributions to both cases and deaths (More details in function: Group23Exe1Fun2)
clc;
clf;
distributions = {'NegativeBinomial','Loglogistic','Normal','Lognormal','Poisson','Logistic'};
mseCases = zeros(6,1);
mseDeaths = zeros(6,1);
for i = 1:6
    mseCases(i) = Group23Exe1Fun2(i,Spain(1,limits1(1):limits1(2)).',distributions{i});
    mseDeaths(i) = Group23Exe1Fun2(i+6,Spain(2,limits2(1):limits2(2)).',distributions{i});
end

% Finding minimum MSE for both cases and deaths
indexCases = 1;
minCases = mseCases(1);
indexDeaths = 1;
minDeaths = mseDeaths(1);
for i=2:6 
    if mseCases(i) < minCases
        minCases = mseCases(i);
        indexCases = i;
    end
    if mseDeaths(i) < minDeaths
        minDeaths = mseDeaths(i);
        indexDeaths = i;
    end
end
fprintf('\n\tThe best fitted distribution for Cases is %s with MSE= %f\n',distributions{indexCases},mseCases(indexCases));
fprintf('\n\tThe best fitted distribution for Deaths is %s with MSE= %f\n',distributions{indexDeaths},mseDeaths(indexDeaths));

% Sxolia---------------------------------------------------------------------
% Gia na epileksw katanomi xrisimopoiw to MSE pou prokuptei apo ta
% Normalized dedomena mou kai thn katanomh pou ektimatai apo tin fitdist
% Opws prokuptei apo ta dedomena den einai idia i pio katallili katanomi gia
% ta krousmata kai tous thanatous,wstoso koitwntas ta sfalmata gia tis
% antistoixes katanomes paratiroume oti einai eksisou mikra. Epomenws tha
% mporouse h katanomi twn Cases na einai katallili kai gia ta Deaths kai antistrofa.