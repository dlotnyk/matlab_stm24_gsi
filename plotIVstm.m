function iv=plotIVstm(x,ix,iy,NN,init)
%   function to plot both IV and DIV curves in the point and its
%   NN-neighbourhood
%   x - matrix what you want to plot
%   ix,iy - xy coordinates of point
%   NN - level of neighbourhood
%   init - initial structure
%   D.L.

tic;
voltage=linspace(init.bias-init.offset,-init.bias-init.offset,init.ramp);
iv=zeros(init.ramp,1);
%% finding NN neighborhood
if NN==0
    I = sub2ind([init.ncol init.nrow], ix, iy);
else
    [X, Y] = meshgrid(max(1,iy-NN):min(init.ncol,iy+NN), max(1,ix-NN):min(init.nrow,ix+NN));
    I = sub2ind([init.ncol init.nrow], X(:), Y(:));
end
%% plot
figure(2);
clf;
grid on;
hold on;
for ii=1:length(I)
    [s1,s2]=ind2sub([init.ncol init.nrow],I(ii));
    iv(:,1)=x(s1,s2,:);
    plot(voltage,iv,'-k')
end
%ylim([-2 2]);
hold off;
clearvars -except iv