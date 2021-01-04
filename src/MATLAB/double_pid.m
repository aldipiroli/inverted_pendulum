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
Kp = 10;
Ki = 1;
Kd = 1;
C = -pid(Kp,Ki,Kd);

rlocus(C*P_pend)

% %% Controller:
% C = -1/s
% rlocus(C*P_pend)



%% Find Gain
% [k,poles] = rlocfind(C*P_pend)
k =  33.1628


%% 
T = feedback(P_pend,k*C);
impulse(T)


%% Input response to the cart:
T2 = feedback(1,P_pend*k*C)*P_cart;
pole(T2)

t = 0:0.01:50;
impulse(T2, t);
title({'Response of Cart Position to an Impulse Disturbance';'under PID Control: Kp = 100, Ki = 1, Kd = 20'});


%% Stability 2nd loop:
rlocus(T2)
zero(T2)
pole(T2)


%% 2nd Controller:

Kp = -4;
Ki = 0
Kd = 0;
C2 = pid(Kp,Ki,Kd);
rlocus(C2*T2)

%% 
K2 = 0.0170
T3 = feedback(K2*C2*T2,1)

t = 0:0.01:50;
impulse(T3, t);
pole(T3)


% Kp = 7.27e+06;
% Ki = 2.51e+09;
% Kd = 5.27e+03;
% C2 = pid(Kp,Ki,Kd);
% 
% K2 = 1
% T3 = feedback(K2*C2*T2,1)
% impulse(T3)
% pole(T3)
% 
% 
% 
% %% 
% rlocus(C2*T2)
% % [k,poles] = rlocfind(C2*T2)
% % pole(T3)
% K2 = 1.0172
% 
% T3 = feedback(K2*C2*T2,1)
% 
% pole(T3)
% 
