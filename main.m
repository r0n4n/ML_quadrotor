clc 
clear all 
close all

% param�tres du drone 
m = 1;
g= 9.81 ; 
Ix = 0.3;
Iy = 0.3;
Iz = 0.3;
I = [Ix Iy Iz] ; 

% param�tres du probl�mes
T = 0.01 ; % temps de l'horizon 
n = 100 ; % nombre de points par int�gration

dt = T/n ; % pas de temps 
N = 1000 ; % nombre de �chantillons

%matrices de pond�ration
R=eye(4); % matrice de pond�ration sur la commande
Q= eye(12); % matrice de p�nd�ration sur l'�tat

U = zeros(4,N) ; % jeux de donn�es d'entr�e 
X = zeros(12,N) ; % jeux de donn�s d'�tat 
 
p = sobolset(12); % s�quences de sobol de dimension 12 
xf = [0;0;0;0;0;0;0;0;0;0;0;0]; % r�f�rence que l'on souhaite atteindre 
tspan = 0:dt:T; % horizon d'int�gration 
num_echant = 1:1:N ; % liste  des num�ros d'�chantillons 



%% G�n�ration des �chantillons entr�e/sortie
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

disp('G�n�ration des �chantillons termin�e !')

%% Analyse des �chantillons  

plot(num_echant,X) % on affiche les X0 pour chaque �chantillons
xlabel('Num�ros d"�chantillon') 
ylabel('X0') 
%% Analyse des trajectoires (de tf � t0) 
plot(tv1,yv1(:,1:12))
 
%% Apprentissage du r�seau de neurones 

net = feedforwardnet(10); % cr�ation du r�seau de neurones
net = train(net,X,U); % apprentissage du r�seau avec les jeux de donn�es x (entr�es) et u (sorties)
%view(net)
y = net(X);
perf = perform(net,y,U)

genFunction(net,'net') ; % cr�e une fonction net pour simuler le r�seau de neurones dans simulink 

test_model % cr�ation du mod�le du drone 
sim('sim_quadrotor')