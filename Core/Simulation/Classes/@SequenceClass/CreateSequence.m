%========================================================
% (v1a)
%========================================================

function SEQ = CreateSequence(SEQ,SIM,iSS,iGA,iPC)

%------------------------------------------
% Delay
%------------------------------------------    
if (SEQ.Type == 2) | strcmp(SEQ.Type,'Delay') 
    SEQ.gwoff = zeros(1,round(SEQ.Dur/SEQ.Step));               
    SEQ.w1 = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.TxA = zeros(1,round(SEQ.Dur/SEQ.Step));

%------------------------------------------
% RF Pulse
%------------------------------------------
elseif SEQ.Type == 3 | strcmp(SEQ.Type,'Pulse') 
    SEQ.gwoff = zeros(1,round(SEQ.Dur/SEQ.Step));     
    [SEQ.w1,SEQ.TxA] = CreatePulseArray(SEQ.Dur,SEQ.RfShape,SEQ.Flip,SEQ.Phase,SEQ.Step);
    rfspoil = 0;
    if SIM.SS > 1  
        if SIM.RfSpoil ~= 0
            error;                                                  % RF spoil needs fixing
            SEQ.TxA = SEQ.TxA + (iSS-1)*Seq(k).pcycle;              
            rfspoil = 1;
        end
    end
    if SIM.PCave > 1
        if rfspoil == 1
            error;                                                  % need to solve how to do both
        end
        SEQ.TxA = SEQ.TxA + (iPC-1)*Seq(k).pcycle;                  % Acq-2-Acq
    end
    
%------------------------------------------
% Gradient
%------------------------------------------    
elseif SEQ.Type == 4 | strcmp(SEQ.Type,'Gradient')  
%  ---  use 'gwoff'    
%     wof{k} = (iGA/tGA)*Create_Gradient_Array(Seq(k).length,Seq(k).step,Seq(k).shape,Seq(k).wgradt,Anlz.VoxSze) + Anlz.wof;           
%     w1{k} = zeros(1,round(Seq(k).length/Seq(k).step));
%     Tx_A{k} = w1{k};

%------------------------------------------
% PulseGrad
%------------------------------------------
elseif SEQ.Type == 5 | strcmp(SEQ.Type,'PulseGrad')  
%     wof{k} = (GA/tGA)*Create_Gradient_Array(Seq(k).length,Seq(k).step,Seq(k).shape,Seq(k).wgradt,Anlz.VoxSze) + Anlz.wof;
%     [w1{k},Tx_A{k}] = CreatePulseArray(Seq(k).length,Seq(k).shape,Seq(k).ifa,Seq(k).phase,Seq(k).step);
%     if strcmp(Anlz.PCtype,'Acq-to-Acq PC')
%         Tx_A{k} = Tx_A{k} + (SS-1)*Seq(k).pcycle;
%     elseif strcmp(Anlz.PCtype,'Ave-to-Ave PC')
%         Tx_A{k} = Tx_A{k} + (PCA-1)*Seq(k).pcycle;
%     end
    
%------------------------------------------
% RF Pulse
%------------------------------------------
elseif SEQ.Type == 6 | strcmp(SEQ.Type,'Acquire')  
    SEQ.gwoff = zeros(1,round(SEQ.Dur/SEQ.Step));     
    SEQ.w1 = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.TxA = zeros(1,round(SEQ.Dur/SEQ.Step));
    SEQ.RxA = 0;    
    if SIM.RfSpoil ~= 0
        error;                  % finish
    end
    if SIM.PCave > 1
        error;                  % finish
        if strcmp(Anlz.PCtype,'Acq-to-Acq PC')
            Rx_A = (SS-1)*Seq(k).pcycle + Seq(k).phase;
        elseif strcmp(Anlz.PCtype,'Ave-to-Ave PC')
            Rx_A = (PCA-1)*Seq(k).pcycle + Seq(k).phase;
        end
    end
end



