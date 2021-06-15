%========================================================
% (v1a)
%========================================================

function SEQ = CreateSequence(SEQ,SIM)

%------------------------------------------
% Delay
%------------------------------------------    
if strcmp(SEQ.Type,'Delay') 
    SEQ.gwoff = zeros(1,round(SEQ.Dur/SEQ.Step));               
    SEQ.w1 = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.TxA = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.RxA = 0;
    
%------------------------------------------
% RF Pulse
%------------------------------------------
elseif strcmp(SEQ.Type,'RF Pulse') 
    SEQ.gwoff = zeros(1,round(SEQ.Dur/SEQ.Step));     
    [SEQ.w1,SEQ.TxA] = CreatePulseArray(SEQ.Dur,SEQ.RfShape,SEQ.Flip,SEQ.Phase,SEQ.Step);
    SEQ.RxA = 0;
    
%------------------------------------------
% Gradient
%------------------------------------------    
elseif strcmp(SEQ.Type,'Gradient Spoil')  
    SEQ.gwoff = (pi/SEQ.Dur) * ones(1,round(SEQ.Dur/SEQ.Step));               
    SEQ.w1 = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.TxA = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.RxA = 0; 
    
%------------------------------------------
% Acquire
%------------------------------------------
elseif strcmp(SEQ.Type,'Acquire')  
    SEQ.gwoff = zeros(1,round(SEQ.Dur/SEQ.Step));     
    SEQ.w1 = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.TxA = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.RxA = SEQ.Phase;     
end



