%% Intégration de xdot et pdot :
clear all;
close all;
clc;

% y est une combinaison de x et de p => dimension 24
% 
p = sobolset(12);
y0 = [0;0;1;0;0;0;0;0;0;0;0;0];
y0 = cat(1,y0,(p(2,:))');
tspan = [0;0.05;1];

[tv1,yv1] = ode45(@(t,y) funx(t,y),tspan,y0);