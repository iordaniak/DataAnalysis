function percentage = ch2ex1func( N )
    %In this function the user gives the number N of coin toss
    %and the function returns the percentage of heads
    mid = 0.5000;
    heads = 0; %tails are N - heads
    NrandomNumbers = unifrnd(0, 1, N, 1);
    for i =1:N
        if NrandomNumbers(i) < mid
            heads = heads + 1;
        end
    end
    percentage = heads / N;
end
