%========================================================
% 
%========================================================

function SegmentSequenceSwitch(APP,Event)

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
if str2double(Event.Value) == 0
   
%     %---------------------------------------------------
%     % update SimObj
%     %---------------------------------------------------
%     SeqElm = str2double(SeqElmChar);
%     Type = APP.(['type',SeqElmChar]).Value;
%     Dur = str2double(APP.(['length',SeqElmChar]).Value);
%     RFShape = APP.(['shape',SeqElmChar]).Value;
%     Flip = str2double(APP.(['idealflip',SeqElmChar]).Value);
%     Phase = str2double(APP.(['phase',SeqElmChar]).Value);
%     Grad = str2double(APP.(['grads',SeqElmChar]).Value);
%     PhaseCyc = str2double(APP.(['pphasecyc',SeqElmChar]).Value);
%     Step = Dur;
%     APP.SIM.SetSequenceElement(SeqElm,Type,Dur,RFShape,Flip,Phase,Grad,PhaseCyc,Step);
%     APP.SIM.BuildSequence;
% 
%     %---------------------------------------------------
%     % Draw Sequence
%     %---------------------------------------------------
%     DrawSequence(APP);
        
end


