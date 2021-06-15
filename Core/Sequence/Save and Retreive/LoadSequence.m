%========================================================
% 
%========================================================

function LoadSequence(APP,Event)

%---------------------------------------------------
% Location
%---------------------------------------------------
[file,path] = uigetfile('*.mat','Load Sequence',[APP.Paths.SequencePath,'\*.mat']);
Name = strtok(file,'.');
if Name == 0
    return
end
APP.Paths.SequencePath = path;
APP.SeqName.Value = Name;

%---------------------------------------------------
% Load
%---------------------------------------------------
load([path,file],'SavedSeq');

%---------------------------------------------------
% Write Sequence
%---------------------------------------------------
APP.segmentsequence.Value = SavedSeq.Seg;
for n = 1:12
    SeqElmChar = num2str(n,'%02.0f');
    APP.(['type',SeqElmChar]).Value = SavedSeq.Type{n};
    APP.(['length',SeqElmChar]).Value = num2str(SavedSeq.Dur{n});
    APP.(['shape',SeqElmChar]).Value = SavedSeq.RFShape{n};
    APP.(['idealflip',SeqElmChar]).Value = num2str(SavedSeq.Flip{n});
    APP.(['phase',SeqElmChar]).Value = num2str(SavedSeq.Phase{n});
    APP.(['grads',SeqElmChar]).Value = num2str(SavedSeq.Grad{n});
    APP.(['pphasecyc',SeqElmChar]).Value = num2str(SavedSeq.PhaseCyc{n});
    APP.(['step',SeqElmChar]).Value = num2str(SavedSeq.Step{n});
    SetSequenceVisibility(APP,SeqElmChar,SavedSeq.Type{n});
    APP.SIM.SetSequenceElement(n,SavedSeq.Type{n},SavedSeq.Dur{n},SavedSeq.RFShape{n},...
                                SavedSeq.Flip{n},SavedSeq.Phase{n},SavedSeq.Grad{n},...
                                SavedSeq.PhaseCyc{n},SavedSeq.Step{n});
end    

%---------------------------------------------------
% Update
%---------------------------------------------------
APP.SIM.BuildSequence;

%---------------------------------------------------
% Draw Sequence
%---------------------------------------------------
DrawSequence(APP);

%--------------------------------------------
% Set TR
%--------------------------------------------
APP.TRep.Value = num2str(APP.SIM.ARR.tArr(end));







