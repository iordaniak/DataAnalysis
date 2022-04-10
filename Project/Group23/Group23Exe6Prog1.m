% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

load('data.mat');
load('limits.mat');
import java.util.Stack
clc;
clf;

% Fixing Spain's data
stack1 = Stack();
Spain = Group23Exe1Fun1(Spain,stack1);

% 6 European countries including A=Spain
nCountries = 6;
countries = {'Italy','Germany','Austria','France','Netherlands','Spain'};
limits = [limitsItaly;limitsGermany;limitsAustria;limitsFrance;limitsNetherlands;limitsSpain];

% Calculating R2, adjR2 and residuals of the 3 different adjusted models
% for each country
R2 = zeros(nCountries,3);
adjR2 = zeros(nCountries,3);
j=1;
for i = 1:nCountries
    country = eval(countries{i});
    
    % Multiple linear regression
    [R2(i,1),adjR2(i,1)] = Group23Exe6Fun1(j,country,limits(i,:));  
    str1 = sprintf('%s Residuals for model of 21 variables',countries{i});
    title(str1)
    
    % Simple linear regression
    [R2(i,2),~,adjR2(i,2)] = Group23Exe6Fun2(j+1,country,limits(i,:));   
    str2 = sprintf('%s  Residuals for linear model',countries{i});
    title(str2)
    
    % Stepwise regression
    [md1Exe6,R2(i,3),adjR2(i,3)] = Group23Exe6Fun3(j+2,country,limits(i,:));
    str3 = sprintf('%s  Residuals for stepwise model',countries{i});
    title(str3)
    
    j=j+3;
end
clc;
for i = 1:nCountries
    %The if-statements below are used to display the results nicely
    if length(countries{i})>10
        fprintf('\n\t%d.%s:\t\tAdjR2Linear=%f\t\tAdjR2Multi=%f\t\tAdjR2StepWise=%f\t\t\t\n',i,countries{i},adjR2(i,2),adjR2(i,1),adjR2(i,3));
    else
        fprintf('\n\t%d.%s:\t\t\tAdjR2Linear=%f\t\tAdjR2Multi=%f\t\tAdjR2StepWise=%f\t\t\t\n',i,countries{i},adjR2(i,2),adjR2(i,1),adjR2(i,3));
    end
end

%Sxolia--------------------------------------------------------------------
% Vlepontas ta apotelesmata twn adjR2 gia kathe ena apo ta 3 veltista
% modela (simple-linear,multi-linear,stepwise) parathroume oti gia thn
% pleiopsifia twn xwrwn me eksairesh thn Austria kai thn France, oi
% suntelestes kumainontai se paromoia epipeda. H Austria parousiazei polu
% xamhlh prosarmogh kai sta 3 modela eksaitias twn xamhlwn timwn twn
% dedomenwn ths. Gia thn France to stepwise model prosarmozetai kalutera me
% diafora. Sugkrinontas to multi-linear me to simple-linear model
% katalavainoume oti h provlepsh twn thanatwn einai safws kaluterh me to
% multi-linear apo oti me to simple-linear. Stis perissoteres periptwshs to
% stepwise mas epistrefei ta kalutera apotelesmata.