
%Alpha = rolloff
%NumTaps = filter length 
%Sps = samples per symbol 
%TimeDelay = Time delay in samples

Alpha=0.22;
NumTaps=17;
Sps=16;%samples between two symbols, for sinc it's at the zero crossing
TimeDelay=0;
N=2048;
fs=16;

h=SqrcFilter(Alpha,NumTaps,Sps,TimeDelay);

[H,F]=freqz(h,1,N,fs);

subplot(3,2,1);
plot( 20*log10(abs(H)/max(abs(H))+0.0001 ));
title('H relative to the largest value in H');
ylabel('dB');xlabel('freq');
grid on;

%
%iv: out-of-band attenuation is at least 17dB 

%plot correlation

b=sum(h.^2);
hnorm=h/sqrt(b);

c=conv(hnorm,fliplr(hnorm));

subplot(3,2,2);
plot(c);
title('Correlation of transmit and receive filters');


    
%part III

%generate random signals 0 or 1 and convert it to -1 or 1
length=32;
signal=rand(1,length);
signal0_1=round(signal);
transmit=2*signal0_1-1;

%upsample the transmit signal
upsample_trans=upsample(transmit, 16);

subplot(3,2,3);
plot(upsample_trans);
title('upsampled signal')

Tup=conv(upsample_trans,hnorm);
subplot(3,2,6);
plot(Tup);
receive=conv(Tup,hnorm);

subplot(3,2,4)
plot(receive);
title('received signal')

%constellation

%go through two filters so the delay is (length-1)= 17-1=16
z=receive(16:16:end);
subplot(3,2,5);
x=real(z);
y=imag(z);
scatter(x,y);
title('constellation of received signal');xlabel('real');ylabel('imag')






