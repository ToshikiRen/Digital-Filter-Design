clc; clear all; close all;

wp = 0.4 * pi;
ws = 0.5 * pi;

% Sampling period
Ts = 1/44100;

% Passband and stopband frequency
Fp = wp/(2*pi*Ts);
Fs = ws/(2*pi*Ts);

% The variables below are in %'s 1 = 1%
deltaP = 5;
deltaS = 5;



%% Testing windows
M = 256;
Wn = 'chebwin'; % Window name, set it equal to the function that generates the window
wn_param = -1; % Set it if you want to use one of the windows that require 
% one more parameter!

[deltaP_real, deltaS_real, error] =....
    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, {'dB', 'phase'}); 
if numel(error)
    disp(error);
end
