function y = G(x,m,I)

Ix = I(1);
Iy = I(2);
Iz = I(3);

G1 = zeros(12,1) ; 
G2 = zeros(12,1) ; 
G3 = zeros(12,1) ; 
G4 = zeros(12,1) ;

G1(7)=  -(1/m)*(sin(x(6))*sin(x(4))+cos(x(6))*cos(x(4))*sin(x(5))) ; 
G1(8)=  -(1/m)*(cos(x(4))*sin(x(6))-cos(x(6))*sin(x(4))*sin(x(5))); 
G1(9) =  - (1/m)*cos(x(6))*cos(x(5)); 

G2(10) = 1/Ix ; 
G3(11) = 1/Iy ; 
G4(12) = 1/Iz ; 

y = [G1 G2 G3 G4] ;
end

