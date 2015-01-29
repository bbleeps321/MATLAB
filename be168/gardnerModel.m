% y(1) = u, y(2) = v.
function dy = gardnerModel(t,y,alpha1,alpha2,beta,gamma)
    dy = [alpha1 / (1+y(2)^beta) - y(1);...
          alpha2 / (1+y(1)^gamma) - y(2)];
end