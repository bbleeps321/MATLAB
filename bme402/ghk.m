% Given the external and internal concentrations of K, Na, Cl and 
% ions, and permeability P, calculates the resting and peak membrane
% potentials using the Goldman-Hodgkin-Katz equation.
% Each parameter should be a 2x1 vector where the first element
% represents the outer concentration and the second represents the inner.
% Assumes temperature of 37 C (body temperature).
% Where P(1) = Pk, P(2) = PNa, P(3) = PCl.
function V = ghk(K, Na, Cl, P)
    outer = P(1)*K(1)+P(2)*Na(1)+P(3)*Cl(2);
    inner = P(1)*K(2)+P(2)*Na(2)+P(3)*Cl(1);
    
    R = 8.314;
    T = 37+273;
    F = 96485;
    V = R*T/F*log(outer/inner) * 1000;  % times 1000 to convert to mV
end