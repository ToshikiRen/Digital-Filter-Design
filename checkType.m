
% FILE: checkType.m
%
% FUNCTION: checkType
%
% CALL: check = checkType(type, indx)
%
% Checks if a given window it's in one of the specified sets, indx must be
% a vector with values in range 1 to 9. Returns 1 if the window given by
% the parameter type it's one from the values at indx
%
%
%         1 - 'boxcar';   
%         2 - 'triang';  
%         3 - 'blackman';  
%         4 - 'chebwin';  
%         5 - 'hamming';
%         6 - 'hanning';
%         7 - 'kaiser';
%         8 - 'lanczos';
%         9 - 'tukeywin';
%
% INPUTS:
%       type - window name
%       indx - a vector with index values for thw windows to check
%
% OUTPUTS:
%       check - 1 if the window is in the set selected by indx, 0 otherwise
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021

function check = checkType(type, indx)


    if nargin < 1
        check = 0;
        return;
    elseif isempty(type)
        check = 0;
        return;
    end
    if nargin < 2
        indx = [1 2 3 4 5 6 7 8 9];
    elseif isempty(indx)
        indx = [1 2 3 4 5 6 7 8 9];
    end

    variants = cell(9,1);
    variants{1} = 'boxcar';   
    variants{2} = 'triang';  
    variants{3} = 'blackman';  
    variants{4} = 'chebwin';  
    variants{5} = 'hamming';
    variants{6} = 'hanning';
    variants{7} = 'kaiser';
    variants{8} = 'lanczos';
    variants{9} = 'tukeywin';

    check = 0;
    for i = 1:numel(indx)

        if strcmp(type, variants{indx(i)})
           check = 1;
           return;
        end

    end
 
end