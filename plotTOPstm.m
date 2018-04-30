function t1=plotTOPstm(top,init,flag)
%   function to plot topology
%   t1 - topography matrix tilted to horizontal
%   top - topography matrix 
%   init - structure of initial options
%   if flag=1 perform tilting of topology
%   D.L.
%top=top(1:init.nrow,:);
%top=top(:,1:init.ncol);
[b1,b2]=size(top);
a=init;
tic;
%% initialization
top1=top;
if flag==1

y=zeros(b2,1);
y1=zeros(b2,1);

x1=1:b2;
x=x1';
%y1(:,1)=top1(:,80);
%% tilting
%f1=fit(x,y1,'poly1');
for ii=1:b2
    y(:,1)=top(ii,:);
    f=fit(x,y,'poly1');
    top1(:,ii)=top(:,ii)-f.p1*x(ii,1);
end
%for jj=1:init.ncol
%    top1(jj,:)=top(jj,:)-f1.p1*x(jj,1);
%end
end
%% smooth
[t1,t2]=myimageanalysis1(top1);
t1=t1(1:init.nrow,:);
t1=t1(:,1:init.ncol);
[s1,s2]=size(t2);
%% plot
figure(6);
surf(1:init.ncol,1:init.nrow,t1);
%surf(1:s1,1:s2,t2);
title('Topography');
toc;
clearvars -except t1