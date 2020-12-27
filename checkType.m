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
    variants{1} = 'boxcar';  % 
    variants{2} = 'triang'; % 
    variants{3} = 'blackman'; % 
    variants{4} = 'chebwin'; % 
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