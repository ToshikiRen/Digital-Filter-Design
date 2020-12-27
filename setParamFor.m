function wc_param = setParamFor(Wn)

    switch Wn

        case 'chebwin'
            wc_param = 90;
        case 'kaiser'
            wc_param = 6;
        case 'lanczos'
            wc_param = 2;
        case 'tukeywin'
            wc_param = 75;
        otherwise 
            disp('Error. Window type does not require an extra parameter');
    end

end