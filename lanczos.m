function h = lanczos(M, L)

    if nargin < 1

        display('No input parameters detected.');
        display('Setting M = 128 and L = 1.5');
        L = 1.5;
        M = 128;
    end
    if isempty(M)

        display('Detected empty M.');
        display('Setting M = 128');
        M = 128;
    end
    if nargin < 2
        display('L missing.');
        display('Setting L = 1.5');
        L = 1.5;
    end
    if isempty(L)

        display('Detected empty L.');
        display('Setting L = 1.5');
        L = 1.5;

    end
% ---------------------------------------------------------------------- %

    N = 0: M - 1;
    arg = (2*pi * (2*N - M + 1))./(2*(M-1));

    h = sin(arg)./arg;
    if mod(M, 2)
        h((M-1)/2 + 1) = 1;
    end
    h = h.^L;
    

end