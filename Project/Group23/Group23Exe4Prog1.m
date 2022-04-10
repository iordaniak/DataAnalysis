% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

load('data.mat');
load('limits.mat');
import java.util.Stack

% Fixing data for Spain
stack1=Stack();
Spain = Group23Exe1Fun1(Spain,stack1);

% 6 European countries including A=Spain
nCountries = 6;
countries = {'Italy','Germany','Austria','France','Netherlands','Spain'};
limits = [limitsItaly;limitsGermany;limitsAustria;limitsFrance;limitsNetherlands;limitsSpain;];


fprintf('\nThis tau gives the maximum correlation coefficient for each country:\n\n');

% Calculating the tau-value that gives the max correlation coefficient 
% for each country using funtion Group23Exe4Fun2
tauValues = zeros(1, nCountries);
for i = 1:nCountries
    
    country = eval(countries{i});
    tauValues(i) = Group23Exe4Fun1(limits(i,:),country(1,:).',country(2,:).');
    
    %The if-statements below are used to display the results nicely
    if length(countries{i})>10
        fprintf('\t\t %d.%s \t\t tau= %d\n',i,countries{i},tauValues(i));
    else
        fprintf('\t\t %d.%s \t\t\t tau= %d\n',i,countries{i},tauValues(i));
    end
end

%Sxolio--------------------------------------------------------------------
% Auth h proseggish fainetai na ektima swsta thn usterhsh ths poreias twn
% hmerisiwn kroysmatwn ws pros thn poreia twn hmerisiwn thanatwn. Epipleon 
% 4/6 xwres peftoun mesa sta 2 diasthmata empistosunhs pou upologisthkan sto
% zhthma 3 kai h kathemia ksexwrista exei sxedon idio apotelesma me thn
% diafora twn megistwn twn thanatwn-krousmatwn pou ektimithikan sto zhthma 3.
% Italy(diff=2,tau=6) France(diff=6,tau=6) Germany(diif=11,tau=13) 
% Spain(diff=5,tau=6) Netherlands(diff=3,tau=5)
% O provlhmatismos mas vrisketai sthn methodo pou xrhsimopoihsame gia na
% vroume ton suntelesth susxetishs gia kathe tau~[-20,20]. Auto poy kaname
% htan na krathsoyme ena (statheroy megethous n) parathuro sta krousmata x(t)
% kai ena kinhto parathuro idiou megethous stous thanatous y(t+tau) to opoio to
% metatopizame gia kathe tau~[-20,20]. Auto eixe san apotelesma na vgoyme
% ektos twn oriwn toy prwtoy kumatos poy eixame orisei kai theorisame oti
% den uparxei provlhma kathws h poreia toy kumatos einai paromoia gia
% hmerisia krousmata kai thanatous 