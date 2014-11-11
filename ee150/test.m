balance = input('Enter balance: ');
rate = input('Enter rate: ');
interest = rate * balance;
balance = balance+interest;
format bank
disp('New balance:');
disp(balance);
format    % reset format to default

% finds what for what interchanged numbers in a UPC 
% that would result in the same check sum digit
pair = zeros(1,2);
next = 1;
code = [0 1 5 6 3 2 5 6 9 3 4];
for (a = 0:9)
    for (b = 0:9)
        code1 = code;
        code1(4) = a;
        code1(5) = b;
        code2 = code;
        code2(4) = b;
        code2(5) = a;
        if (checksumdigit(code1) == checksumdigit(code2) && a ~= b)
            pair(next,:) = [a b];
            next = next+1;
        end
    end
end
disp('     a     b   |a-b|');
diff = abs(pair(:,1) - pair(:,2));
disp([pair diff]);