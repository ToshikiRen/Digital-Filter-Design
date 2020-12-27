function [H, w, filterOrder, deltaP_real, deltaS_real, error, found] =....
                filterDesign(Fp, Fs, deltaP, deltaS, Ts, Wn, wn_param, M)

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
        Fs = 1.1 * Fp; % Setting Fs to 1.1 * Fp Hz
        error{errorIndex} = ['Filter stop band frequency was not set. ' ....
                             'Setting Fs = 1.1 * Fp '];
        errorIndex = errorIndex + 1;
    elseif isempty(Fs)
        Fs = 1.1 * Fp; % Setting Fs to 1.1 * Fp Hz
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
   
    % TO DO: Add the part of the algorithm that searches for the solution
    
    Wc = pi * (Fp + Fs);
    wc = Wc * Ts;
    wp = 2 * pi * Fp * Ts;
    ws = 2 * pi * Fs * Ts;
    
    found = 0;
    
    filterOrder = 1; % Starting from an order 1 filter
    while filterOrder <= M 
        
        window = getWindow(Wn, filterOrder, wn_param);
        [b, a] = FIR(filterOrder, wc, Ts, window);

        [H, w] = freqz(b, a, 2048);
        [deltaP_filter, deltaS_filter] = returnMaxError(H, w, wp, ws);
      
        if checkError(deltaP_filter, deltaP, deltaS_filter, deltaS)
            deltaP_real = deltaP_filter;
            deltaS_real = deltaS_filter;
            error = truncateCellArray(error, errorIndex - 1);
            found = 1;
            return;
        end
        filterOrder = filterOrder + 1;
    end
    
    filterOrder = filterOrder - 1;
    
    deltaP_real = inf;
    deltaS_real = inf;
    error{errorIndex} = ['The filter with the required specifications '....
                    'could not be created.'];
    error = truncateCellArray(error, errorIndex);
end 