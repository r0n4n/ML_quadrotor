

% initial state 
X= zeros(12,1) ; 
X(1) = 0 ; % x 
X(2) = 0 ; % y 
X(3) = 10 ; % z 
X(4) = 0 ; % psi 
X(5) = 0 ; % theta 
X(6) = 5 ;% phi  
X(7) = 0 ; % xdot 
X(8) = 0 ; % ydot 
X(9) = 0 ; %zdot 
X(10) = 0 ; % p 
X(11) = 0 ; % q 
X(12) = 0 ; % r 

%% Create NL model 

%parameters
Ix = 0.33 ; 
Iy = 0.33 ; 
Iz = 0.33 ; 
m= 1 ; 
g = 9.81 ; 


file_name = 'quadrotor_model';
Order = [12 4 12];
Parameters = [Ix Iy Iz m g];
InitialStates = X ;

quadrotor_m = idnlgrey(file_name,Order,Parameters,InitialStates,0,'Name','quadrotor_model');
% quadrotor_m.OutputName = {'x','y','z','psi','theta'}
quadrotor_m.InputName = {'u1','u2','u3','u4'} ; 

