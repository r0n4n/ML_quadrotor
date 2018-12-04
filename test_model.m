%% Create NL model of the quadroto 

% initial state 
Xinit= zeros(12,1) ; 
Xinit(1) = 0 ; % x 
Xinit(2) = 0 ; % y 
Xinit(3) = 0 ; % z 
Xinit(4) = 0 ; % psi 
Xinit(5) = 0 ; % theta 
Xinit(6) = 0 ;% phi  
Xinit(7) = 0 ; % xdot 
Xinit(8) = 0 ; % ydot 
Xinit(9) = 0 ; %zdot 
Xinit(10) = 0 ; % p 
Xinit(11) = 0 ; % q 
Xinit(12) = 0 ; % r 


file_name = 'quadrotor_model';
Order = [12 4 12];
Parameters = [Ix Iy Iz m g];
InitialStates = Xinit ;

quadrotor_m = idnlgrey(file_name,Order,Parameters,InitialStates,0,'Name','quadrotor_model');
% quadrotor_m.OutputName = {'x','y','z','psi','theta'}
quadrotor_m.InputName = {'u1','u2','u3','u4'} ; 

