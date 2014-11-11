%5.7
units = [200 500 700 1000 1500];
cost = (units <= 500).*(0.02*units);
cost = cost + (units > 500 & units <= 1000).*(10+0.05*(units-500));
cost = cost + (units > 1000).*(35+0.1*(units-1000));
cost = cost + 5;
disp(cost);

units = [200 500 700 1000 1500];
cost = 10*(units>500) + 25*(units>1000) + 5;
cost = cost + 0.02*(units<=500).*units;
cost = cost + 0.05*(units > 500 & units <= 1000).*units;
cost = cost + 0.1*(units > 1000).*units;
disp(cost);