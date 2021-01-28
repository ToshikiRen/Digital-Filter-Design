% FILE: cardinalSinShifted
% 
% FUNCTION: cardinalSinShifted
%
% CALL: hn = cardinalSinShifted(M, wc, Ts)
% 
% Evaluates the sampled version of a continous sinc in M 
% points with the sampling period Ts
% 
% INPUTS:
%     M  - the length of the discrete sinc
%     wc - the cutoff "frequency"
%     Ts - sampling period
% 
% OUTPUTS:
%     hn - discrete cardinal sin 

% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021
% 
function hn = cardinalSinShifted(M, wc, Ts)

    if nargin < 1
        M = 16;
        disp('Order was not set. Set order to 16');
    elseif isempty(M)
        M = 16;
        disp('Order was left empty. Set order to 16');
    end

    if nargin < 2
        wc = 0.4 * pi;
        disp('Cutoff frequency was not set. Set wc to 0.4pi');
    elseif isempty(wc)
        wc = 0.4 * pi;
        disp('Cutoff frequency was left empty. Set wc to 0.4pi');
    end

    if nargin < 3
        disp('The sampling period was not set. Ts set to 1');
        Ts = 1;
    elseif isempty(Ts)
        disp('The sampling period was left empty. Ts set to 1');
        Ts = 1;
    end

    n = 0:M-1;
    hn = wc/(pi * Ts) * sin(wc*(n - (M-1)/2))./(wc*(n - (M-1)/2));
    if mod(M,2)
        hn((M-1)/2 + 1) = wc/(pi * Ts);
    end

end