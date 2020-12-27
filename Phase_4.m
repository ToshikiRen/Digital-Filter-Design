clc; clear all; close all;
wp = 0.45 * pi;
ws = 0.5 * pi;

% Sampling period
Ts = 1/44100;

% Passband and stopband frequency
Fp = wp/(2*pi*Ts);
Fs = ws/(2*pi*Ts);

% The variables below are in %'s 1 = 1%
deltaP = 5;
deltaS = 5;

% Window parameters
r = 89; 
L = 1.5;
beta = 8;
alfa = 0.65;
wn_param = [r, beta, L, alfa];

% Set filter max order
M = 512;

[Wn, titles] = getWindowName();

[rankingStruct, tableRanking, err] = ....
                rankFilters(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M);


%% GAIN
figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    Wn = rankingStruct(i).windowName;
    Wn = [upper(Wn(1)) Wn(2:end)];
    H = rankingStruct(i).H;
    omega = rankingStruct(i).w;
    plotGain(H, omega, [Wn ' frequency response']);
    
end

%% DB GAIN     
figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    Wn = rankingStruct(i).windowName;
    Wn = [upper(Wn(1)) Wn(2:end)];
    H = rankingStruct(i).H;
    omega = rankingStruct(i).w;
    plotGainDB(H, omega, [Wn ' frequency response in dB']);
    
end
%% Phase

figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    Wn = rankingStruct(i).windowName;
    Wn = [upper(Wn(1)) Wn(2:end)];
    H = rankingStruct(i).H;
    omega = rankingStruct(i).w;
    plotPhase(H, omega, [Wn ' frequency response phase']);
    
end            
            