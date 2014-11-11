% Receives an input vector (block) of four data bits and 
% generates the Hamming code block (7,4).
function block = createHammingCode(data)
%data = input('Enter the 4 data bits as a row vector: ');
r = zeros(1,3);

% first redundant bit
sum = data(1) + data(3) + data(4);
if (rem(sum,2) == 1)    % odd, make even; otherwise, leave alone
    r(1) = 1;
end

% second redundant bit
sum = data(1) + data(2) + data(4);
if (rem(sum,2) == 1)    % odd, make even; otherwise, leave alone
    r(2) = 1;
end

% third redundant bit
sum = data(2) + data(3) + data(4);
if (rem(sum,2) == 1)    % odd, make even; otherwise, leave alone
    r(3) = 1;
end

block = [r data];

%disp('Hamming code block: ');
%disp([r data]);

end
