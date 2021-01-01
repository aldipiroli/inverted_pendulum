%%
close all; clear all; clc;

%% 
s = tf('s');
m = 0.1;
M = 1.0;
l = 0.5;
g = 9.8;

P_pend = 1/(-4/3 *m*l*s^2 + g*(m+M))

%% 
pole(P_pend)
rlocus(P_pend)

%% Controller:
% Kp = 1;
% Ki = 0;
% Kd = 1;
% C = pid(Kp,Ki,Kd);

C = s+1/((s-1)*(s-2))
T = P_pend*C;
rlocus(T)

%% Open loop step response:
impulse(P_pend)