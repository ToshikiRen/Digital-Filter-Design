%% Initializations
clear all; clc; close all;

M = 16;
r = 89; 
L = 1.5;
beta = 8;
alfa = 0.65;


w = cell(9,1);
w{1} = boxcar(M);
w{2} = triang(M);
w{3} = blackman(M);
w{4} = chebwin(M, r);
w{5} = hamming(M);
w{6} = hanning(M);
w{7} = kaiser(M, beta);
w{8} = lanczos(M, L);
w{9} = tukeywin(M, alfa);

% Norming 

for i = 1:length(w)

    w{i} = w{i}./sum(w{i});

end

titles = {'Rectangular Window Frequency response',
         'Triangle Window Frequency response',
         'Blackman Window Frequency response',
         'Chebyshev Window Frequency response',
         'Hamming Window Frequency response',
         'Hanning Window Frequency response',
         'Kaiser Window Frequency response',
         'Lanczos Window Frequency response',
         'Tukey Window Frequency response'};
     
titles_time = {'Rectangular Window',
             'Triangle Window',
             'Blackman Window',
             'Chebyshev Window',
             'Hamming Window',
             'Hanning Window',
             'Kaiser Window',
             'Lanczos Window',
             'Tukey Window'};
     
     
%% Time response

figure;
for i = 1 : length(titles)
   
    subplot(3,3,i);
    stem(0:M-1, w{i});
    xlabel('Discrete Time');
    xlim([0, M-1]);
    title(titles_time{i});
    
end

%% GAIN
figure;
for i = 1 : length(titles)
   
    subplot(3,3,i);
    [H, omega] = freqz(w{i});
    plotGain(H, omega, titles{i});
    
end

%% DB GAIN     
figure;
for i = 1 : length(titles)
   
    subplot(3,3,i);
    [H, omega] = freqz(w{i});
    plotGainDB(H, omega, strcat(titles{i}, ' in dB'));
    
end
