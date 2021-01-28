% FILE: getWindow.m
% 
% FUNCTION: getWindow
% 
% CALL: Wn = getWindow(Wn, order, wn_param)
% 
% Returns a window of type Wn of length order
% DEFAULT: hanning window of length 16
%
% INPUTS:
%         Wn       - window type
%         order    - window length
%         wn_param - window extra parameter 
% 
% 
% OUTPUTS:
%         Wn - window values
% 
% USES: lanczos
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021

function Wn = getWindow(Wn, order, wn_param)

    if nargin < 1
        disp('Window type was not set. Set window type to hamming.');
        Wn = 'hamming';
    elseif isempty(Wn)
        disp('Window type was left empty. Set window type to hamming.');
        Wn = 'hamming';
    end
    if nargin < 2
        disp('Window order was not set. Set window length to 16.');
        order = 16;
    elseif isempty(Wn)
        disp('Window order was left empty. Set window length to 16.');
        order = 16;
    end 
    
    if checkType(Wn, [4, 7, 8, 9])
        if nargin < 3
            wn_param = setParamFor(Wn);
            disp(['Filter window extra parameter was not set. ' ....
                                 'Setting wn_param = ' num2str(wn_param)]);
        elseif isempty(wn_param)
            wn_param = setParamFor(Wn);
           disp(['Filter window extra parameter was left empty. ' ....
                                 'Setting wn_param = ' num2str(wn_param)]);
        end
    end
    
    
    switch Wn
        
        case 'boxcar'
                Wn = boxcar(order);
        case 'triang'
                Wn = triang(order);
        case 'blackman'
                Wn = blackman(order);
        case 'chebwin'
                Wn = chebwin(order, wn_param);
        case 'hamming'
                Wn = hamming(order);
        case 'hanning'
                Wn = hanning(order);
        case 'kaiser'
                Wn = kaiser(order, wn_param);
        case 'lanczos'
                Wn = lanczos(order, wn_param);
        case 'tukeywin'
                Wn = tukeywin(order, wn_param);
        
    end
    
    
end