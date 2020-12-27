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