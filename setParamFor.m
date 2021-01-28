
% FILE: setParamFor.m
% 
% FUNCTION: setParamFor
% 
% CALL: wn_param = setParamFor(Wn)
% 
% Returns the default parameters for the given window
% 
% INPTUS: 
%         Wn - a window name
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
% OUTPUTS:
%         wn_param - the default parameters for the given window
%         
%
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021     

function wc_param = setParamFor(Wn)

    switch Wn

        case 'chebwin'
            wc_param = 90;
        case 'kaiser'
            wc_param = 6;
        case 'lanczos'
            wc_param = 2;
        case 'tukeywin'
            wc_param = 75;
        otherwise 
            disp('Error. Window type does not require an extra parameter');
    end

end