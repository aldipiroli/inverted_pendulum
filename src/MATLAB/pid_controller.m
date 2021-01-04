%%
close all; clear all; clc;
addpath("lib")
%% CT Plant Model:
s = tf('s');
m = 0.1;
M = 1.0;
l = 0.5;
g = 9.8;

P_pend = 1/((-(l/3)*(m+4*M)*s^2)+ g*(m+M))
P_cart = 1/(s^2*(m+M))*(1 - (-m*l*s^2)/(-l/3*(m+4*M)*s^2 + g*(m+M)))

%% PID Controller: 
Kp = 30;
Ki = 5;
Kd = 5;
C = -pid(Kp,Ki,Kd);

rlocus(C*P_pend)

% %% Controller:
% C = -1/s
% rlocus(C*P_pend)



%% Find Gain
[k,poles] = rlocfind(C*P_pend)

%% 
T = feedback(P_pend,k*C);

impulse(T)


%% Input response to the cart:
T2 = feedback(1,P_pend*k*C)*P_cart;
pole(T2)

t = 0:0.01:50;
impulse(T2, t);
title({'Response of Cart Position to an Impulse Disturbance';'under PID Control: Kp = 100, Ki = 1, Kd = 20'});


%% 
rlocus(T2)