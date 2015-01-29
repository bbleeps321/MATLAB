% toggle switch A-|B, B-|A, both degrade
% pt beta, gamma >> 1, >=3 e suf, o sa ai o regiune mare de bistabilitate,
% insemnand ca switch se va switch conform carei IC e mai mare. alpha1 si
% alpha2 conteaza cand unul e cu mult mai mare ca celalalt, o sa ai
% monostabilitate (intot ac culoare, indiferent de IC). Regiunea de
% bistabilitate se mareste odata cu beta si gamma. Marimea regiunii
% bistabile e f mica pentru beta = gamma = 1.1. 

% Adaugarea de inducer switches switchul din bistabilitate in 
% monostabilitate. Odata ce e inducerul este
% adaugat, se switch si ramane in state acela pt o vreme (de asta este unitate
% de memorie; pentru ca ramane in state care s-a switched). Pp ca incepi cu
% conditie initiala mai mare pentru y(2) si adaugi IPTG dupa o vreme,
% switchul va incepe cu mai mult y(2), dar dupa adaugarea de IPTG, vei avea
% mai mult y(1) si switch va ramane asa, chiar daca nu mai adaugi IPTG dupa. 
% Ideea este ca ai intrat in monostabilitate acum. Concentratia de IPTG
% trebuie sa fie cam minim 2*10^(-5). Langa bifurcatia de 5.45*10^(-6) IPTG,
% vei observa o populatie bimodala de celule in natura. Observi salt pe 
% simularea ta. 



function dy = Gardner_switch_deterministic(t,y);
dy = zeros(2,1); 

alpha1 = 156.25;
alpha2 = 15.6;
beta = 5;
gamma = 5;
eta = 2.0015;
K = 2.9618*10^(-5);
IPTG = 5.45*10^(-6);
heat = 0;

% no inducer = bistable
%dy(1) = alpha1 / (1+y(2))^beta - y(1);
%dy(2) = alpha2 / (1+y(1))^gamma - y(2);

% with inducer = monostable dupa adaugarea de inducer, chiar si dupa ce
% incetezi a-l mai adauga

    if t < 150
        dy(1) = alpha1 / (1+y(2))^beta - y(1);
        dy(2) = alpha2 / (1+y(1))^gamma - y(2);
    elseif t >= 150 && t <=300
    
        dy(1) = alpha1 / (1 + (y(2) / (1 + IPTG/K)^eta))^beta - y(1);
        dy(2) = alpha2 / (1 + (y(1) / (1 + heat/K)^eta))^gamma - y(2);
    else
        dy(1) = alpha1 / (1+y(2))^beta - y(1);
        dy(2) = alpha2 / (1+y(1))^gamma - y(2);
    end
end