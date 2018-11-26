

% clear all 
% clc 
% close all

[x,t] = simplefit_dataset;
net = feedforwardnet(10);
net = train(net,x,t);
view(net)
y = net(x);
perf = perform(net,y,t)
 
net = feedforwardnet(10); % création du réseau de neurones
net = train(net,x,u); % apprentissage du réseau avec les jeux de données x (entrées) et u (sorties)
% view(net)
% y = net(x);
% perf = perform(net,y,t); 

%gensim(net) ; % génère un block simulink de réseau de neurones 