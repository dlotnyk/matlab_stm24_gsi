function dIdV = paradif(voltage, current, param)
% parametric derivative based on linear regression with Fermi-Dirac
% distribution of bins
%number of points for regress...if points = 1 - same as diff!!!

tic;

step = param(1); %energy in meV
width = param(2); %energy in meV
min = param(3); %number of points
max = param(4); %number of points
pts = (max - min).*(1 - 1./(exp((abs(voltage*1000)-step)/width)+1))+min; %values for derivation


n=length(current); %number of samples per curve
dIdV=zeros(n, 1);
    for i=1:n;
        points = pts(i);
          if i-round(points/2)<1 start=1;
            else start=i-round(points/2); 
          end
          if i+round(points/2)>n stop=n;
            else stop=i+round(points/2);
          end
          coefs=polyfit(voltage(start:stop),current(start:stop),1);
          dIdV(i)=coefs(1);
    end
toc;
end