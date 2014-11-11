%2.22
amt = [200 500 700 1000 1500];
charge = zeros(1,5) + 5;
for (i=1:5)
    if (amt(i) <= 500)
        charge(i) = charge(i) + 0.02*amt(i);
    elseif (amt(i) <= 1000)
        charge(i) = charge(i) + 10 + 0.05*(amt(i) - 500);
    else
        charge(i) = charge(i) + 35 + 0.1*(amt(i) - 1000);
    end
end
disp('        Units       Charge');
disp([amt' charge']);

%2.23
format bank;
month = 1:12;
r = 0.01;
balance = zeros(1,12);
balance(1) = 50*(1+r);
for (i=1:11)
    balance(i+1) = (balance(i) + 50)*(1+r);
end
disp('      Month       Balance');
disp([month' balance']);
format;

%2.24
format bank;
amt = 1000;
for (i = 1:12)
    amt = amt*(1+.12/12);
end
disp(amt);
format;

%2.25
format bank;
month = [1:12];
rate = zeros(1,12);
interest = zeros(1,12);
balance = zeros(1,12);
balance(1) = 100000;
for (i = month)
    if (balance(i) <= 110000)
        rate(i) = 0.01;
    elseif (balance(i) <= 125000)
        rate(i) = 0.015;
    else
        rate(i) = 0.02;
    end
    interest(i) = balance(i)*rate(i);
    balance(i+1) = balance(i) + interest(i) + 1000;
end
balance(1) = [];
disp('        Month      Rate     Interest     New Balance');
disp([month' rate' interest' balance']);
format;

n = input('number');
switch (n)
    case (0+1)
        disp('one!');
    case (2)
        disp('two!');
end