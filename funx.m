function dydt = funx(t,y,g,m,I,R,Q)
% Définition des paramètres Ix, Iy, Iz :
%g = 9.81;
%disp(g)
%m = 0.25;
Ix = I(1);
Iy = I(2);
Iz = I(3);

% %matrice de pondération
% R=eye(1);
% Q= eye(1);

% calcul de x point
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
    y(10)*(sin(y(6))/cos(y(5)))+y(12)*(cos(y(6))/cos(y(5)));
    y(10)*cos(y(6))-y(12)*sin(y(6));
    y(10)+y(11)*sin(y(6))*tan(y(5))+y(12)*cos(y(6))*tan(y(5));
    0;
    0;
    g;
    ((Iy-Iz)/Ix)*y(10)*y(12);
    ((Iz-Ix)/Iy)*y(11)*y(12);
    ((Ix-Iy)/Iz)*y(10)*y(11)];


dydt1=zeros(12,1);
dydt1 = -(F-G*inv(R)*G'*y(13:24));

% Calcul de p point

% Calcul de DF/Dx 

K44 = -(y(11)*sin(y(6))*sin(y(5)))/(cos(y(5))^2) - (y(12)*cos(y(6))*sin(y(5)))/(cos(y(5))^2); 
K45 = y(11)*cos(y(6))/cos(y(5)) + y(12)*sin(y(6))/cos(y(5));
K411 = sin(y(6))/cos(y(5)) ;
K412 = cos(y(6))/cos(y(5));

K55 = -y(11)*sin(y(6)) - y(12)*cos(y(6));
K511 = cos(y(6));
K512 = sin(y(6));

K64 = y(11)*sin(y(6))*(1+(tan(y(5)))^2);
K65 = y(11)*tan(y(5))*cos(y(6)) - y(12)*tan(y(5))*sin(y(6));
K610= 1;
K611 = sin(y(6))*tan(y(5));
K612 = cos(y(6))*tan(y(5));

K1010 = 0;
K1011 = ((Iy-Iz)/Ix)*y(12);
K1012 = ((Iy-Iz)/Ix)*y(11);

K1110 = ((Iz-Ix)/Iy)*y(12);
K1111 = 0;
K1112 = ((Iz-Ix)/Iy)*y(10);

K1210 = ((Ix-Iy)/Iz)*y(11);
K1211 = ((Ix-Iy)/Iz)*y(10);
K1212 = 0;

% suppose t'on que l'acceleration selon x et y nulle quand on dérive x point et
% y point selon x et y ? 
dF = [0 0 0 0 0   0    1 0 0 0     0     0;
      0 0 0 0 0   0    0 1 0 0     0     0;
      0 0 g 0 0   0    0 0 1 0     0     0;
      0 0 0 0 K44 K45  0 0 0 0     K411  K412;
      0 0 0 0 0   K55  0 0 0 0     K511  K512;
      0 0 0 0 K64 K65  0 0 0 K610  K611  K612;
      0 0 0 0 0   0    0 0 0 0     0     0;
      0 0 0 0 0   0    0 0 0 0     0     0;
      0 0 0 0 0   0    0 0 0 0     0     0;
      0 0 0 0 0   0    0 0 0 K1010 K1011 K1012    
      0 0 0 0 0   0    0 0 0 K1110 K1111 K1112        
      0 0 0 0 0   0    0 0 0 K1210 K1211 K1212 ] ;
      
 
dydt2 =zeros(12,1);
dydt2 = - (-Q*y(1:12) - dF'*y(13:24));

%création de la matrice y finale (x+p)
dydt = cat(1, dydt1, dydt2);
 
end


