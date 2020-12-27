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