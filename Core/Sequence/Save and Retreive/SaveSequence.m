%========================================================
% 
%========================================================

function SaveSequence(APP,Event)

%---------------------------------------------------
% Location
%---------------------------------------------------
Name = APP.SeqName.Value;
[file,path] = uiputfile('*.mat','Save Sequence',[APP.Paths.SequencePath,'\',Name,'.mat']);
Name = strtok(file,'.');
if Name == 0
    return
end
APP.Paths.SequencePath = path;
APP.SeqName.Value = Name;

%---------------------------------------------------
% Get Sequence
%---------------------------------------------------
for n = 1:12
    SeqElmChar = num2str(n,'%02.0f');
    SavedSeq.Type{n} = APP.(['type',SeqElmChar]).Value;
    SavedSeq.Dur{n} = str2double(APP.(['length',SeqElmChar]).Value);
    SavedSeq.RFShape{n} = APP.(['shape',SeqElmChar]).Value;
    SavedSeq.Flip{n} = str2double(APP.(['idealflip',SeqElmChar]).Value);
    SavedSeq.Phase{n} = str2double(APP.(['phase',SeqElmChar]).Value);
    SavedSeq.Grad{n} = str2double(APP.(['grads',SeqElmChar]).Value);
    SavedSeq.PhaseCyc{n} = str2double(APP.(['pphasecyc',SeqElmChar]).Value);
    SavedSeq.Step{n} = str2double(APP.(['step',SeqElmChar]).Value);
    SavedSeq.Seg = APP.segmentsequence.Value;
end    
    
%---------------------------------------------------
% Save
%---------------------------------------------------
save([path,file],'SavedSeq');








