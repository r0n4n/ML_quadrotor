%% Create NL model of the quadroto 

file_name = 'quadrotor_model';
Order = [12 4 12];
Parameters = [Ix Iy Iz m g];
InitialStates = Xinit ;

quadrotor_m = idnlgrey(file_name,Order,Parameters,InitialStates,0,'Name','quadrotor_model');
% quadrotor_m.OutputName = {'x','y','z','psi','theta'}
quadrotor_m.InputName = {'u1','u2','u3','u4'} ; 

