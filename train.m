

clear all 
clc 
close all
%% 
net = feedforwardnet(10); % cr�ation du r�seau de neurones
net = train(net,x,u); % apprentissage du r�seau avec les jeux de donn�es x (entr�es) et t (sorties)
% view(net)
% y = net(x);
% perf = perform(net,y,t); 

%gensim(net) ; % g�n�re un block simulink de r�seau de neurones 