% FILE: FIR.m
% 
% FUNCTION: FIR
% 
% CALL: [b, a] = FIR(order, wc, Ts, window, type)
% 
% The functions returns a FIR filter of type type and of order order and cutoff
% frequency wc with sampling period Ts using the window given by the vector window
% 
% INPUTS:
%         order   - filter order
%         wc      - cutoff frequency
%         Ts      - sampling period
%         window  - a vector with the window elements, the vector has size
%                     order + 1
%         type    - low or high, depending on what filter you want to create
% 
% OUTPUTS:
%         b - filter denominator coefficients
%         a - filter numerator coefficients
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021
function [b, a] = FIR(order, wc, Ts, window, type)

    if nargin < 1
        order = 16;
        disp('Order was not set. Set order to 16');
    elseif isempty(order)
        order = 16;
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

    if nargin < 4
        window = hamming(order + 1);
        disp('Window was not set. Default window used');
    elseif isempty(window)
        window = hamming(order + 1);
        disp('Window was left empty. Default window used');
    elseif numel(window) ~= order + 1
        window = hamming(order + 1);
        disp('Window of incorrect size. Default window used');
    end
    
    if nargin < 5
        disp('Missing type, default type = low');
        type = 'low';
    elseif isempty(type)
        disp('Empty type, default type = low');
        type = 'low';
    end
    
    
    
    switch type
        case 'low'
                
            hn = cardinalSinShifted(order + 1, wc, Ts);
            hn = hn(:);
            b =  hn .* window(:);
            % Norming 
            if sum(b) > 1e-10
                b = b./sum(b);
            end
        case 'high'
            hn = cardinalSinShifted(order + 1, pi - wc, Ts);
            hn = hn(:);
            b =  hn .* window(:);
            % Norming 
            if sum(b) > 1e-10
                b = b./sum(b);
            end
            
            b(2:2:end) = -b(2:2:end);
            
            
    end
    
    % b =  hn .* window(:);
    a = 1;
    


end