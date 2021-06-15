%========================================================
% 
%========================================================

function SetSequenceInterface(APP,Event)

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
SeqElmId = Event.Source.Tag(1);
SeqElmChar = Event.Source.Tag(2:3);
Value = Event.Source.Value;
if strcmp(SeqElmId,'t')
    SetSequenceVisibility(APP,SeqElmChar,Value);
end

%---------------------------------------------------
% update SimObj
%---------------------------------------------------
SeqElm = str2double(SeqElmChar);
Type = APP.(['type',SeqElmChar]).Value;
Dur = str2double(APP.(['length',SeqElmChar]).Value);
RFShape = APP.(['shape',SeqElmChar]).Value;
Flip = str2double(APP.(['idealflip',SeqElmChar]).Value);
Phase = str2double(APP.(['phase',SeqElmChar]).Value);
Grad = str2double(APP.(['grads',SeqElmChar]).Value);
PhaseCyc = str2double(APP.(['pphasecyc',SeqElmChar]).Value);
if str2double(APP.segmentsequence.Value) == 0
    APP.(['step',SeqElmChar]).Value = num2str(Dur);
    Step = Dur;
else
    Step = str2double(APP.(['step',SeqElmChar]).Value);
    if isnan(Step)
        APP.(['step',SeqElmChar]).Value = num2str(Dur);
        Step = Dur;
    end    
    Dur = Step*round(Dur/Step);
    APP.(['length',SeqElmChar]).Value = num2str(Dur,'%8.8g');
end
APP.SIM.SetSequenceElement(SeqElm,Type,Dur,RFShape,Flip,Phase,Grad,PhaseCyc,Step);
APP.SIM.BuildSequence;

%---------------------------------------------------
% Draw Sequence
%---------------------------------------------------
DrawSequence(APP);
APP.SeqName.Value = '';

%--------------------------------------------
% Set TR
%--------------------------------------------
if isempty(APP.SIM.ARR.tArr)
    APP.TRep.Value = '';
else
    APP.TRep.Value = num2str(APP.SIM.ARR.tArr(end));
end


