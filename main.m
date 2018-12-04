clc 
clear all 
close all

% paramètres du drone 
m = 1;
g= 9.81 ; 
Ix = 0.3;
Iy = 0.3;
Iz = 0.3;
I = [Ix Iy Iz] ; 

% paramètres du problèmes
T = 0.01 ; % temps de l'horizon 
n = 100 ; % nombre de points par intégration

dt = T/n ; % pas de temps 
N = 1000 ; % nombre de échantillons

%matrices de pondération
R=eye(4); % matrice de pondération sur la commande
Q= eye(12); % matrice de pôndération sur l'état

U = zeros(4,N) ; % jeux de données d'entrée 
X = zeros(12,N) ; % jeux de donnés d'état 
 
p = sobolset(12); % séquences de sobol de dimension 12 
xf = [0;0;0;0;0;0;0;0;0;0;0;0]; % référence que l'on souhaite atteindre 
tspan = 0:dt:T; % horizon d'intégration 
num_echant = 1:1:N ; % liste  des numéros d'échantillons 



%% Génération des échantillons entrée/sortie
for i=1:N
    pT = (p(i,:))' ; 
    y0 = cat(1,xf,pT); % y est une combinaison de x et de p => dimension 24
    [tv1,yv1] = ode45(@(t,y) funx(t,y,g,m,I,R,Q),tspan,y0);
%     n = size(yv1,1) ; 
    x0 = yv1(n+1,1:12)' ;
    p0 = yv1(n+1,13:24)' ;
    uopt = -inv(R)*G(x0,m,I)'*p0 ; 
    
    X(:,i) = x0 ; 
    U(:,i) = uopt ; 
end 

disp('Génération des échantillons terminée !')

%% Analyse des échantillons  

plot(num_echant,X) % on affiche les X0 pour chaque échantillons
xlabel('Numéros d"échantillon') 
ylabel('X0') 
%% Analyse des trajectoires (de tf à t0) 
plot(tv1,yv1(:,1:12))
 
%% Apprentissage du réseau de neurones 

net = feedforwardnet(10); % création du réseau de neurones
net = train(net,X,U); % apprentissage du réseau avec les jeux de données x (entrées) et u (sorties)
%view(net)
y = net(X);
perf = perform(net,y,U)

genFunction(net,'net') ; % crée une fonction net pour simuler le réseau de neurones dans simulink 

test_model % création du modèle du drone 
sim('sim_quadrotor')