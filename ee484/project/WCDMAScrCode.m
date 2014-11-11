%WCDMAScrCode Create WCDMA scrambling sequence.
%
%USAGE:
%           [scrCode] = WCDMAScrCode(nInt)
%
%INPUTS:
%		    nInt - 24-bit sequence index, default is random
%
%OUTPUTS:
% 		    scrCode - complex WCDMA scrambling sequence
%		    nInt - 24-bit sequence index
%
%REFERENCES:
%		    3GPP TS 25.213 v9.1.0, "3rd Generation Partnership Project;
%             Techical Specification Group Radio Access Network;
%             Spreading and modulation (FDD) (Release 9)
%

function [scrCode,nInt] = WCDMAScrCode(nInt)

if nargin == 0
    nInt = round(2^24*rand(1));
end

% generate 24 bit random integer
nBin = dec2bin(nInt,24);

% build a()
a = zeros(1,256);
a(1) = mod(2*nBin(1)+1,4);
for m = 1:254
    i = m+1;            % matlab index conversion
    if i <= 8
        a(i) = mod(2*nBin(i),4);
    else
        a(i) = mod(3*a(i-3)+a(i-5)+3*a(i-6)+2*a(i-7)+3*a(i-8),4);
    end
end

% build b() and d()
b = zeros(1,256);
d = zeros(1,256);
for m = 0:254
    i = m+1;            % matlab index conversion
    if i <= 8
        b(i) = mod(nBin(8+i),2);
        d(i) = mod(nBin(16+i),2);
    else
        b(i) = mod(b(i-1)+b(i-3)+b(i-7)+b(i-8),2);
        d(i) = mod(d(i-1)+d(i-3)+d(i-4)+d(i-8),2);
    end
end

% compute z()
z = mod(a+2*b+2*d,4);, z(256) = z(1);

% convert to c_s1, c_s2
ind0 = find(z==0);,ind1 = find(z==1);ind2 = find(z==2);ind3 = find(z==3);
c_s1([ind0 ind3]) = 1;, c_s1([ind1 ind2]) = -1;
c_s2([ind0 ind1]) = 1;, c_s2([ind2 ind3]) = -1;

% compute complex scrambling sequence C_short
i = 0:255;
C_short(i+1) = c_s1(mod(i,256)+1).* ...
    (1+j*(-1).^i.*c_s2(2*floor(mod(i,256)/2)+1));

% extend sequence to a length of 2560
scrCode = reshape(C_short'*ones(1,10),10*256,1);

