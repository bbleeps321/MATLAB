%hw4 part2

%secant method
function K=hw4b_jiahan
    for q=1:1:4;
        K(1,q)=.01;
        K(2,q)=.05;
        i=2;
        while (abs(fofa(K(i,q)))>0.0001)
            K(i+1,q)=K(i,q)-fofa(K(i,q))*(K(i,q)-K(i-1,q))/(fofa(K(i,q))-fofa(K(i-1,q)));
            i=i+1;
        end
        disp(K(find(K(:,q),1,'last'),q));
        for j=1:1:25;
            c(j)=(D/V)*exp(-K(length(K),q)*j);
        end
        j=1:1:25;
   
        %Plotting
        subplot(2,2,q)
        plot(t,z(q,:),'o')
        hold on 
        plot(j,c,'-')
        xlabel('time')
        ylabel('Concentration')
        title('Smokers')
    end
    
    function f = fofa(K)
        z=[0.298729 0.19758 0.197312 6.63e-2 4.17e-2 2.85e-2;
           0.331687 0.320668 0.269194 0.130602 0.108038 6.49e-2;
           0.467232 0.343565 0.350079 0.166891 0.127308 7.45e-2;
           0.30796 0.272004 0.181932 5.07e-2 2.32e-2 1.1e-2];
        V=25;
        D=10;%mg
        t=[1 3 5 14 18 24];
        f = sum(z(q,:).*t.*exp(-K*t))-(D/V)*sum(t.*exp(-2*K*t));
    end
end

