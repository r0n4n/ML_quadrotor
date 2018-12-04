function dx = F(X,I,g)

Ix = I(1);
Iy = I(2);
Iz = I(3);

%% init function outputs
dx = zeros(12,1) ; 

%% get state 

theta = X(5) ;
phi = X(6) ;
xdot = X(7) ;
ydot = X(8) ;
zdot = X(9) ;
p = X(10) ;
q = X(11) ;
r = X(12) ;


%% State equations
dx(1) = xdot ; % xdot 
dx(2) = ydot ; % ydot
dx(3) = zdot ; % zdot
dx(4) = q*sin(phi)/cos(theta) + r*cos(phi)/cos(theta) ; 
dx(5) = q*cos(phi) - r*sin(phi) ; 
dx(6) = p + q*sin(phi)*tan(theta) + r*cos(phi)*tan(theta) ; 
dx(7) = 0 ; 
dx(8) = 0 ; 
dx(9) = g ; 
dx(10) = (Iy-Iz)/Ix*q*r ; 
dx(11) = (Iz-Ix)/Iy*p*r ; 
dx(12) = (Ix-Iy)/Iz*p*q ; 


end

