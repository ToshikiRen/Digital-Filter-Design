%% Initializations
clear all; clc; close all;

M = 16;
Ts = 1;
wc = 0.4 * pi;

r = 89; 
L = 1.5;
beta = 8;
alfa = 0.65;

wn_param = [r, beta, L, alfa];

[w, titles] = getWindowName();     


%% Filter response M = 16

M = 16;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

%% Filter response M = 24

M = 24;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

%% Filter response M = 32

M = 32;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

%% Filter response M = 128

M = 128;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);
