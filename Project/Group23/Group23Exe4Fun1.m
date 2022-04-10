function [ tau ] = Group23Exe4Fun1( limits, Cases, Deaths  )

    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492
    
    % Calculating the Pearson's correlation coefficient for every tau~[-20,20]
    % using function corrcoef(). We input the limits of the first wave that
    % are stable for cases but moving for deaths depending on the value of
    % tau in the for-loop. After that we find the maximum coefficient value
    % and return its index.
    
    r = zeros(1,41);
  
    for tau = -20:1:20
        temp = corrcoef(Cases(limits(1):limits(2)), Deaths(limits(1)+tau:limits(2)+tau));
        r(21+tau) = temp(1,2);
    end
    
    index = 1;
    maxR = r(1);
    for k = 2:41 
        if r(k)>maxR
            maxR = r(k);
            index = k;
        end
    end
    
    tau = index - 21;
end

