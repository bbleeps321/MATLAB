function hw2_2
    a1 = load('wtaa1.txt');
    figure; plot(a1);
    title('WTA Behavior');
    xlabel('Time (s)'); ylabel('Concentration (nM)');
    legend('S1','S2','S3','S4');
    
    b2 = load('wtab2.txt');
    wtaPlot(b2);
    axis([0 1000 0 1.5]);
    
    disp('Part 2');
    wtaDisp(load('wtaa2.txt'));
    wtaDisp(b2);
    wtaDisp(load('wtac2.txt'));
    wtaDisp(load('wtad2.txt'));
    
    disp('Part 3');
    
    c3 = load('wtac3.txt');
    wtaPlot(c3);
    axis([0 1000 0 15]);
    
    wtaDisp(load('wtaa3.txt'));
    wtaDisp(load('wtab3.txt'));
    wtaDisp(c3);
    wtaDisp(load('wtad3.txt'));
    
    d4p = load('wtad4p.txt');
    wtaPlot(d4p);
    axis([0 1000 0 15]);
    
    c4i = load('wtac4i.txt');
    wtaPlot(c4i);
    axis([0 1000 0 15]);
    
    disp('Part 4 Perfect');
    wtaDisp(load('wtaa4p.txt'));
    wtaDisp(load('wtab4p.txt'));
    wtaDisp(load('wtac4p.txt'));
    wtaDisp(d4p);
    
    disp('Part 4 Imperfect');
    wtaDisp(load('wtaa4i.txt'));
    wtaDisp(load('wtab4i.txt'));
    wtaDisp(c4i);
    wtaDisp(load('wtad4i.txt'));
end

function wtaPlot(A)
%     figure;
%     plot(A(:,[5:8]));
%     title('Output concentrations');
%     xlabel('Time (s)'); ylabel('Concentration (nM)');
%     legend('S5','S6','S7','S8');
end

function wtaDisp(A)
    if (size(A,2) > 13)
        disp([A(1,[13:16])' A(end,[5:8])']);
    elseif (size(A,2) > 4)
        disp([A(1,[1:4])' A(end,[5:8])']);
    end
end
    