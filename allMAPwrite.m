function skip=allMAPwrite(x)
%  function to read maps from path smooth them all and write to file path1
%  D.L.
a=x;
path='d:\dis3\tsamuely\01\01.gsi';
path1='d:\dis3\tsamuely\01\025.gsi';
%path='c:\work\matlab\tsamuely\GSItest\g8x8tv64v5_2.gsi'; % path to original file
%path1='c:\work\matlab\tsamuely\GSItest\02.gsi'; % path to the new file
[begbytes,sh,ncol,nrow,ramp,bias,nx]=gsiread(path);
voltage=linspace(bias,-bias,ramp);
%copy header+topograhy
copyfile(path,path1,'f');
skip=ncol*nrow*nx; %number of bytes per 1 map
for kk=1:ramp
    kk
    [ymap,idt]=singlemapread(voltage(1,kk),path); % read map
    smy=myimageanalysis1(ymap); % smooth map
    fid=fopen(path1,'r+','l');
    for ii=1:ncol
        for jj=1:nrow
            skbytes=begbytes+skip+skip*(idt-1)+(ii-1)*ncol*nx+(jj-1)*nx;
            fseek(fid,skbytes,'bof');
            fwrite(fid,smy(ii,jj),sh);
        end
    end
    fclose(fid);
    clear ymap; clear smy; clear idt;
end
