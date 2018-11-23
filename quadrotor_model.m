function [ dx, y ] = quadrotor_model(t,X,u,Ix, Iy, Iz, m, g, varargin )
%quadrotor_model 


%% init function outputs
dx = zeros(12,1) ; 
y = X ; 
%% get state 
% x= X(1) ;
% y1= X(2) ;
% z= X(3) ;
psi = X(4) ;
theta = X(5) ;
phi = X(6) ;
xdot = X(7) ;
ydot = X(8) ;
zdot = X(9) ;
p = X(10) ;
q = X(11) ;
r = X(12) ;

%%
g71 = -1/m*(sin(phi)*sin(psi)+cos(phi)*cos(psi)*sin(theta)) ; 
g81 = -1/m*(cos(psi)*sin(phi)-cos(phi)*sin(psi)*sin(theta)) ; 
g91 = -1/m*(cos(phi)*cos(theta)) ; 

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

%% add control inputs
dx(7) = dx(7) + g71*u(1) ;  
dx(8) = dx(8) + g81*u(1) ; 
dx(9) = dx(9) + g91*u(1) ; 
dx(10) = dx(10) + u(2)/Ix ; 
dx(11) = dx(11) + u(3)/Iy ; 
dx(12) = dx(12) + u(4)/Iz ; 



end

