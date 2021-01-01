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
C = (s+10)/(s+5)
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