% Solve for change in reactants of an equilibrium reaction.
% Takes in initial concentrations and K value.
function eqm(R,P,K)
    a = 1;
    keyboard;
    b = K+P(1)+P(2);
    c = P(1)*P(2)-K*R(1);
    fprintf('x1=%f\n',(-b+sqrt(b^2-4*a*c))/(2*a));
    fprintf('x2=%f\n',(-b-sqrt(b^2-4*a*c))/(2*a));
end
