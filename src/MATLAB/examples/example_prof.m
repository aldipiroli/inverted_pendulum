 addpath("lib")

%% Sintesi diretta deadbeat
%% con illustrazione del fenomeno delle oscillazioni interperiodo
%% causate dagli zeri risonanti

clear all;
close all;

% Definizione operatore s
s = tf('s');

% Ritardo
tau = 1;
% Funzione di trasferimento dell'impianto
mydisp('Impianto');
P_s = exp(-tau*s)/(15*s^2+8*s+1)


% Passo di campionamento
T=1;
z = tf('z', T); % Funzione di trasferimento dell'operatore z con passo T
% Equivalente campionato con ZOH
mydisp('Equivalente campionato con ZOH');
Pd_z = dscrzoh(P_s, T)


% % CASO 1: nessuna inclusione dello zero risonante negli zeri di w0
mydisp('CASO 1: nessuna inclusione dello zero risonante negli zeri di w0');
% f.d.t. ad anello chiuso desiderata
mydisp('F.d.t. ad anello chiuso desiderata');
w0 = 1/z^2


% Calcolo controllore
mydisp('Controllore digitale')
C_z = cdir(Pd_z, w0)


% Risposta al gradino sistema di controllo digitale
% Tempo fine simulazione
StopTime= 20;
% Ampiezza rif.
u0=1;
mydisp('Risposta al gradino sistema di controllo digitale');
% Simulazione modello Simulink
sim gendig;
% Grafico uscita
figure;
plot(y.time, y.signals.values);
ylabel('Risposta al gradino');
% Grafico comando
figure;
stairs(u.time, u.signals.values);
ylabel('Comando');



% % CASO 2: inclusione dello zero risonante negli zeri di w0
mydisp('CASO 2: inclusione dello zero risonante negli zeri di w0');
[zz, pp, kp] = zpkdata(Pd_z); % Estrae zeri di Pd_z in zz
w1 = zpk(zz, [0 0 0], 1, T); % Imposta w1 con zeri pari a zz e tre poli in 0
mydisp('F.d.t. ad anello chiuso desiderata');
w0 = w1 / evalfr(w1, 1) % Impone la condizione che 1 - w0(1)=0


% Calcolo controllore
mydisp('Controllore digitale')
C_z = cdir(Pd_z, w0)


% Risposta al gradino sistema di controllo digitale
% Tempo fine simulazione
StopTime= 20;
% Ampiezza rif.
u0=1;
mydisp('Risposta al gradino sistema di controllo digitale');
% Simulazione modello Simulink
sim gendig;
% Grafico uscita
figure;
plot(y.time, y.signals.values);
ylabel('Risposta al gradino');
% Grafico comando
figure;
stairs(u.time, u.signals.values);
ylabel('Comando');