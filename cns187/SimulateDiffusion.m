% Returns diffusion for a experiment with specified thresholds and
% experiment data. Also returned exp structure with extra parameters.
% err should be [a,b] where a is false accept rate and b is false reject
% rate.
function [r,exp] = SimulateDiffusion(err,exp)
% P should be [P1,P0] where P1 is P(x=1|y=1) and P0 is P(x=1|y=0)
% r0 should be the prior P(y=1)/P(y=0)

% seq = exp.observedSequence;
exp.T_0 = log10(err(2)/(1-err(2)));
exp.T_1 = log10((1-err(1))/err(1));
exp.r_0 = 0; % Assume 50/50 chance of picking either cup.

P0 = exp.greenMM_0/exp.totalMM_0; % P(x=1|y=0);
P1 = exp.greenMM_1/exp.totalMM_1; % P(x=1|y=1);
exp.delta_0 = log10(P1/P0);
exp.delta_1 = log10((1-P1)/(1-P0));

N = length(exp.observedSequence);
r = zeros(1,N+1);
exp.sprtGuess = -1;
exp.sprtResponseTime = -1;
for i = 1:N
    % Check threshold and make decision if decided already.
    if r(i) >= exp.T_1 && exp.sprtGuess == -1;
        exp.sprtGuess = 1;
        exp.sprtResponseTime = i;
    elseif r(i) <= exp.T_0 && exp.sprtGuess == -1;
        exp.sprtGuess = 0;
        exp.sprtResponseTime = i;
    end
    
    % Update r based on sample value.
    if exp.observedSequence(i) == 1 % Green
        r(i+1) = r(i) + exp.delta_1;
    else
        r(i+1) = r(i) + exp.delta_0;
    end
end