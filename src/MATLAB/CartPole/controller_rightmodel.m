%%
close all; clear all; clc;

%% 
s = tf('s');
m = 0.1;
M = 1.0;
l = 0.5;
g = 9.8;

P_pend = 1/((-(l/3)*(m+4*M)*s^2)+ g*(m+M))

[p,z] = pzmap(P_pend)
rlocus(P_pend)

%% Find controller
C = -1
rlocus(C*P_pend)
title('Root Locus with Integral Control')



%% Find Gain
[k,poles] = rlocfind(C*P_pend)


%% Close loop stability
K = 1.5858;
T = feedback(P_pend,K*C);
impulse(T)
title('Impulse Disturbance Response of Pendulum Angle under PID Control');

%% Open loop step response:
impulse(P_pend)


%% Desired TF:
W = 1/(s+1)
Wz = c2d(W,0.1)
step(Wz)


%% Z Transform Plant:
Tc = 0.1
Pz = c2d(P_pend, Tc)

p = pole(Pz)
z1 = zero(Pz)

p1 = p(1)

%% Digital Controller:
z = tf('z');
ps = -1
w1 = 2/(1+p1)
w0 = (p1-1)/(p1+1)

Wo = ((z-z1)*(w1*z + w0))/(z^3)
C = 1/Pz * (Wo)/(1-Wo)

T = feedback(1,Pz*C)

impulse(T)

sys z