% 
% FILE: returnMaxError.m
% 
% FUNCTION: returnMaxError
% 
% CALL: [deltaP_max, deltaS_max] = returnMaxError(H, w, wp, ws, type)
% 
% Returns the maximum passband error and the maximum stopband error
% for a given filter
% 
% INPUTS:
%         H    - filter frequency response
%         w    - filter frequency response frequency values
%         wp   - passband frequency
%         ws   - stopband frequency
%         type - filter type, it can be low or high
%         
% OUTPUTS:
%         deltaP_max - max error in the passband
%         deltaS_max - max error in the stopband
% 
%
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021

function [deltaP_max, deltaS_max] = returnMaxError(H, w, wp, ws, type)

    
    if nargin < 1
        disp('FIR response is missing');
        return;
    elseif isempty(H)
        disp('FIR response is empty');
        return;
    end
    if nargin < 2
        disp('Frequnecy vector missing.');
        return;
    elseif isempty(w)
        disp('Frequnecy vector is empty.');
        return;
    end
    
    if nargin < 3
        disp('Passband frequency missing');
        return;
    elseif isempty(wp)
        disp('Passband frequency is empty');
        return;
    end
   
    if nargin < 4
        disp('Stopband frequency missing');
        return;
    elseif isempty(ws)
        disp('Stopband frequency is empty');
        return;
    end
    
    if nargin < 5
        type = 'low';
    end
    if isempty(type)
        type = 'low';
    end
    
    if strcmp(type,'low') 
        H = abs(H); % Getting filter amplitude
        H_passband = H(w <= wp); % Extract amplitude of passband
        H_passband = H_passband - 1; % Center around 0
        H_stopband = H(w >= ws); % Extract amplitude of stopband
    else
        H = abs(H); % Getting filter amplitude
        H_passband = H(w >= wp); % Extract amplitude of passband
        H_passband = H_passband - 1; % Center around 0
        H_stopband = H(w <= ws); % Extract amplitude of stopband
    end
    
    deltaP_max = max(abs(H_passband)) * 100;
    deltaS_max = max(abs(H_stopband)) * 100;
    
    if isempty(deltaP_max)
        deltaP_max = 100;
    end
    if isempty(deltaS_max)
        deltaS_max = 100;
    end
    
    
end