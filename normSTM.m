function y=normSTM(x,v,n1,n2,init)
%  function to normalize both IV and dIV curves
%  y - normalized matrix
%  x - initial matrix
%  v - voltage for normalizatin
%  n1 - elementary avareging (recommeded value 3)
%  n2 - number of neighbours to left and to right (recommeded values 40 - 50)
%  init - initialization structure
%  D.L.

tic;
flag1=0; % if flag==1 plot some figure
%% performing normalization
voltage=linspace(init.bias-init.offset,-init.bias-init.offset,init.ramp);
voltage1=voltage';% need to update
idx=knnsearch(voltage1,v);
y=zeros(init.nrow,init.ncol,init.ramp);
for ii=1:init.ncol
    for jj=1:init.nrow
        average=mean(x(jj,ii,max(1,idx-n2):min(init.ramp,idx+n2)));
        x(jj,ii,:)=x(jj,ii,:)/average;
        y(jj,ii,:)=medfilt1(x(jj,ii,:),n1);
       
    end
end
% y=x;
%% testing plotting
if flag1==1
    iv=zeros(init.ramp,1);
    iv(:,1)=y(4,4,:);
    figure(1);
    clf;
    grid on;
    plot(voltage,iv);
    clear iv;
end
clearvars -except y
toc;
        
        