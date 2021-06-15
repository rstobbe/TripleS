%========================================================
% 
%========================================================

function [Pout,Aout] = CreatePulseArray(len,shape,ifa,phase,step)

N = round(len/step);
ifa = (ifa/180)*pi;

if strcmp(shape,'Rect')  
   p90 = 1;
   w1 = (ifa*p90)/len;
   a = 0;
   Pout = w1 * gausswin(N,a);
   Pout = reshape(Pout,1,[]);
   Aout = ones(1,N)*phase;
end
