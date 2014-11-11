e1 = rand(1,100000);
e2 = rand(1,100000);
Ee1 = mean(e1)
Ee2 = mean(e2)
e = min(e1,e2);
Ee = mean(min(e1,e2))