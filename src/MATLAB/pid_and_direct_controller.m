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
[k,poles] = rlocfind(C*P_pend)


%% 
T = feedback(P_pend,k*C);
t = 0:0.01:50;
impulse(T, t);

zero(T)
pole(T)

%% Input response to the cart:
T2 = feedback(P_pend,k*C)*P_cart;
t = 0:0.01:50;
impulse(T2, t);
title({'Response of Cart Position to an Impulse Disturbance';'under PID Control: Kp = 100, Ki = 1, Kd = 20'});


%% Stability 2nd loop:
rlocus(T2)
zero(T2)
pole(T2)


%% DT Inner Loop:
z = tf('z');
Tc = 0.02
Pz = dscrzoh(P, Tc)
Pz_cart = dscrzoh(P_cart, Tc)


zeros = zero(Pz)
poles = pole(Pz)

P_t = tf2sym(Pz)
P_t = iztrans(P_t)