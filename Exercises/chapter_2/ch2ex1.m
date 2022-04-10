n = 2.^(2:14)';

percentages = zeros(length(n));
for i = 1:length(n)
    percentages(i) = ch2ex1func(n(i,1));
end

%plot(n,percentages, '--bs');
bar(percentages);

%****************************************************************************************************************

% m = 2; % number of discrete values for the random variable
% nV = 2.^(2:17)';
% % The following is just to show how to save a figure (not activated)
% % pridir = 'D:\MyFiles\Teach\DataAnalysisTHMMY\Figures\'; % The selected directory
% % pritxt = 'exercise2_1'; % The selected filename (without suffix)
% 
% % Applying both approaches for random coin toss: 1) directly from the 
% % discrete uniform distribution, 2) discretizing the number from the 
% % continuous uniform distribution.   
% nn = length(nV);
% propM = NaN*ones(nn,2);
% for in=1:nn
%     n = nV(in);
%     fprintf('%d.',n);
%     xV = unidrnd(m,n,1);
%     yV = rand(n,1);
%     propM(in,1) = length(find(xV==1))/n;
%     propM(in,2) = length(find(yV<0.5))/n;
% end
% fprintf('\n');
% figure(1)
% clf
% plot(log2(nV),propM(:,1),'.-k')
% hold on
% plot(log2(nV),propM(:,2),'.-c')
% plot([log(nV(1)) log(nV(nn))],(1/m)*[1 1],'--y')
% legend('unidrnd','rand')
% xlabel('sample size [log n]')
% ylabel('relative frequency')
% title('Probability of a binary outcome')
% %eval(['print -djpeg ',pridir,pritxt,'.jpg'])
% 




