%%
close all; clear all; clc;
 addpath("lib")
%% CT Plant Model:
s = tf('s');
m = 0.1;
M = 1.0;
l = 0.5;
g = 9.8;

P = 1/((-(l/3)*(m+4*M)*s^2)+ g*(m+M))
P_cart = 1/(s^2*(m+M))*(1 - (-m*l*s^2)/(-l/3*(m+4*M)*s^2 + g*(m+M)))



%% DT Plant Model:
z = tf('z');
Tc = 0.02
Pz = dscrzoh(P, Tc)
Pz_cart = dscrzoh(P_cart, Tc)


zeros = zero(Pz)
poles = pole(Pz)

P_t = tf2sym(Pz)
P_t = iztrans(P_t)
%% Direct Controller Values:
z1 = zeros(1)
p1 = poles(1)

syms d w1 w0
Wo = (d-z1)*( w1*d + w0)/d^3

eqn1 = 1-subs(Wo,d,p1) == 0
eqn2 = subs(Wo,d,1) == 0


sol = solve([eqn1,  eqn2], [w1 w0]);
w1_ = double(sol.w1)
w0_ = double(sol.w0)

Wo = (z-z1)*(w1_*z + w0_)/z^3

%% Compute Controller:
C = 1/Pz * Wo / (1-Wo)
C_t = tf2sym(C)
C_t = iztrans(C_t)

%% Close Loop Stability Analysis:
T = feedback(C*Pz, 1)
impulse(T)
% step(T)


%% Cart impulse response:
T2 = T*Pz_cart;
t = 0:0.01:50;
impulse(T2)
title({'Response of Cart Position to an Impulse Disturbance';'under PID Control: Kp = 100, Ki = 1, Kd = 20'});
