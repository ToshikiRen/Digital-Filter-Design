%% Running FIR on all the windows

% Initializations
clear all; clc; close all;

M = 20;
Ts = 1;

r = 89; 
L = 1.5;
beta = 8;
alfa = 0.65;

wn_param = [r, beta, L, alfa];

[w, titles] = getWindowName();     


%% Filter response M = 20 

wc = 0.05 * pi; 
M = 20;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

% Having a small wc, closer to 0 means we're pushing the oscilations in the
% stopband of the filter

%% Filter response M = 20 

wc = 0.98 * pi; 
M = 20;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

% Having a higher wc, closer to pi means the oscilations from the stopband
% go to the passband 


%% Ranking Filters
clc; clear all; close all;

wp = 0.10 * pi;
ws = 0.20 * pi;

Ts = 1/44100;

% Passband and stopband frequency
Fp = wp/(2*pi*Ts);
Fs = ws/(2*pi*Ts);


% The variables below are in %'s 1 = 1%
deltaP = 10;
deltaS = 10;

% Window parameters
r = 80; 
L = 1.2;
beta = 7;
alfa = 0.85;
wn_param = [r, beta, L, alfa];

% Set filter max order
M = 20;

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
    if ~rankingStruct(i).validResult
        title([Wn ' DOES NOT SATISFY CONSTRAINTS']);
    end
end

%% DB GAIN     
figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    if rankingStruct(i).validResult
        Wn = rankingStruct(i).windowName;
        Wn = [upper(Wn(1)) Wn(2:end)];
        H = rankingStruct(i).H;
        omega = rankingStruct(i).w;
        plotGainDB(H, omega, [Wn ' frequency response in dB']);
    end
end
%% Phase

figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    
    if rankingStruct(i).validResult
        Wn = rankingStruct(i).windowName;
        Wn = [upper(Wn(1)) Wn(2:end)];
        H = rankingStruct(i).H;
        omega = rankingStruct(i).w;
        plotPhase(H, omega, [Wn ' frequency response phase']);
    end
end            
            