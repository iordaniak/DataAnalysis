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

% Defining the start/end of the 2nd wave for each Country
limits2Spain=[229 310];
limits2Germany=[265 348];
limits2Austria=[273 348];
limits2France=[225 347];
limits2Netherlands=[253 348];
limits2Italy=[270 346];

%FOR Spain
%Normalization 
[normSpain1,normSpain2] = Group23Exe7Fun6( Spain,limitsSpain,limits2Spain);
%Model for Spain-MultiLinear
[adjR2_1_Spain,adjR2_2_Spain] = Group23Exe7Fun7(1,'Spain',Spain,normSpain1,normSpain2,limitsSpain,limits2Spain);
title('Spain-21 Variable Model')
%FOR ITALY
%Normalization
[normItaly1,normItaly2] = Group23Exe7Fun6( Italy,limitsItaly,limits2Italy);
%Model for Italy-MultiLinear
[adjR2_1_Italy,adjR2_2_Italy] = Group23Exe7Fun7(2,'Italy',Italy,normItaly1,normItaly2,limitsItaly,limits2Italy);
title('Italy-21 Variable Model')
%FOR Germany
%Normalization
[normGermany1,normGermany2] = Group23Exe7Fun6( Germany,limitsGermany,limits2Germany);
%Model for Italy-MultiLinear
[adjR2_1_Germany,adjR2_2_Germany] = Group23Exe7Fun7(3,'Germany',Germany,normGermany1,normGermany2,limitsGermany,limits2Germany);
title('Germany-21 Variable Model')
%FOR Netherlands
%Normalization
[normNetherlands1,normNetherlands2] = Group23Exe7Fun6( Netherlands,limitsNetherlands,limits2Netherlands);
%Model for Netherlands-MultiLinear
[adjR2_1_Netherlands,adjR2_2_Netherlands] = Group23Exe7Fun7(4,'Netherlands',Netherlands,normNetherlands1,normNetherlands2,limitsNetherlands,limits2Netherlands);
title('Netherlands-21 Variable Model')
%FOR Austria
%Normalization
[normAustria1,normAustria2] = Group23Exe7Fun6( Austria,limitsAustria,limits2Austria);
%Model for Austria-StepWise
[adjR2_1_Austria,adjR2_2_Austria] = Group23Exe7Fun1(5,'Austria',Austria,normAustria1,normAustria2,limitsAustria,limits2Austria);
title('Austria-Stepwise Model')

%FOR France
%Normalization
[normFrance1,normFrance2] = Group23Exe7Fun6( France,limitsFrance,limits2France);
[adjR2_1_France,adjR2_2_France] = Group23Exe7Fun1(6,'France',France,normFrance1,normFrance2,limitsFrance,limits2France);
title('France-Stepwise Model')

%PRINTING adjR2 FOR 

clc;
fprintf('\n------------------ AdjR2 for BestFitted Model ------------------\n');
fprintf('\n\t1.Spain:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1_Spain,adjR2_2_Spain);
fprintf('\n\t2.Italy:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1_Italy,adjR2_2_Italy);
fprintf('\n\t3.Germany:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1_Germany,adjR2_2_Germany);
fprintf('\n\t4.Netherlands:\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1_Netherlands,adjR2_2_Netherlands);
fprintf('\n\t5.Austria:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1_Austria,adjR2_2_Austria);
fprintf('\n\t6.France:\t\t FirstWave= %f\t  SecondWave= %f\n',adjR2_1_France,adjR2_2_France);

%SXOLIA--------------------------------------------------------------------
%Se kapoies apo tis xwres pou meletame to deutero kuma toy iou htan 
%sfodrotero me apotelesma na exoume megalutero arithmo
% krousmatwn (pithanon logw twn perissoterwn test  Covid pou
% pragmatopoiountan).H auksisi omws twn krousmatwn den eixe
%analogi auksisi twn thanatwn. Gia na to antimetwpisoume ayto 
%kai oi times twn dyo kumatwn pou prokuptoun apo to modelo na einai 
%sugkrisimes, ekpaideusame to training
%set me kanonikopoihmena cases kai efarmosame sto test set pali
%kanonikopoihmena cases(diairwntas ta Cases me to antistoixo athroisma
%tous).H diadikasia auth mas voitha na sugkrinoume
%kalutera tis provlepseis sto sunolo ekmathisis me autes sto sunolo
%aksiologisis.Sugkrinontas ta apotelesmata twn adjR2 gia to prwto
%kai to deytero kyma paratiroume oti to montelo den prosarmozetai kala 
%sto deutero kyma sthn pleiopsifia twn xwrwn,me eksairesi isws tin
%Italy.Stin Ispania gia paradeigma i astoxia tou montelou na provlepsei to
%deutero kuma me akriveia fanerwnei pws paroti to deutero kuma eixe perissotera
%krousmata oi thanatoi itan se xamilotera epipeda,pragma to opoio
%mporei na ofeiletai se diaforous paragontes enas ek twn opoiwn 
%mporei na einai h proetoimasia ths xwras gia tin antimetwpisi tou
%deuterou kumatos pandimias mesw tis ependushs sto sistima ugeias ths,h akomh 
%kai h ptwsi tou mesou orou ilikias twn krousmatwn,diladi paroti nosousan 
%perissoteroi,itan stin pleiopshfia tous mikroteris ilikias opote
%kai den pethainan.
