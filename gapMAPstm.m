function g1=gapMAPstm(x,vmin,vmax,thresh,NN,init)
%   function to find gap map
%   x - matrix of normalized and offseted DIV curves
%   vmin - min voltage to find maximum
%   vmax - max voltage to find maximum
%   thresh - level of point deviation according to its neighbornood (recommeded value 0.02)
%   NN - level of neighborhood (recommeded value 3)
%   init - structure
%   D.L.
%% simple gap map 
tic;
voltage=linspace(init.bias-init.offset,-init.bias-init.offset,init.ramp);
voltage1=voltage';% need to update
idx1=knnsearch(voltage1,vmin); % find index of vmn
idx2=knnsearch(voltage1,vmax);  % find index of vmax
[M,MI]=max(x(:,:,idx2:idx1),[],3); % find index of maximum
MI1=MI+idx2;
gap=zeros(init.nrow,init.ncol);
for ii=1:init.nrow
    gap(ii,:)=voltage(1,MI1(ii,:)); % create simple gapmap
end
gap2=gap;
clear ii;
%% gapmap according to neighborhood
for jj=1:init.nrow
    for ii=1:init.ncol
        [X, Y] = meshgrid(max(1,jj-NN):min(init.nrow,jj+NN), max(1,ii-NN):min(init.ncol,ii+NN)); %find mesh
        I = sub2ind([init.nrow init.ncol], X(:),Y(:)); % find NN-neighbourhood
        ni=sub2ind([init.nrow init.ncol], jj, ii); % index of point itself
        [C1,ia1,ib1] = intersect(I,ni);
        I(ia1)=[];                               % exclude point itself
        th1=mean(gap(ind2sub([init.nrow init.ncol],I)));
        mina=th1-th1*thresh;
        maxa=th1+th1*thresh;
        if gap(jj,ii)>maxa || gap(jj,ii)<mina
           gap(jj,ii)=th1;
        end
    end
end

toc;
%% plotting
figure(5);
g1=myimageanalysis1(gap); % smoothing
surf(1:init.ncol,1:init.nrow,g1)
title('Gap map');
clearvars -except g1