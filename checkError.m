% FILE: checkError.m
%
% FUNCTION: checkError
%
% CALL: check = checkError(deltaP, deltaP_max, deltaS, deltaS_max)
%
% Checks if deltaP < deltaP_max and deltaS < deltaS_max, and returns
% 1 if the conditions hold
%
% INPUTS:
%       deltaP      - computed value via another program
%       deltaP_max  - The maximum value for deltaP
%       deltaS      - computed value via another program
%       deltaS_max  - The maximum value for deltaS
%
% OUTPUTS:
%       check - 1 if deltaP < deltaP_max and deltaS < deltaS_max
%               0 otherwise
%
%
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021



function check = checkError(deltaP, deltaP_max, deltaS, deltaS_max)

    check = 0;
    if nargin < 4
        disp('All parameters are needed');
        return;
    elseif isempty(deltaP) || isempty(deltaS) || isempty(deltaP_max) || isempty(deltaS_max)
        disp('Found empty value.');
        return;
    end
        
    if deltaP > deltaP_max
        check = 0;
        return;
    end
    
    if deltaS > deltaS_max
        check = 0;
        return;
    end
    
    check = 1;
end