K = 500;
X = 2*rand(2,K) - 1;
Y = sin(pi*X);
Ha = @(x,xdata) x(1)*ones(size(xdata));
Hb = @(x,xdata) x(1)*xdata;
Hc = @(x,xdata) x(1)*xdata + x(2);
Hd = @(x,xdata) x(1)*xdata.^2;
He = @(x,xdata) x(1)*xdata.^2 +x(2);
paramA = zeros(1,K);
paramB = zeros(1,K);
paramC = zeros(2,K);
paramD = zeros(1,K);
paramE = zeros(2,K);
options = optimset('Display','off');
for (i=1:K)
    paramA(:,i) = lsqcurvefit(Ha,0,X(:,i),Y(:,i),-Inf,Inf,options);
    paramB(:,i) = lsqcurvefit(Hb,0,X(:,i),Y(:,i),-Inf,Inf,options);
    paramC(:,i) = lsqcurvefit(Hc,[0 0],X(:,i),Y(:,i),[-Inf; -Inf],[Inf; Inf],options);
    paramD(:,i) = lsqcurvefit(Hd,0,X(:,i),Y(:,i),-Inf,Inf,options);
    paramE(:,i) = lsqcurvefit(He,[0 0],X(:,i),Y(:,i),[-Inf; -Inf],[Inf; Inf],options);
end

paramAbar = mean(paramA)
paramBbar = mean(paramB)
paramCbar = mean(paramC,2)
paramDbar = mean(paramD)
paramEbar = mean(paramE,2)

x = [-1:.01:1];
gAbar = Ha(paramAbar,x);
gBbar = Hb(paramBbar,x);
gCbar = Hc(paramCbar,x);
gDbar = Hd(paramDbar,x);
gEbar = He(paramEbar,x);
f = sin(pi*x);

biasA = trapz((gAbar-f).^2/length(x))
biasB = trapz((gBbar-f).^2/length(x))
biasC = trapz((gCbar-f).^2/length(x))
biasD = trapz((gDbar-f).^2/length(x))
biasE = trapz((gEbar-f).^2/length(x))

gA = zeros(length(x),K);
gB = zeros(length(x),K);
gC = zeros(length(x),K);
gD = zeros(length(x),K);
gE = zeros(length(x),K);
for (i = 1:K)
    gA(:,i) = Ha(paramA(:,i),x);
    gB(:,i) = Hb(paramB(:,i),x);
    gC(:,i) = Hc(paramC(:,i),x);
    gD(:,i) = Hd(paramD(:,i),x);
    gE(:,i) = He(paramE(:,i),x);
end

varA = mean(trapz((gA-repmat(gAbar',1,K)).^2/length(x)))
varB = mean(trapz((gB-repmat(gBbar',1,K)).^2/length(x)))
varC = mean(trapz((gC-repmat(gCbar',1,K)).^2/length(x)))
varD = mean(trapz((gD-repmat(gDbar',1,K)).^2/length(x)))
varE = mean(trapz((gE-repmat(gEbar',1,K)).^2/length(x)))

genErrorA = biasA + varA
genErrorB = biasB + varB
genErrorC = biasC + varC
genErrorD = biasD + varD
genErrorE = biasE + varE

figure; hold on;
plot(x,sin(pi*x),'k');
plot(x,gAbar,'r');
plot(x,gBbar,'g');
plot(x,gCbar,'b');
plot(x,gDbar,'c');
plot(x,gEbar,'m');
legend('target','y=b','y=ax','y=ax+b','y=ax^2','y=ax^2+b');
title('Average hypothesis functions');