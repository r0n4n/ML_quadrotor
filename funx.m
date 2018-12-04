function dydt = funx(t,y,g,m,I,R,Q)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dydt = [dxdt(x,p) ; dpdt(x,p)] avec 
    % dxdt = - (F(x)-G(x)*inv(R)G(x)'*p)
    % dpdt = - (-Q*x -dFdx'(x)*p) 
    % où F et G sont les fonctions du système non linéaire :
    % dxdt = F(X) + G(X)*U 
    % R la matrice de pondération sur la commande U 
    % Q la matrice de pondération sur l'état X 
    
%  les fonctions dxdt et dpdt sont prises négatives pour intégrer en
%  "remontant" le temps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ix = I(1);
Iy = I(2);
Iz = I(3);


theta = y(5) ; 
phi = y(6) ; 
p = y(10) ;
q = y(11) ;
r = y(12) ; 



%%%%%%%%%%%%%%% calcul de dxdt  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calcul de G(X) de taille 12x4

G1 = zeros(12,1) ; 
G2 = zeros(12,1) ; 
G3 = zeros(12,1) ; 
G4 = zeros(12,1) ;

G1(7)=  -(1/m)*(sin(y(6))*sin(y(4))+cos(y(6))*cos(y(4))*sin(y(5))) ; 
G1(8)=  -(1/m)*(cos(y(4))*sin(y(6))-cos(y(6))*sin(y(4))*sin(y(5))); 
G1(9) =  - (1/m)*cos(y(6))*cos(y(5)); 

G2(10) = 1/Ix ; 
G3(11) = 1/Iy ; 
G4(12) = 1/Iz ; 

G = [G1 G2 G3 G4] ; 

% G = [0;
%     0;
%     0;
%     0;
%     0;
%     0;
%     -(1/m)*(sin(y(6))*sin(y(4))+cos(y(6))*cos(y(4))*sin(y(5)));
%     -(1/m)*(cos(y(4))*sin(y(6))-cos(y(6))*sin(y(4))*sin(y(5)));
%     - (1/m)*cos(y(6))*cos(y(5));
%     (1/Ix);
%     (1/Iy);
%     (1/Iz)];

F = [y(7);
    y(8);
    y(9);
    y(11)*(sin(y(6))/cos(y(5)))+y(12)*(cos(y(6))/cos(y(5))); % erreur c'était y(11) et pas y(10)
    y(11)*cos(y(6))-y(12)*sin(y(6));
    y(10)+y(11)*sin(y(6))*tan(y(5))+y(12)*cos(y(6))*tan(y(5));
    0;
    0;
    g;
    ((Iy-Iz)/Ix)*y(11)*y(12); % erreur c'était y(11) et pas y(10)
    ((Iz-Ix)/Iy)*y(10)*y(12); % erreur c'était y(10) et pas y(11)
    ((Ix-Iy)/Iz)*y(10)*y(11)];


dydt1=zeros(12,1); % mettre dxdt 
dydt1 = -(F-G*inv(R)*G'*y(13:24)); % mettre p à la place de y pour que ce soit plus lisible

%%%%%%%%%%%%%%%%%%% Calcul de dpdt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% Calcul de DF/Dx V1 %%%%%%%%%%%%%%%%%%%%
% 
% K44 = -(y(11)*sin(y(6))*sin(y(5)))/(cos(y(5))^2) - (y(12)*cos(y(6))*sin(y(5)))/(cos(y(5))^2); 
% K45 = y(11)*cos(y(6))/cos(y(5)) + y(12)*sin(y(6))/cos(y(5));
% K411 = sin(y(6))/cos(y(5)) ;
% K412 = cos(y(6))/cos(y(5));
% 
% K55 = -y(11)*sin(y(6)) - y(12)*cos(y(6));
% K511 = cos(y(6));
% K512 = sin(y(6));
% 
% K64 = y(11)*sin(y(6))*(1+(tan(y(5)))^2);
% K65 = y(11)*tan(y(5))*cos(y(6)) - y(12)*tan(y(5))*sin(y(6));
% K610= 1;
% K611 = sin(y(6))*tan(y(5));
% K612 = cos(y(6))*tan(y(5));
% 
% K1010 = 0;
% K1011 = ((Iy-Iz)/Ix)*y(12);
% K1012 = ((Iy-Iz)/Ix)*y(11);
% 
% K1110 = ((Iz-Ix)/Iy)*y(12);
% K1111 = 0;
% K1112 = ((Iz-Ix)/Iy)*y(10);
% 
% K1210 = ((Ix-Iy)/Iz)*y(11);
% K1211 = ((Ix-Iy)/Iz)*y(10);
% K1212 = 0;
% 
% % suppose t'on que l'acceleration selon x et y nulle quand on dérive x point et
% % y point selon x et y ? 
% dF = [0 0 0 0 0   0    1 0 0 0     0     0;
%       0 0 0 0 0   0    0 1 0 0     0     0;
%       0 0 g 0 0   0    0 0 1 0     0     0;
%       0 0 0 0 K44 K45  0 0 0 0     K411  K412;
%       0 0 0 0 0   K55  0 0 0 0     K511  K512;
%       0 0 0 0 K64 K65  0 0 0 K610  K611  K612;
%       0 0 0 0 0   0    0 0 0 0     0     0;
%       0 0 0 0 0   0    0 0 0 0     0     0;
%       0 0 0 0 0   0    0 0 0 0     0     0;
%       0 0 0 0 0   0    0 0 0 K1010 K1011 K1012    
%       0 0 0 0 0   0    0 0 0 K1110 K1111 K1112        
%       0 0 0 0 0   0    0 0 0 K1210 K1211 K1212 ] ;
% %%%%%%%%%%%%%%%%%%%%% FIN V1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   


%%%%%%%%%%%%%%%%%% Calcul de DF/Dx V2 %%%%%%%%%%%%%%%%%%%%
 
K45 = q*sin(phi)*sin(theta)/(cos(theta)^2) + r*cos(phi)*sin(theta)/(cos(theta)^2) ; 
K46 = q*cos(phi)/cos(theta)-r*sin(phi)/cos(theta) ; 
K411 = sin(phi)/cos(theta) ;
K412 = cos(phi)/cos(theta);

K56 = -q*sin(phi) - r*cos(phi);
K511 = cos(phi);
K512 = -sin(phi);

K65 = (q*sin(phi)+r*cos(phi))*(1+tan(theta)^2) ; 
K66 = q*tan(theta)*cos(phi) - r*tan(theta)*sin(phi) ; 
K610= 1;
K611 = sin(phi)*tan(theta);
K612 = cos(phi)*tan(theta);

K1010 = 0;
K1011 = ((Iy-Iz)/Ix)*r;
K1012 = ((Iy-Iz)/Ix)*q;

K1110 = ((Iz-Ix)/Iy)*r;
K1111 = 0;
K1112 = ((Iz-Ix)/Iy)*p;

K1210 = ((Ix-Iy)/Iz)*q;
K1211 = ((Ix-Iy)/Iz)*p;
K1212 = 0;

% suppose t'on que l'acceleration selon x et y nulle quand on dérive x point et
% y point selon x et y ? 
dF = [0 0 0 0 0   0    1 0 0 0     0     0;
      0 0 0 0 0   0    0 1 0 0     0     0;
      0 0 0 0 0   0    0 0 1 0     0     0; % il y avait g à la 3ème colonne.  pourquoi ? 
      0 0 0 0 K45 K46  0 0 0 0     K411  K412; % ok 
      0 0 0 0 0   K56  0 0 0 0     K511  K512; % ok 
      0 0 0 0 K65 K66  0 0 0 K610  K611  K612; % ok 
      0 0 0 0 0   0    0 0 0 0     0     0;
      0 0 0 0 0   0    0 0 0 0     0     0;
      0 0 0 0 0   0    0 0 0 0     0     0;
      0 0 0 0 0   0    0 0 0 K1010 K1011 K1012    
      0 0 0 0 0   0    0 0 0 K1110 K1111 K1112        
      0 0 0 0 0   0    0 0 0 K1210 K1211 K1212 ] ;
%%%%%%%%%%%%%%%%%%%%% FIN V2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
dydt2 =zeros(12,1); % mettre dpdt pour que ce soit plus lisible 
dydt2 = - (-Q*y(1:12) - dF'*y(13:24));

%création de la matrice y finale (x+p)
dydt = cat(1, dydt1, dydt2);
 
end


