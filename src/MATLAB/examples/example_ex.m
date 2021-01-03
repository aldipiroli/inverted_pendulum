%% Clean
close all; clear all; clc;
 addpath("lib")

%% Plant
s = tf('s');
P_s = 1/s^2

T=1;
z = tf('z', T); 

Pd_z = dscrzoh(P_s, T)

%% Open Loop Analysis:
impulse(Pd_z)

%% Direct controller:
syms d w1 w0

Wo = (d+1)*(w1*d + w0)/d^4
Wo_d = (w1*d*(d+2) + w0*(2*d+3))/(d^4)

eqn1 = 1-subs(Wo,d,1) == 0
eqn2 = subs(Wo_d,d,1)

sol = solve([eqn1, eqn2], [w1 w0]);
w1_ = double(sol.w1)
w0_ = double(sol.w0)

Wo = (z+1)*(w1_*z + w0_)/z^3

%% Controller:
C = 1/Pd_z * Wo / (1-Wo)


%% Close Loop Stability Analysis:
T = feedback(C*Pd_z, 1)
impulse(T)
step(T)