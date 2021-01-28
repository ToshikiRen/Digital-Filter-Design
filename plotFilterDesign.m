% FILE: plotFilterDesign.m
% 
% FUNCTION: plotFilterDesign
% 
% CALL: [deltaP_real, deltaS_real, error] =....
%    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, plots)
% 
% Returns the impulse response of the best filter with passband frequency Fp
% and stopband frequency Fs, with sampling period Ts with order less than M
% and which respects the passband deltaP and stopband deltaS constraints for
% a given window
% 
% INPUTS:
%         Fp          - passband frequency
%         Fs          - stopband frequency
%         deltaP      - passband constraint
%         deltaS      - stopband constraint
%         Ts          - sampling period 
%         Wn          - window name
%         wn_param    - window extra parameter
%         M           - max order for the designed filter
%         plots       - the type of plots ploted, must be of of the
%                       values in {classic, dB, phase}
%         
% VALUES FOR Wn must be one of those bellow:
%           boxcar   
%           triang  
%           blackman  
%           chebwin  
%           hamming
%           hanning
%           kaiser
%           lanczos
%           tukeywin
% 
%
% OUTPUTS:
%         deltaP_real - filter passband error
%         deltaS_real - filter stopband error
%         error       - error while designing the filter
%        
% 
% USES: 
%         getWindow
%         FIR
%         checkError
%         returnMaxError
%         truncateCellArray
%         filterDesign
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021


function [deltaP_real, deltaS_real, error] =....
    plotFilterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, plots)



    error = cell(20, 1); % maximum number of errors
    errorIndex = 1; % error index starts at 1
    if nargin < 1
        Fp = 1000; % Setting Fp to 1000 Hz
        error{errorIndex} = ['Filter pass frequency was not set. ' ....
                             'Setting Fp = 1000 Hz'];
        errorIndex = errorIndex + 1;

    elseif isempty(Fp)
        Fp = 1000; % Setting Fp to 1000 Hz
        error{errorIndex} = ['Filter pass frequency was left empty. ' ....
                             'Setting Fp = 1000 Hz'];
        errorIndex = errorIndex + 1;
    end

    if nargin < 2
        Fs = 1.1 * Fp; % Setting Fp to 1000 Hz
        error{errorIndex} = ['Filter stop band frequency was not set. ' ....
                             'Setting Fs = 1.1 * Fp '];
        errorIndex = errorIndex + 1;
    elseif isempty(Fs)
        Fs = 1.1 * Fp; % Setting Fp to 1000 Hz
        error{errorIndex} = ['Filter stop band frequency was left empty. ' ....
                             'Setting Fs = 1.1 * Fp'];
        errorIndex = errorIndex + 1;
    end

    if nargin < 3
        deltaP = 5;
        error{errorIndex} = ['Filter passband error was not set. ' ....
                             'Setting  deltaP = 5% '];
        errorIndex = errorIndex + 1;
    elseif isempty(deltaP)
            deltaP = 5;
        error{errorIndex} = ['Filter passband error was left empty. ' ....
                             'Setting  deltaP = 5% '];
        errorIndex = errorIndex + 1;
    end

    if nargin < 4
        deltaS = 5;
        error{errorIndex} = ['Filter stopband error was not set. ' ....
                             'Setting  deltaS = 5% '];
        errorIndex = errorIndex + 1;
    elseif isempty(deltaS)
            deltaS = 5;
        error{errorIndex} = ['Filter stopband error was left empty. ' ....
                             'Setting  deltaS = 5% '];
        errorIndex = errorIndex + 1;
    end


    if nargin < 5
        Ts = 2/(2.1 * (Fs + Fp));
        error{errorIndex} = ['Filter sampling period was not set. ' ....
                             'Setting  Ts = 2/(2.1 *(Fs + Fp)) '];
        errorIndex = errorIndex + 1;
    elseif isempty(Ts)

        Ts = 2/(2.1 * (Fs + Fp));
        error{errorIndex} = ['Filter sampling period was left empty. ' ....
                             'Setting  Ts = 2/(2.1 *(Fs + Fp)) '];
        errorIndex = errorIndex + 1;

    end

    if nargin < 6
        Wn = 'hamming';
        error{errorIndex} = ['Filter window was not set. ' ....
                             'Setting  Wn = hamming '];
        errorIndex = errorIndex + 1;
    elseif isempty(Wn)
        Wn = 'hamming';
        error{errorIndex} = ['Filter window was left empty. ' ....
                             'Setting  Wn = hamming '];
        errorIndex = errorIndex + 1;
    end

    if checkType(Wn, [4, 7, 8, 9])
        if nargin < 7 
            wn_param = setParamFor(Wn);
            error{errorIndex} = ['Filter window extra parameter was not set. ' ....
                                 'Setting  wn_param = ' num2str(wn_param)];
            errorIndex = errorIndex + 1;
            
        elseif isempty(wn_param)
            wn_param = setParamFor(Wn);
            error{errorIndex} = ['Filter window extra parameter was left empty. ' ....
                                 'Setting  wn_param = ' num2str(wn_param)];
            errorIndex = errorIndex + 1;

        end
        if wn_param < 0
            wn_param = setParamFor(Wn);
            error{errorIndex} = ['Filter window extra parameter negative. ' ....
                                 'Setting  wn_param = ' num2str(wn_param)];
            errorIndex = errorIndex + 1;
        end
    else
        wn_param = 0; % We're setting it so we don't get an error later
    end
    
    if nargin < 8
        M = 128;
        error{errorIndex} = ['Maximum order was not set. Set max order to 128'];
        errorIndex = errorIndex + 1;
    elseif isempty(M)
        M = 128;
        error{errorIndex} = ['Maximum order was left empty. Set max order to 128'];
        errorIndex = errorIndex + 1;
    end
  
    if nargin < 9
        plots = {'dB'};
        error{errorIndex} = ['Plot type missing. Set to dB only'];
        errorIndex = errorIndex + 1;
    elseif isempty(plots)
        plots = {'dB'};
        error{errorIndex} = ['Plot type is empty. Set to dB only'];
        errorIndex = errorIndex + 1;
    end
% ---------------------------------------------------------------------- %
    
    error = truncateCellArray(error, errorIndex-1);
    
    [b, a, filterOrder, deltaP_real, deltaS_real, ~, found] = ...
    filterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M);

    [H, w] = freqz(b, a, 2048); 
    if found
        for i = 1:numel(plots)
            switch plots{i}
                case 'classic'
                    figure;
                    plotGain(H, w, [upper(Wn(1)) Wn(2:end) ' Window Filter GAIN']);
                    line([0, 2*pi * Fp * Ts], [1+deltaP/100,1+deltaP/100],....
                        'Color', 'c', 'LineWidth', 1.5);
                    line([0, 2*pi * Fp * Ts], [1-deltaP/100,1-deltaP/100],....
                        'Color', 'c', 'LineWidth', 1.5);
                    line([2*pi * Fs * Ts, pi], [deltaS/100,deltaS/100],....
                        'Color', 'm', 'LineWidth', 1.5);
                    legend(['Order = ' num2str(filterOrder)]);
                case 'dB'
                    figure;
                    plotGainDB(H, w, [upper(Wn(1)) Wn(2:end) ' Window Filter GAIN in dB']);
                    
%                     line([0, 2*pi * Fp * Ts], [20*log10(1+deltaP/100),....
%                         20*log10(1+deltaP/100)], 'Color', 'c', 'LineWidth', 1.5);
%                     line([0, 2*pi * Fp * Ts], [20*log10(1-deltaP/100),....
%                         20*log10(1-deltaP/100)], 'Color', 'c', 'LineWidth', 1.5);
%                     line([2*pi * Fs * Ts, pi], [20*log10(deltaS/100),....
%                         20*log10(deltaS/100)], 'Color', 'm', 'LineWidth', 1.5);
                    legend(['Order = ' num2str(filterOrder)]);
                case 'phase'
                    figure;
                    plotPhase(H, w, [upper(Wn(1)) Wn(2:end) ' Window Filter phase']);
                    legend(['Order = ' num2str(filterOrder)]);
            end
        end
    else
        disp('Filter with the required specs could not be found');
    end
    
end