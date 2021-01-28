% FILE: truncateCellArray.m
% 
% FUNCTION: truncateCellArray
% 
% CALL: truncatedCellArray = truncateCellArray(cellArray, new_size)
% 
% The functions truncate the input cell array to the new_size, if no new
%     size is given the output cell array has the same length as the input
%     
% INPUTS:
%        cellArray    - cell array to truncate
%        new_size     - the new size of the cell array
% 
% OUTPUTS:
%         truncatedCellArray - the truncated cell array
%
%
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021     

function truncatedCellArray = truncateCellArray(cellArray, new_size)
    
    if nargin < 1
        disp('Inputs: cell array and new size');
        return;
    elseif isempty(cellArray)
        disp('Empty input. Nothing to truncate');
        return;
    end
    
    if nargin < 2
        disp('Size was not specified.');
        truncatedCellArray = cellArray;
        return;
    elseif isempty(new_size)
        disp('Empty new size');
        truncatedCellArray = cellArray;
        return;
    end
    
    truncatedCellArray = cell(new_size, 1);
    for i = 1 : new_size
       truncatedCellArray{i} = cellArray{i}; 
    end

end