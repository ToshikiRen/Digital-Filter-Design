%% Running FIR on all the windows

% Initializations
clear all; clc; close all;

M = 20;
Ts = 1;

% r = {80, 100} cheb
% beta = {0, 10} kaiser
% L = {0, 3} lanczos
% alfa = {0, 100%} tukey

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

wc = 0.5 * pi; 
M = 20;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

%% Filter response M = 20 

wc = 0.90 * pi; 
M = 20;
plotWindowFIRResponse(w, titles, M, wc, Ts, wn_param);

% Having a higher wc, closer to pi means the oscilations from the stopband
% go to the passband 


%% Ranking Filters
clc; clear all; close all;

type = 'low'
if strcmp(type, 'low')
    wp = 0.5 * pi;
    ws = 0.7 * pi;
else
    wp = 0.7 * pi;
    ws = 0.5 * pi;
end
Ts = 1/44100;

% Passband and stopband frequency
Fp = wp/(2*pi*Ts);
Fs = ws/(2*pi*Ts);


% The variables below are in %'s 1 = 1%
deltaP = 4;
deltaS = 4;
% 15% => boxcar of order 17

% Window parameters
r = 29; 
L = 1.1;
beta = 2;
alfa = 0.85;
wn_param = [r, beta, L, alfa];

% Set filter max order
M = 20;

[Wn, titles] = getWindowName();

[rankingStruct, tableRanking, err] = ....
                rankFilters(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, type);
disp(tableRanking);

%% GAIN
figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    Wn = rankingStruct(i).windowName;
    Wn = [upper(Wn(1)) Wn(2:end)];
    [H, omega] = freqz(rankingStruct(i).b, 1, 2048);

    plotGain(H, omega, [Wn ' frequency response '....
        'Order = ' num2str(rankingStruct(i).filterOrder)]);
    if strcmp(type, 'low')
        line([0, wp], [1+deltaP/100,1+deltaP/100],....
            'Color', 'c', 'LineWidth', 1.5);
        text(wp/2, 1+deltaP/50, '1 + \Delta_p');
        line([0, wp], [1-deltaP/100,1-deltaP/100],....
            'Color', 'c', 'LineWidth', 1.5);
        text(wp/2, 1-deltaP/50, '1 - \Delta_p');
        line([ws, pi], [deltaS/100,deltaS/100],....
            'Color', 'm', 'LineWidth', 1.5);
        text((pi + ws)/2, deltaS/50, '\Delta_s');
    else
        line([wp, pi], [1+deltaP/100,1+deltaP/100],....
            'Color', 'c', 'LineWidth', 1.5);
        text((pi+wp)/2, 1+deltaP/50, '1 + \Delta_p');
        line([wp, pi], [1-deltaP/100,1-deltaP/100],....
            'Color', 'c', 'LineWidth', 1.5);
        text((pi+wp)/2, 1-deltaP/50, '1 - \Delta_p');
        line([0, ws], [deltaS/100,deltaS/100],....
            'Color', 'm', 'LineWidth', 1.5);
        text(ws/2, deltaS/50, '\Delta_s');
    end
   
    
    if ~rankingStruct(i).validResult
        title([Wn ' DOES NOT SATISFY CONSTRAINTS']);
    end
end


%% DB GAIN     
figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    
    Wn = rankingStruct(i).windowName;
    Wn = [upper(Wn(1)) Wn(2:end)];
    [H, omega] = freqz(rankingStruct(i).b, 1, 2048);
    
    plotGainDB(H, omega, [Wn ' frequency response in dB']);
    legend(['Order = ' num2str(rankingStruct(i).filterOrder)]);
    if ~rankingStruct(i).validResult
        title([Wn ' DOES NOT SATISFY CONSTRAINTS']);
    end  
    
end
%% Phase
% The phase is LINEAR
% TO CHECK CALL: islinphase(rankingStruct(1).b, 123)
figure;
for i = 1 : length(rankingStruct)
   
    subplot(3,3,i);
    Wn = rankingStruct(i).windowName;
    Wn = [upper(Wn(1)) Wn(2:end)];
    [H, omega] = freqz(rankingStruct(i).b, 1, 2048);

    plotPhase(H, omega, [Wn ' frequency response phase']);
    legend(['Order = ' num2str(rankingStruct(i).filterOrder)]);

    if ~rankingStruct(i).validResult
        title([Wn ' DOES NOT SATISFY CONSTRAINTS']);
    end 
end               
            