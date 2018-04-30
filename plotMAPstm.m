function x2=plotMAPstm(x,v,NN,init)
%   function to plot conductance maps
%   x - matrix of data (could be IV or DIV)
%   v - voltage of c. map
%   NN - number of maps you want to plot (better if it is 1,4,9,16)
%   init - initial structure
%   D.L.
%% find nearest point and its NN-1 closest neighbours
voltage=linspace(init.bias-init.offset,-init.bias-init.offset,init.ramp);
voltage1=voltage';% need to update
idx=knnsearch(voltage1,v);
x1=zeros(init.nrow,init.ncol);
x2=zeros(init.nrow,init.ncol);
cx=ceil(sqrt(NN));
cy=floor(NN/2);

%% plotting
figure(3);
clf;
for ii=1:NN
    for jj=1:init.nrow
    
        ll=num2str(voltage(1,idx-cy+ii));
        x1(jj,:)=x(jj,:,idx-cy+ii);
    end
    x2=myimageanalysis1(x1);
    figure(3);
    subplot(cx,cx,ii)
    surf(1:init.ncol,1:init.nrow,x2);
    title(ll);
end
clearvars -except x2