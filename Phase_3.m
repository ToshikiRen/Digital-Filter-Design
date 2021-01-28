clc; clear all; close all;

wp = 0.3 * pi;
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
% r = {80, 100} cheb
% beta = {0, 10} kaiser
% L = {0, 3} lanczos
% alfa = {0, 100%} tukey

Wn = 'chebwin'; % Window name, set it equal to the function that generates the window
wn_param = 90; % Set it if you want to use one of the windows that require 
% one more parameter!

%plots = {'classic','dB', 'phase'};
plots = {'classic','dB'};
[deltaP_real, deltaS_real, error] =....
    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, plots); 
if numel(error)
    disp(error);
end
%% Testing windows
M = 256;
% r = {80, 100} cheb
% beta = {0, 10} kaiser
% L = {0, 3} lanczos
% alfa = {0, 100%} tukey

Wn = 'kaiser'; % Window name, set it equal to the function that generates the window
wn_param = 8; % Set it if you want to use one of the windows that require 
% one more parameter!

[deltaP_real, deltaS_real, error] =....
    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, plots); 
if numel(error)
    disp(error);
end
%% Testing windows
M = 256;
% r = {80, 100} cheb
% beta = {0, 10} kaiser
% L = {0, 3} lanczos
% alfa = {0, 100%} tukey

Wn = 'lanczos'; % Window name, set it equal to the function that generates the window
wn_param = 2; % Set it if you want to use one of the windows that require 
% one more parameter!

[deltaP_real, deltaS_real, error] =....
    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, plots); 
if numel(error)
    disp(error);
end
%% Testing windows
M = 256;
% r = {80, 100} cheb
% beta = {0, 10} kaiser
% L = {0, 3} lanczos
% alfa = {0, 100%} tukey

Wn = 'boxcar'; % Window name, set it equal to the function that generates the window
wn_param = 90; % Set it if you want to use one of the windows that require 
% one more parameter!

[deltaP_real, deltaS_real, error] =....
    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, plots); 
if numel(error)
    disp(error);
end