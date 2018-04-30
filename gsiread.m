function init=gsiread(path)
%   function to read gsi file
%   Note: you required function ALLWORDS.m
%   Memory distribution: Header- [1,begbytes) bytes; topogology - [begbytes,begbytes+ncol*nrow*nx]
%   (size of topology is equal to number of row*number of col * bx (bytes per 1
%   value))
%   init - is a structure
%   D.L.

%path='d:\dis3\tsamuely\01\g8x8tv64v5_2.gsi';
%% header reading part
fid=fopen(path);
y = fgetl(fid);
while ~strcmp(y,'[Header end]') %part to find header skip
    if ~isnan(strfind(y,'Image header size:'))
        a=allwords(y);
        b=cell2mat(a(4));
        init.begbytes=str2double(b);
    end
    if ~isnan(strfind(y,'Image Data Type:'))%find data type 'short','float','double' 
        a=allwords(y);
        init.dattype=cell2mat(a(4));
    end
     if ~isnan(strfind(y,'Number of columns:'))%find number of coloumns
        a=allwords(y);
        b=cell2mat(a(4));
        init.ncol=str2double(b);
     end
    if ~isnan(strfind(y,'Number of rows:'))%number of rows
        a=allwords(y);
        b=cell2mat(a(4));
        init.nrow=str2double(b);
    end
    if ~isnan(strfind(y,'Number of points per ramp:'))%finding number of points per 1 IV curve
        a=allwords(y);
        b=cell2mat(a(6));
        init.ramp=str2double(b);
    end
    if ~isnan(strfind(y,'Conversion factor 0 for input channel:')) %conversion factor
        a=allwords(y,' ');
        b=cell2mat(a(7));
        init.f1=str2num(b);
    end
    if ~isnan(strfind(y,'Image 000:'))  % voltage bias
        y
        a=allwords(y,' ');
        b=cell2mat(a(3));
        init.bias=str2num(b);
    end
    
y = fgetl(fid);
end
fclose(fid);
init.sh=[init.dattype];
% bytes per 1 value
if strcmp(init.sh,'short')
    init.nx=2;
end
if strcmp(init.sh,'float')
    init.nx=4;
end
if strcmp(init.sh,'double')
    init.nx=8;
end
init.offset=0; % offset
