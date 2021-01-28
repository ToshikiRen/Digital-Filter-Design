
% FILE: rankFilters.m
% 
% FUNCTION: rankFilters
% 
% CALL: [rankingFilters, tableRank, error] =....
%    rankFilters(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, type)
% 
% Returns the best filters with passband frequency Fp and stopband frequency Fs,
% with sampling period Ts with order less than M and which respects the passband
% deltaP and stopband deltaS constraints for a all 9 windows 
% 
%
% INPUTS:
%         Fp          - passband frequency
%         Fs          - stopband frequency
%         deltaP      - passband constraint
%         deltaS      - stopband constraint
%         Ts          - sampling period 
%         Wn          - window names, a vector with the names for the used
%                       windows
%         wn_param    - window extra parameters for the windows
%         M           - max order for the designed filter
%         type        - low or high pass filters
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
%         rankingFilters  - filter orderd by order and the sum of
%                               the errors
%         tableRank       - filter orderd by the above criteria and
%                               returned as a table
%         error           - will be used in a future release
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


function [rankingFilters, tableRank, error] =....
    rankFilters(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M, type)

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
        Wn = getWindowName();
        error{errorIndex} = ['Filter windows were not set. ' ....
                             'Setting  Wn = all 9 windows '];
        errorIndex = errorIndex + 1;
    elseif isempty(Wn)
        Wn = getWindowName();
        error{errorIndex} = ['Filter windows were left empty. ' ....
                             'Setting  Wn = all 9 windows '];
        errorIndex = errorIndex + 1;
    end

    
    if nargin < 7 
       wn_param = setDefaultParamsForAllWindows(Wn);
        error{errorIndex} = ['Filter windows extra parameters were not set. ' ....
                             'Setting  wn_param = default values'];
        errorIndex = errorIndex + 1;
    elseif isempty(wn_param)
        wn_param = setDefaultParamsForAllWindows(Wn);
        error{errorIndex} = ['Filter windows extra parameters were left empty. ' ....
                             'Setting  wn_param = default values '];
        errorIndex = errorIndex + 1;
    end

    
    if nargin < 8
        M = 512;
        error{errorIndex} = ['Maximum order was not set. Set max order to 512'];
        errorIndex = errorIndex + 1;
    elseif isempty(M)
        M = 512;
        error{errorIndex} = ['Maximum order was left empty. Set max order to 512'];
        errorIndex = errorIndex + 1;
    end
    
    if nargin < 9
        type = 'low';
    end
    if isempty(type)
        type = 'low';
    end
% ---------------------------------------------------------------------- %
    
    error = truncateCellArray(error, errorIndex - 1);
    param_index = 1;
    rankingFilters = [];
    for i = 1:numel(Wn)
       
        if checkType(Wn{i}, [4, 7, 8, 9])
            [b, a, filterOrder, deltaP_real, deltaS_real, error, found] = ...
                filterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn{i}, wn_param(param_index), M, type);
            param_index = param_index + 1;
        else
            [b, a, filterOrder, deltaP_real, deltaS_real, error, found] = ...
                filterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn{i}, wn_param(param_index), M, type);
        end 
        
        [H, w] = freqz(b, a, 2048);
        
        currentFilter.b = b;
        currentFilter.a = a;
        currentFilter.windowName = Wn{i};
        currentFilter.filterOrder = filterOrder;
        currentFilter.deltaP = deltaP_real;
        currentFilter.deltaS = deltaS_real;
        currentFilter.error = error;
        currentFilter.validResult = found;
        currentFilter.sumErrors = deltaP_real + deltaS_real;
        rankingFilters = [rankingFilters currentFilter];
    end
    
    tableRank = struct2table(rankingFilters);
    tableRank = sortrows(tableRank, {'filterOrder', 'sumErrors'});
    tableRank = tableRank(:, 1:end-1);
    
    rankingFilters = table2struct(tableRank);
    
end