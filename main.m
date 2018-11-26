clc 
clear all 
clc

% paramètres du drone 
m = 0.25;
g= 9.81 ; 
Ix = 1.2;
Iy = 1.1;
Iz = 1;
I = [Ix Iy Iz] ; 

% initial state 
Xinit= zeros(12,1) ; 
Xinit(1) = 0 ; % x 
Xinit(2) = 0 ; % y 
Xinit(3) = 1 ; % z 
Xinit(4) = 0 ; % psi 
Xinit(5) = 0 ; % theta 
Xinit(6) = 0 ;% phi  
Xinit(7) = 0 ; % xdot 
Xinit(8) = 0 ; % ydot 
Xinit(9) = 0 ; %zdot 
Xinit(10) = 0 ; % p 
Xinit(11) = 0 ; % q 
Xinit(12) = 0 ; % r 

test_model

% paramètres du problèmes
T = 1 ; % temps de l'horizon 
dt = 0.05 ; % pas de temps 
N = 1000 ; % nombre de points

%matrices de pondération
R=eye(4); % matrice de pondération sur la commande
Q= eye(12); % matrice de pôndération sur l'état

U = zeros(4,N) ; % jeux de données d'entrée 
X = zeros(12,N) ; % jeux de donnés d'état 
 
p = sobolset(12); % séquences de sobol de dimension 12 
xf = [0;0;1;0;0;0;0;0;0;0;0;0]; % référence que l'on souhaite atteindre 
tspan = 0:dt:T; % horizon d'intégration 

%% Génération des trajectoires entrée/sortie
for i=1:N
    pT = (p(i,:))' ; 
    y0 = cat(1,xf,pT); % y est une combinaison de x et de p => dimension 24
    [tv1,yv1] = ode45(@(t,y) funx(t,y,g,m,I,R,Q),tspan,y0);
    n = size(yv1,1) ; 
    x0 = yv1(n,1:12)' ;
    p0 = yv1(n,13:24)' ;
    uopt = -inv(R)*G(x0,m,I)'*p0 ; 
    
    X(:,i) = x0 ; 
    U(:,i) = uopt ; 
end 
 
%% apprentissage du réseau de neurones 

net = feedforwardnet(10); % création du réseau de neurones
net = train(net,X,U); % apprentissage du réseau avec les jeux de données x (entrées) et t (sorties)
%view(net)
y = net(X);
perf = perform(net,y,U)
%%
gensim(net) ; % génère un block simulink de réseau de neurones 