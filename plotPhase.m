% FILE: plotPhase.m
% 
% FUNCTION plotPhase
% 
% CALL: [] = plotPhase(H, omeg, titlePhase)
% 
% Plots the frequency response phase of a filter on the scale omeg with title
% given by titlePhase
% 
% INPUTS:
%         H                - frequency response of a filter
%         omeg             - the scale on which to plot the response
%         titlePhase       - title for the plot
% 
% Author:  Leonard-Gabriel Necula
% Created: December 24 2020
% Updated: January  18 2021

function [] = plotPhase(H, omeg, titlePhase)

    if nargin < 2
        display('Please enter frequency response and frequency values');
        return;
    end
    if(isempty(H) | isempty(omeg))
        display('Please enter frequency response and frequency values');
        return;
    end
    if nargin < 3
        display('No title entered.');
        display('Setting default title.');
        titlePhase = 'Phase';

    else

        if isempty(titlePhase)

            display('titleSBScale empty.');
            display('Setting default titlePhase.');
            titlePhase = 'Phase';

        end
    end


    % -----------------------------------------------------------------------%

    ax = gca;
    
    plot(omeg, unwrap(180 * angle(H)/pi));
    grid on;
    
    ylabel('Phase');
    xlabel('Frequency');
    title(titlePhase);
    xlim([min(omeg) max(omeg) + 0.01]);
    ax.XTick = 0:pi/10:pi;
    ax.XTickLabel = {'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi', ...
             '0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'}; % give them user-defined labels


end