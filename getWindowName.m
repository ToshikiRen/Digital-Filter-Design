function [w, titles] = getWindowName()


    w = cell(9,1);
    w{1} = 'boxcar';
    w{2} = 'triang';
    w{3} = 'blackman';
    w{4} = 'chebwin';
    w{5} = 'hamming';
    w{6} = 'hanning';
    w{7} = 'kaiser';
    w{8} = 'lanczos';
    w{9} = 'tukeywin';


    titles = {'Boxcar Window Frequency response',
             'Triangle Window Frequency response',
             'Blackman Window Frequency response',
             'Chebyshev Window Frequency response',
             'Hamming Window Frequency response',
             'Hanning Window Frequency response',
             'Kaiser Window Frequency response',
             'Lanczos Window Frequency response',
             'Tukey Window Frequency response'};


end