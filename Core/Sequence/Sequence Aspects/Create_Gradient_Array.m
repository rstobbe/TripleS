%-------------------------------------------------
% Create Gradient Array
%  - LVL is max difference in w across voxel
%-------------------------------------------------

function [Gout] = Create_Gradient_Array(len,step,shape,GVal,VoxSze)

N = round(len/step);

LVL = 0.001*(GVal*VoxSze)*11.26*2*pi;              % GVal in mT/m  // VoxSze in mm

if shape == 1
    Gout(1:N) = LVL;

elseif shape == 2                               % just for plotting purposes - should be updated
    t = [1:1:ceil(N/1.2)];
    Gout = LVL * squeeze(ones(1,N));
    Gout(N-floor(N/1.2)+1:N) = LVL * cos((t/N*1.5)*pi);
end

