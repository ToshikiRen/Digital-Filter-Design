function [] = plotGainDB(H, omeg, titleDBScale)

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
        titleDBScale = 'Amplitude scale - dB';

    else

        if isempty(titleDBScale)

            display('titleSBScale empty.');
            display('Setting default titleDBScale.');
            titleDBScale = 'Amplitude scale - dB';

        end
    end


    % -----------------------------------------------------------------------%

    ax = gca;
    
    plot(omeg, 20*log10(abs(H)));
    grid on;
    
    ylabel('dB Gain');
    xlabel('Frequency');
    title(titleDBScale);
    xlim([min(omeg) max(omeg) + 0.01]);
    ax.XTick = 0:pi/10:pi;
    ax.XTickLabel = {'0','0.1\pi','0.2\pi','0.3\pi','0.4\pi','0.5\pi', ...
             '0.6\pi','0.7\pi','0.8\pi','0.9\pi','\pi'}; % give them user-defined labels

    
end