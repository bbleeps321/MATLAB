% Runs an alcohol_sim and plots BAC
function BAC_plot(dose, male, t0, tf)
    [t x BAC] = alcohol_sim(dose, male, t0, tf);
    plot(t,BAC);
end