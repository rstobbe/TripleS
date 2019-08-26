%========================================================
% 
%========================================================

function [Time,Val] = ReturnSpinEvolution(APP,Model,Type)

%---------------------------------------------------
% Data
%---------------------------------------------------
ToutMat = APP.SIM.ToutMat;
Time = APP.SIM.ARR.time;
   
if strcmp(Type,'T10')
    Val = ToutMat(2,:,Model);
elseif strcmp(Type,'T11s')
    Val = 1i*ToutMat(3,:,Model);
elseif strcmp(Type,'T11a') 
    Val = ToutMat(4,:,Model);
elseif strcmp(Type,'T11')
    Val = abs(ToutMat(4,:,Model) - ToutMat(3,:,Model));
elseif strcmp(Type,'T20') 
    Val = ToutMat(5,:,Model);
elseif strcmp(Type,'T21s') 
    Val = 1i*ToutMat(6,:,Model);        
elseif strcmp(Type,'T21a')
    Val = ToutMat(7,:,Model);        
elseif strcmp(Type,'T21')
    Val = abs(ToutMat(7,:,Model) - ToutMat(6,:,Model));    
elseif strcmp(Type,'T22s') 
    Val = ToutMat(8,:,Model);
elseif strcmp(Type,'T22a') 
    Val = 1i*ToutMat(9,:,Model);    
elseif strcmp(Type,'T22')
    Val = abs(ToutMat(9,:,Model) - ToutMat(8,:,Model));    
elseif strcmp(Type,'T30')
    Val = ToutMat(10,:,Model);
elseif strcmp(Type,'T31s') 
    Val = 1i*ToutMat(11,:,Model);
elseif strcmp(Type,'T31a') 
    Val = ToutMat(12,:,Model);
elseif strcmp(Type,'T31')
    Val = abs(ToutMat(12,:,Model) - ToutMat(11,:,Model));    
elseif strcmp(Type,'T32s') 
    Val = ToutMat(13,:,Model);
elseif strcmp(Type,'T32a') 
    Val = 1i*ToutMat(14,:,Model);
elseif strcmp(Type,'T32')
    Val = abs(ToutMat(14,:,Model) - ToutMat(13,:,Model));    
elseif strcmp(Type,'T33s') 
    Val = 1i*ToutMat(15,:,Model);
elseif strcmp(Type,'T33a') 
    Val = ToutMat(16,:,Model);
elseif strcmp(Type,'T33')
    Val = abs(ToutMat(16,:,Model) - ToutMat(15,:,Model));
end
Val = real(Val);