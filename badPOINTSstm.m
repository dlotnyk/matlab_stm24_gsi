function sl=badPOINTSstm(x,init)
%   function to find bad IVs
%   bp - vector with bad points indexes
%   sl - matrix with slopes for all IVa
%   x - IV matrix (dmat used are strogly recommended)
tic;
voltage=linspace(init.bias-init.offset,-init.bias-init.offset,init.ramp);
voltage1=voltage';% need to update
iv=zeros(init.ramp,1);
sl=zeros(init.ncol,init.nrow);
%% find all bad points. put their indexes in np
for ii=1:init.ncol
    for jj=1:init.nrow
        iv(:,1)=x(ii,jj,:);
        p=fit(voltage1,iv,'poly1');
        sl(ii,jj)=p.p1;
    end
end
toc;