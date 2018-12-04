function dF = dfdx(X,I,g)



Ix = I(1);
Iy = I(2);
Iz = I(3);


theta = X(5) ; 
phi = X(6) ; 
p = X(10) ;
q = X(11) ;
r = X(12) ;

%%%%%%%%%%%%%%%%% Calcul de DF/Dx V1 %%%%%%%%%%%%%%%%%%%%

K44 = -(X(11)*sin(X(6))*sin(X(5)))/(cos(X(5))^2) - (X(12)*cos(X(6))*sin(X(5)))/(cos(X(5))^2); 
K45 = X(11)*cos(X(6))/cos(X(5)) + X(12)*sin(X(6))/cos(X(5));
K411 = sin(X(6))/cos(X(5)) ;
K412 = cos(X(6))/cos(X(5));

K55 = -X(11)*sin(X(6)) - X(12)*cos(X(6));
K511 = cos(X(6));
K512 = sin(X(6));

K64 = X(11)*sin(X(6))*(1+(tan(X(5)))^2);
K65 = X(11)*tan(X(5))*cos(X(6)) - X(12)*tan(X(5))*sin(X(6));
K610= 1;
K611 = sin(X(6))*tan(X(5));
K612 = cos(X(6))*tan(X(5));

K1010 = 0;
K1011 = ((Iy-Iz)/Ix)*X(12);
K1012 = ((Iy-Iz)/Ix)*X(11);

K1110 = ((Iz-Ix)/Iy)*X(12);
K1111 = 0;
K1112 = ((Iz-Ix)/Iy)*X(10);

K1210 = ((Ix-Iy)/Iz)*X(11);
K1211 = ((Ix-Iy)/Iz)*X(10);
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
%%%%%%%%%%%%%%%%%%%%% FIN V1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

% K45 = q*sin(phi)*sin(theta)/(cos(theta)^2) + r*cos(phi)*sin(theta)/(cos(theta)^2) ; 
% K46 = q*cos(phi)/cos(theta)-r*sin(phi)/cos(theta) ; 
% K411 = sin(phi)/cos(theta) ;
% K412 = cos(phi)/cos(theta);
% 
% K56 = -q*sin(phi) - r*cos(phi);
% K511 = cos(phi);
% K512 = -sin(phi);
% 
% K65 = (q*sin(phi)+r*cos(phi))*(1+tan(theta)^2) ; 
% K66 = q*tan(theta)*cos(phi) - r*tan(theta)*sin(phi) ; 
% K610= 1;
% K611 = sin(phi)*tan(theta);
% K612 = cos(phi)*tan(theta);
% 
% K1010 = 0;
% K1011 = ((Iy-Iz)/Ix)*r;
% K1012 = ((Iy-Iz)/Ix)*q;
% 
% K1110 = ((Iz-Ix)/Iy)*r;
% K1111 = 0;
% K1112 = ((Iz-Ix)/Iy)*p;
% 
% K1210 = ((Ix-Iy)/Iz)*q;
% K1211 = ((Ix-Iy)/Iz)*p;
% K1212 = 0;
% 
% 
% dF = [0 0 0 0 0   0    1 0 0 0     0     0;
%       0 0 0 0 0   0    0 1 0 0     0     0;
%       0 0 0 0 0   0    0 0 1 0     0     0; % il y avait g à la 3ème colonne.  pourquoi ? 
%       0 0 0 0 K45 K46  0 0 0 0     K411  K412; % ok 
%       0 0 0 0 0   K56  0 0 0 0     K511  K512; % ok 
%       0 0 0 0 K65 K66  0 0 0 K610  K611  K612; % ok 
%       0 0 0 0 0   0    0 0 0 0     0     0;
%       0 0 0 0 0   0    0 0 0 0     0     0;
%       0 0 0 0 0   0    0 0 0 0     0     0;
%       0 0 0 0 0   0    0 0 0 K1010 K1011 K1012    
%       0 0 0 0 0   0    0 0 0 K1110 K1111 K1112        
%       0 0 0 0 0   0    0 0 0 K1210 K1211 K1212 ] ;
end

