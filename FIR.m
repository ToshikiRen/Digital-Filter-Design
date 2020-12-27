function [b, a] = FIR(order, wc, Ts, window)

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
        window = hamming(order);
        disp('Window was not set. Default window used');
    elseif isempty(window)
        window = hamming(order);
        disp('Window was left empty. Default window used');
    elseif numel(window) ~= order
        window = hamming(order);
        disp('Window of incorrect size. Default window used');
    end
    
    hn = cardinalSinShifted(order, wc, Ts);
    hn = hn(:);
    b =  hn .* window(:);
    a = 1;
    
    % Norming 
    if norm(b) > 1e-10
        b = b./sum(b);
    end

end