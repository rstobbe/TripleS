%========================================================
% 
%========================================================

function [Pout,Aout] = CreatePulseArray(len,shape,ifa,phase,step)

N = round(len/step);
ifa = (ifa/180)*pi;

if shape == 1 | strcmp(shape,'Rect')  
   p90 = 1;
   w1 = (ifa*p90)/len;
   a = 0;
   Pout = w1 * gausswin(N,a);
   Pout = reshape(Pout,1,[]);
   Aout = ones(1,N)*phase;

elseif shape == 2
   p90 = 1.7;
   w1 = (ifa*p90)/len;
   a = 2;
   Pout = w1 * gausswin(N,a);
   Pout = reshape(Pout,1,[]);
   Aout = ones(1,N)*phase;

%   sinc...
%   p90 = 5.627;   
%   p90 = 5.99;
%   w1 = (ifa*p90)/len;
%   lobes = 5;
%   x = (-floor(N/2):1:ceil(N/2)-1);
%   x = x * (((lobes-1)/2+1)/floor(N/2));
%   %Pout = w1 * sinc(x);
%   Pout = w1 * sinc(x) .* hamming(length(x))';
%   Pout = reshape(Pout,1,[]);
%   Aout = ones(1,N)*phase;

elseif shape == 3
   p90 = 2.4;
   w1 = (ifa*p90)/len;
   a = 3;
   Pout = w1 * gausswin(N,a);
   Pout = reshape(Pout,1,[]);
   Aout = ones(1,N)*phase;

%   B = 0.005;                               %--- for a 500 ms adiabatic ---%
%   u = 180;
%   w1 = (ifa*20)/len;
%   adiabatic
%   B = 0.1;                               %--- for a 5 ms phase-modulated rect (non-adiabatic) ---%
%   u = 100;
%   w1 = (ifa*2)/len;
%   t = [-len/2:step:len/2-step];
%   Pout = w1 * sech(B*t);
%   Aout = angle(exp(i*u*log(sech(B*t))));
%   Aout = 180*Aout/pi;
%   test = 0;
   
elseif shape == 4                       % This is actually a 5 lobe sinc
%   fix
   %p90 = 5.627;   
   p90 = 5.99;
   w1 = (ifa*p90)/len;
   lobes = 5;
   x = (-floor(N/2):1:ceil(N/2)-1);
   x = x * (((lobes-1)/2+1)/floor(N/2));
   %Pout = w1 * sinc(x);
   Pout = w1 * sinc(x) .* hamming(length(x))';
   Pout = reshape(Pout,1,[]);
   Aout = ones(1,N)*phase;
   
elseif shape == 5                       % This is actually a 7 lobe sinc
   fix
   lobes = 5;
   p90 = 9.6134;
   w1 = (ifa*p90)/len;
   x = [-floor(N/2):1:ceil(N/2)-1];
   x = x * (lobes/floor(N/2)); 
   Pout = sinc(x);
   Pout = Pout * w1;
   Pout = reshape(Pout,1,[]);
   Aout = ones(1,N)*phase;
end

%-------------------------------------
% Plot pulse BW
%-------------------------------------
P = 0;
if P == 1
    figure(100);
    f = 1/step;
    ZF = 8192;
    test = zeros(1,ZF);
    test(1:length(Pout)) = Pout;
    FT = fft(test);
    FT = fftshift(abs(FT));
    F = (-(f/2):f/ZF:(f/2)-f/ZF)*1000;
    plot(F,FT/max(FT));
    axis([-1000 1000 0 1.05]);
    xlabel('Hz');
end

