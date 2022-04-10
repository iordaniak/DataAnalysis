function [ Spain ] =  Group23Exe7Fun2( Spain )
    % Eleni Kalla 9398
    % Iordanis Konstantinidis 9492

    % Auth h sunarthsh diorthwnei tis mhdenikes times tou savvatokuriakou
    % Moirazontas tis times ths deuteras dia 3
    start1 = 185;
    jump = 7;
    for i = start1:jump:339
        temp = fix(Spain(1,i+2)/3);
        Spain(1,i) = temp;
        Spain(1,i + 1) = temp;
        Spain(1,i + 2) = temp;
    end
    start2 = 227;
    for i = start2:jump:339
        Spain(1,i) = -1;
        Spain(1,i+1) = -1;
    end
    
end

