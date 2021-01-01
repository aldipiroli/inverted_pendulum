%%
close all; clear all; clc;

%% 
% syms s
% K = 60
% F = (s+1)*(s+2)/s;
% ilaplace(F)

    syms z

T = ( 0.0003643*z^3 - 0.0003338*z^2 + 6.688e-05*z + 4.614e-06) / (z^4 - 0.5713*z^3 + 0.08497*z^2 - 0.00385*z + 4.54e-05)

F = 2*z/(z-2)^2;
iztrans(F)