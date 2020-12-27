function [] = plotWindowFIRResponse(w, titles, order, wc, Ts, wn_param)

    if nargin < 1
        disp('No window names detected. Setting default data windows.')
        [w, ~] = getWindowName();
    elseif isempty(w)
        disp('Empty window names. Setting default data windows.')
        [w, ~] = getWindowName();
    end
    
    if nargin < 2
        disp('Titles missing. Setting titles to default.');
        [~, titles] = getWindowName();
    elseif isempty(titles)
        disp('Titles found empty. Setting titles to default.');
        [~, titles] = getWindowName();
    end
    
    if nargin < 3
        disp('Order missing. Set default order to 16');
        order = 16;
    elseif isempty(order)
        disp('Order empty. Set default order to 16');
        order = 16;
    end
    
    if nargin < 4
        wc = 0.4 * pi;
        disp('Cutoff frequency missing. Set wc to 0.4pi.');
    elseif isempty(wc)
        wc = 0.4 * pi;
        disp('Cutoff frequency left empty. Set wc to 0.4pi.');
    end
    
    if nargin < 5
        disp('Sampling period missing. Set Ts = 1.');
        Ts = 1;
    elseif isempty(Ts) 
        disp('Sampling period empty. Set Ts = 1.');
        Ts = 1;
    end
    if nargin < 6
        wn_param = setDefaultParamsForAllWindows(w);
    elseif isempty(wn_param)
        wn_param = setDefaultParamsForAllWindows(w);
    end
    
    % Check if wn_param was set right
    checkIndex = 0;
    for i = 1:numel(w)
        if checkType(w{i}, [4, 7, 8, 9])
            checkIndex = checkIndex + 1;
        end
    end
    
    if numel(wn_param) ~= checkIndex
        disp('Too many or too little parameters given. Setting default.');
        wn_param = setDefaultParamsForAllWindows(w);
    end
    
    lineNumber = factor(numel(w));
    colNumber = lineNumber(1);
    lineNumber = lineNumber(2:end);
    lineNumber = prod(lineNumber);
    
    
    % GAIN
    wn_index = 1;
    figure;
    for i = 1 : length(titles)

        subplot(lineNumber, colNumber, i);
        if checkType(w{i}, [4, 7, 8, 9])
            Wn = getWindow(w{i}, order, wn_param(wn_index));
            wn_index = wn_index + 1;
        else
            Wn = getWindow(w{i}, order);
        end
        [b, a] = FIR(order, wc, Ts, Wn);
        [H, omega] = freqz(b, a, 512);
        plotGain(H, omega, strcat(titles{i}, ' amplitude'));

    end
    
    % DB GAIN
    wn_index = 1;
    figure;
    for i = 1 : length(titles)

        subplot(lineNumber, colNumber, i);
        if checkType(w{i}, [4, 7, 8, 9])
            Wn = getWindow(w{i}, order, wn_param(wn_index));
            wn_index = wn_index + 1;
        else
            Wn = getWindow(w{i}, order);
        end
        [b, a] = FIR(order, wc, Ts, Wn);
        [H, omega] = freqz(b, a, 512);
        plotGainDB(H, omega, strcat(titles{i}, ' amplitude in dB'));

    end

    % Phase
    wn_index = 1;
    figure;
    for i = 1 : length(titles)

        subplot(lineNumber, colNumber, i);
        if checkType(w{i}, [4, 7, 8, 9])
            Wn = getWindow(w{i}, order, wn_param(wn_index));
            wn_index = wn_index + 1;
        else
            Wn = getWindow(w{i}, order);
        end
        [b, a] = FIR(order, wc, Ts, Wn);
        [H, omega] = freqz(b, a, 512);
        plotPhase(H, omega, strcat(titles{i}, ' phase'));

    end


end