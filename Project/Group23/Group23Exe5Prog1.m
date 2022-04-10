% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

load('data.mat');
load('limits.mat');
import java.util.Stack
clf;

%Fixing data for Spain
stack1=Stack();
Spain = Group23Exe1Fun1(Spain,stack1);

% 6 European countries including A=Spain
nCountries = 6;
countries = {'Italy','Germany','Austria','France','Netherlands','Spain'};
limits = [limitsItaly;limitsGermany;limitsAustria;limitsFrance;limitsNetherlands;limitsSpain;];

% Calculating the tau value that gives the maximum R2
R2 = zeros(nCountries,1);
adjR2 = zeros(nCountries,1);
tau = zeros(nCountries,1);
fprintf('\n\t\t--------tau, R2, adjR2 for linear model of each country:--------\n\n');
j=1;
for i = 1:nCountries
    [R2(i),tau(i),adjR2(i)] = Group23Exe5Fun1(j,limits(i,:),eval(countries{i}),countries{i});
    j=j+2;
    %The if-statements below are used to display the results nicely
    if length(countries{i})>10
        fprintf('\t\t%d.%s:\t tau = %d\t\tR2= %f\tadjR2= %f\n',i,countries{i},tau(i),R2(i),adjR2(i));
    else
        fprintf('\t\t%d.%s:\t\t tau = %d\t\tR2= %f\tadjR2= %f\n',i,countries{i},tau(i),R2(i),adjR2(i));
    end
end

%Sxolia----------------------------------------------------------------------
%
% Apo ta apotelesmata vlepoume oti h prosarmogh einai kalh stis 4 apo tis 6
% xwres pou exoume gia tis opoies einai dunath h provlepsh twn thanatwn apo
% apo ta krousmata. Apo ton diagnwstiko elegxo prokuptei oti to modelo
% einai katallhlo gia thn pleiopshfia twn xwrwn
% Oi veltistes usterhseis(tau) sumfwnoun apoluta me tis usterhseis tou 4ou
% zhthmatos kai einai konta me autes tou 3ou. H methodos pou akolouthisame 
% gia na vroume ta R2,adjR2 gia kathe tau~[0,20] einai na
% krathsoyme ena (statheroy megethous n) parathuro stous thanatous y(t), to
% opoio htan to parathuro tou 1ou kumatos metatopismeno kata thn veltisth
% usterhsh pou upologisame sto prohgoumeno erwthma etsi wste na perilamvanetai
% olh h plhroforia gia tous thanatous pou mas endiaferoun, kai ena kinhto
% parathuro idiou megethous stous thanatous x(t-tau) to opoio to
% metatopizame gia kathe tau~[0,20]. Auto eixe san apotelesma na vgoyme
% ektos twn oriwn toy prwtou kumatos pou eixame orisei. Theorisame wstoso 
% oti den uparxei provlhma kathws h poreia tou kumatos einai paromoia gia
% hmerisia krousmata kai thanatous 