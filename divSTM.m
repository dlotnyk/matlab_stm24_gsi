function y=divSTM(x,n1,n2,init)
%  function to obtain derivatives using Savitsky-Golay polynomial method
%  y - matrix of div's
%  x - iv's matrix
%  n1  -   Order of polynomial fit (recommeded value 2)
%  n2 - Window length (recommeded value 11)
%  init - initilization structure
%  D.L.

tic;
[b,g] = sgolay(n1,n2);   % Calculate S-G coefficients
g1=zeros(1,1,length(g));
g1(1,1,:)=g(:,2);
G=zeros(init.ncol,init.nrow,length(g));
G=repmat(g1,init.ncol,init.nrow);
HalfWin  = ((n2+1)/2) -1;
y=zeros(init.ncol,init.nrow,init.ramp);
       for nn = (n2+1)/2:init.ramp-(n2+1)/2
           % 1st differential
           y(:,:,nn)=-dot(G(:,:,:),x(:,:,(nn - HalfWin:nn + HalfWin)),3);
       end

clearvars -except y
toc;