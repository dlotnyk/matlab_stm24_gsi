function [sl,inter]=badPOINTS(x,init)
%  function to find bad points according to its slopes
%  sl - slopes at each points
%  x - IV matrix data (preferebly original)
%  init - initialization structure
%  D.L. 

tic;

x1=35;
x2=init.ramp-35;
dx=x2-x1;

sl=zeros(init.nrow,init.ncol);
inter=zeros(init.nrow,init.ncol);
for ii=1:init.ncol
    for jj=1:init.nrow
        average1=mean(x(jj,ii,10:60));
        average2=mean(x(jj,ii,init.ramp-60:init.ramp-10));
       sl(jj,ii)=1000*(average1-average2)/dx; % real slopes values have an opposite sign and multiplied at 1000
       inter(jj,ii)=average1+x1*sl(jj,ii)/1000;
    end
end
clearvars -except sl inter
toc;