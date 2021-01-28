% FILE: setDefaultParamsForAllWindows.m
% 
% FUNCTION: setDefaultParamsForAllWindows
% 
% CALL: wn_param = setDefaultParamsForAllWindows(Wn)
% 
% Returns the default parameters for all windows
% 
% INPTUS: 
%         Wn - a vector with the names of the used windows
% Wn contain a set from those bellow:
%           boxcar   
%           triang  
%           blackman  
%           chebwin  
%           hamming
%           hanning
%           kaiser
%           lanczos
%           tukeywin
% OUTPUTS:
%         wn_param - the default parameters for the given windows
%         
% USES:
%       checkType
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021        
 

function wn_param = setDefaultParamsForAllWindows(Wn)
    
    
    wn_param = []
    
    if nargin < 1
        disp('At least one window name must be given.');
        return;
    elseif isempty(Wn)
        disp('At least one window name must be given.');
        return;
    end
    for i = 1:numel(Wn)
        if checkType(Wn{i}, [4, 7, 8, 9])
            wn_param = [wn_param setParamFor(Wn{i})];
        end
    end
    
end