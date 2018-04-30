function skip=allIVwrite(x)
%  function to smooth ALL IV curves from path and write them to the new file in path1
%  skip and x unnecessary for a while
%  D.L.

a=x;
path='d:\dis3\tsamuely\01\01.gsi';
path1='d:\dis3\tsamuely\01\030.gsi';
%path='c:\work\matlab\tsamuely\GSItest\g8x8tv64v5_2.gsi'; % path to original file
%path1='c:\work\matlab\tsamuely\GSItest\02.gsi'; % path to the new file
[begbytes,sh,ncol,nrow,ramp,bias,nx]=gsiread(path);
volt=linspace(-bias,bias,ramp);
%copy header+topograhy
copyfile(path,path1,'f');
skip=ncol*nrow*nx; %number of bytes per 1 map


for ii=1:nrow
   ii
   tic;
    for jj=1:ncol
        smy=singleIVread(path,jj,ii);
        fid=fopen(path1,'r+','l');       
        for kk=1:ramp
            skbytes=begbytes+skip+(ii-1)*ncol*nx+(jj-1)*nx+(kk-1)*skip;
            fseek(fid,skbytes,'bof');
            fwrite(fid,smy(kk,1),sh);
        end
        clear kk;
        fclose(fid);
        clear smy;
    end
    toc;
end