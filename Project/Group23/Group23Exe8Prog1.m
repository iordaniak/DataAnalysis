% Eleni Kalla 9398
% Iordanis Konstantinidis 9492

load('data.mat');
load('limits.mat');
import java.util.Stack
clc;
clf;

% Fixing data for 3 countries
stack1 = Stack();
stack2 = Stack();
Italy = Group23Exe1Fun1(Italy,stack1);
France = Group23Exe1Fun1(France,stack2);
stack3 = Stack();
Spain = Group23Exe7Fun2(Spain);
Spain = Group23Exe1Fun1(Spain,stack3);

%Defining the second wave for each Country
limits2Spain = [229 310];
limits2Germany = [265 348];
limits2Austria = [273 348];
limits2France = [225 347];
limits2Netherlands = [253 348];
limits2Italy = [270 346];

%For Spain PLS MODEL
%Normalization 
[ normSpain1,normSpain2 ] = Group23Exe8Fun3( Spain,limitsSpain,limits2Spain);
[ adjR2_1Spain,adjR2_2Spain] = Group23Exe8Fun1(1,'Spain',normSpain1,normSpain2,Spain,limitsSpain,limits2Spain );
%Stepwise model
[adjR2_1SpainStepWise,adjR2_2SpainStepwise] = Group23Exe8Fun2(2,'Spain',normSpain1,normSpain2,Spain,limitsSpain,limits2Spain);

%For Germany PLS MODEL
%Normalization 
[ normGermany1,normGermany2 ] = Group23Exe8Fun3( Germany,limitsGermany,limits2Germany);
[ adjR2_1Germany,adjR2_2Germany ] = Group23Exe8Fun1(3,'Germany',normGermany1,normGermany2,Germany,limitsGermany,limits2Germany );
%Stepwise model
[adjR2_1GermanyStepWise,adjR2_2GermanyStepwise] = Group23Exe8Fun2(4,'Germany',normGermany1,normGermany2,Germany,limitsGermany,limits2Germany);

%For Austria PLS MODEL
%Normalization 
[ normAustria1,normAustria2 ] = Group23Exe8Fun3( Austria,limitsAustria,limits2Austria);
[ adjR2_1Austria,adjR2_2Austria ] = Group23Exe8Fun1(5,'Austria',normAustria1,normAustria2,Austria,limitsAustria,limits2Austria );
%Stepwise model
[adjR2_1AustriaStepWise,adjR2_2AustriaStepwise] = Group23Exe8Fun2(6,'Austria',normAustria1,normAustria2,Austria,limitsAustria,limits2Austria);

%For France PLS MODEL
%Normalization 
[ normFrance1,normFrance2 ] = Group23Exe8Fun3( France,limitsFrance,limits2France);
[ adjR2_1France,adjR2_2France ] = Group23Exe8Fun1(7,'France',normFrance1,normFrance2,France,limitsFrance,limits2France );
%Stepwise model
[adjR2_1FranceStepWise,adjR2_2FranceStepwise] = Group23Exe8Fun2(8,'France',normFrance1,normFrance2,France,limitsFrance,limits2France);

%For Netherlands PLS MODEL
%Normalization 
[ normNetherlands1,normNetherlands2 ] = Group23Exe8Fun3( Netherlands,limitsNetherlands,limits2Netherlands);
[ adjR2_1Netherlands,adjR2_2Netherlands ] = Group23Exe8Fun1(9,'Netherlands',normNetherlands1,normNetherlands2,Netherlands,limitsNetherlands,limits2Netherlands );
%Stepwise model
[adjR2_1NetherlandsStepWise,adjR2_2NetherlandsStepwise] = Group23Exe8Fun2(10,'Netherlands',normNetherlands1,normNetherlands2,Netherlands,limitsNetherlands,limits2Netherlands);

%For Italy PLS MODEL
%Normalization 
[ normItaly1,normItaly2 ] = Group23Exe8Fun3( Italy,limitsItaly,limits2Italy);
[ adjR2_1Italy,adjR2_2Italy ] = Group23Exe8Fun1(11,'Italy',normItaly1,normItaly2,Italy,limitsItaly,limits2Italy );
%Stepwise model
[adjR2_1ItalyStepWise,adjR2_2ItalyStepwise] = Group23Exe8Fun2(12,'Italy',normItaly1,normItaly2,Italy,limitsItaly,limits2Italy);

% Printing adjR2 for PLS and Stepwise model 
clc;
fprintf('\n------------- AdjR2 for StepWise Model --------------\n');
fprintf('\n1.Spain:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1SpainStepWise,adjR2_2SpainStepwise);
fprintf('\n2.Germany:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1GermanyStepWise,adjR2_2GermanyStepwise);
fprintf('\n3.Austria:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1AustriaStepWise,adjR2_2AustriaStepwise);
fprintf('\n4.France:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1FranceStepWise,adjR2_2FranceStepwise);
fprintf('\n5.Netherlands:\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1NetherlandsStepWise,adjR2_2NetherlandsStepwise);
fprintf('\n6.Italy:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1ItalyStepWise,adjR2_2ItalyStepwise);

fprintf('\n------------- AdjR2 for PLS Model --------------\n');
fprintf('\n1.Spain:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1Spain,adjR2_2Spain);
fprintf('\n2.Germany:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1Germany,adjR2_2Germany);
fprintf('\n3.Austria:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1Austria,adjR2_2Austria);
fprintf('\n4.France:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1France,adjR2_2France);
fprintf('\n5.Netherlands:\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1Netherlands,adjR2_2Netherlands);
fprintf('\n6.Italy:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1Italy,adjR2_2Italy);

%SXOLIA--------------------------------------------------------------------
% Gia na antimetwpisoume thn diafora sto megethos twn krousmatwn metaksu 
% kapoiwn xwrwn sto prwto kai sto deutero kuma ekpaideusame kai pali
% to training set me kanonikopoihmena Cases kai efarmosame sto
% test set ta kanonikopoihmena Cases me ton idio tropo opws kai sto
% erwtima 7.
% To prwto modelo (StepWise) kai to deutero (PLS) se genikes grammes
% prosarmozontai paromoia sto 1o kuma,me mikres diafores metaksu twn
% xwrwn kai ta duo se ikanopoihtiko vathmo(arketa upshloi adjR2).
% Se o,ti afora sto deutero kuma to montelo PLS den parousiazei diafores 
% apo to stepwise ws pros ta sfalmata provlepshs, dhladh oute to PLS einai
% ikanopoihtiko.