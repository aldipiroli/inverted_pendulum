%%
close all; clear all; clc;

%% Define Model:

M = 1.0;
m = 0.1;
l = 0.3;
b = 0;
I = 1/3*m*l^2;
g = 9.8;
q = (M+m)*(I+m*l^2)-(m*l)^2;
s = tf('s');

P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);

P_pend = (m*l*s/q)/(s^3 + (b*(I + m*l^2))*s^2/q - ((M + m)*m*g*l)*s/q - b*m*g*l/q);


sys_tf = [P_cart; P_pend]

inputs = {'u'};
outputs = {'x'; 'phi'};

set(sys_tf,'InputName',inputs)
set(sys_tf,'OutputName',outputs)

sys_tf

%% Open-Loop Impulse Response:
t=0:0.01:1;
impulse(sys_tf,t);
title('Open-Loop Impulse Response')


%% Zeros and Poles of the open loop:

[zeros poles] = zpkdata(P_pend,'v')
[zeros poles] = zpkdata(P_cart,'v')

%% Open loop step response:
t = 0:0.05:10;
u = ones(size(t));
[y,t] = lsim(sys_tf,u,t);
plot(t,y)
title('Open-Loop Step Response')
axis([0 3 0 50])
legend('x','phi')

% System Infos given the step response:
step_info = lsiminfo(y,t);
cart_info = step_info(1)
pend_info = step_info(2)

%% Root locus plot:
rlocus(P_pend)
title('Root Locus of Plant ')
zeros = zero(P_pend)
poles = pole(P_pend)


%% Controller:
% z = [];
% p = [];
% k = 1;
% C = zpk(z,p,k);
Kp = 100;
Ki = 1;
Kd = 30;
C = pid(Kp,Ki,Kd);
T = feedback(P_pend,C);
step(T)

% rlocus(C*P_pend)
Plant = P_pend


%% Impulse response Close Loop Pendulum:
% K = 5.64e4;
T = feedback(P_pend,K*C);
impulse(T)
title('Impulse Disturbance Response of Pendulum Angle under PID Control');



%% Impulse response Close Loop Cart:
C = C*K
P_cart = (((I+m*l^2)/q)*s^2 - (m*g*l/q))/(s^4 + (b*(I + m*l^2))*s^3/q - ((M + m)*m*g*l)*s^2/q - b*m*g*l*s/q);
T2 = feedback(1,P_pend*C)*P_cart;
T2 = minreal(T2);
t = 0:0.01:10;
impulse(T2, t), grid
title({'Response of Cart Position to an Impulse Disturbance';'under Closed-loop Control'});

