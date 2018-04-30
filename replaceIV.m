function [z,np]=replaceIV(x,sl,NN,thresh,thresh2,init)
%   function to replace bad IV with average on NN neighbourhood
%   y - replaced matrix
%   np - LINEAR indexes of all bad points (to trasform use ind2sub)
%   sl - martix with all slopes (use badPOINTS.m)
%   NN - level of neighborhood (recommended values 2 or more)
%   thresh - values of slopes will be cutted (bad points usualy have sl<50)
%   init - structure
%   D.L.

voltage=linspace(init.bias-init.offset,-init.bias-init.offset,init.ramp);
voltage1=voltage';% need to update
flag1=0;
%% replace bad point with average of GOOD neighbourhood
tic;
np1=find(sl<abs(thresh));
np2=find(sl>abs(thresh2));
np=vertcat(np1,np2);
y=x;
for ii=1:length(np)
        iv=zeros(init.ramp,1);
        iv1=zeros(init.ramp,1);
        [c1,c2]=ind2sub([init.nrow init.ncol],np(ii,1));
        [X, Y] = meshgrid(max(1,c2-NN):min(init.nrow,c2+NN), max(1,c1-NN):min(init.ncol,c1+NN)); %find mesh
        I = sub2ind([init.nrow init.ncol], X(:), Y(:)); % find NN-neighbourhood
        ni=sub2ind([init.nrow init.ncol], c1, c2); % index of point itself
        [C,ia,ib] = intersect(I,np);               % check for another bad points
        I(ia)=[];                               % exclude bad points from neighborhood
        [C1,ia1,ib1] = intersect(I,ni);
        I(ia1)=[];                               % exclude point itself
 
        [d1,d2]=ind2sub([init.nrow init.ncol],I);
        for jj=1:length(d1)
            iv1(:,1)=x(d1(jj,1),d2(jj,1),:);
            iv=iv+iv1;
        end
        y(c1,c2,:)=iv(:,1)/length(d1);
    
end
%% find NaN values (if were) and replace them
sl1=badPOINTS(y,init);
np3=find(isnan(sl1));
z=y;
NN=NN+2;
for ii=1:length(np3)
        iv=zeros(init.ramp,1);
        iv1=zeros(init.ramp,1);
        [c1,c2]=ind2sub([init.nrow init.ncol],np3(ii,1));
        max(1,c2-NN);
        min(init.nrow,c2+NN);
        max(1,c1-NN);
        min(init.ncol,c1+NN);
        [X, Y] = meshgrid(max(1,c2-NN):min(init.nrow,c2+NN), max(1,c1-NN):min(init.ncol,c1+NN)); %find mesh
        I = sub2ind([init.nrow init.ncol], X(:), Y(:)); % find NN-neighbourhood
        ni=sub2ind([init.nrow init.ncol], c1, c2); % index of point itself
        [C,ia,ib] = intersect(I,np3);               % check for another bad points
        I(ia)=[];                               % exclude bad points from neighborhood
        [C1,ia1,ib1] = intersect(I,ni);
        I(ia1)=[];                               % exclude point itself
 
        [d1,d2]=ind2sub([init.nrow init.ncol],I);
        for jj=1:length(d1)
            iv1(:,1)=y(d1(jj,1),d2(jj,1),:);
            iv=iv+iv1;
        end
        z(c1,c2,:)=iv(:,1)/length(d1);
    
end
clear ii; clear jj;


toc;
%% plotting
if flag1==1
[c1,c2]=ind2sub([init.ncol init.nrow],np(1,1));
iv(:,1)=x(c1,c2,:);
figure(1);
clf;
plot(voltage,iv)
end
clearvars -except z np