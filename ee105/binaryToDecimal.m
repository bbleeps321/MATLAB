binary = input('Enter binary number: ', 's');
value = 0;
size = length(binary);
for (i = 1:size)
    value = value + binary(i)*(2^(size-i));
end
    
disp(value);    