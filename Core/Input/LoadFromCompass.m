%========================================================
% 
%========================================================

function LoadFromCompass(APP,SavedModel,SavedSeq)

%---------------------------------------------------
% Model
%---------------------------------------------------
for n = 1:3
    ModChar = num2str(n);
    APP.(['SDModel',ModChar]).Value = SavedModel(n).Name;
    APP.(['J0',ModChar]).Value = num2str(SavedModel(n).J0);
    APP.(['J1',ModChar]).Value = num2str(SavedModel(n).J1);
    APP.(['J2',ModChar]).Value = num2str(SavedModel(n).J2);
    APP.(['dist',ModChar]).Value = SavedModel(n).dist;
    APP.(['p1',ModChar]).Value = num2str(SavedModel(n).p1);
    APP.(['p2',ModChar]).Value = num2str(SavedModel(n).p2);
    APP.(['nave',ModChar]).Value = num2str(SavedModel(n).nave);

    if strcmp(SavedModel(n).J0,'')
        APP.(['te_val',ModChar]).Enable = 'off';
        APP.(['J0',ModChar]).Enable = 'off';
        APP.(['J1',ModChar]).Enable = 'off';
        APP.(['J2',ModChar]).Enable = 'off';
        APP.(['dist',ModChar]).Enable = 'off';
    else
        APP.(['te_val',ModChar]).Enable = 'on';
        APP.(['J0',ModChar]).Enable = 'on';
        APP.(['J1',ModChar]).Enable = 'on';
        APP.(['J2',ModChar]).Enable = 'on';
        APP.(['dist',ModChar]).Enable = 'on';
        if strcmp(SavedModel(n).dist,'None')
            APP.(['p1',ModChar]).Enable = 'off';
            APP.(['p2',ModChar]).Enable = 'off';
            APP.(['nave',ModChar]).Enable = 'off';
        elseif strcmp(SavedModel(n).dist,'Delta')
            APP.(['p1',ModChar]).Enable = 'on';
            APP.(['p2',ModChar]).Enable = 'off';
            APP.(['nave',ModChar]).Enable = 'off';
        elseif strcmp(SavedModel(n).dist,'Gaussian')
            APP.(['p1',ModChar]).Enable = 'on';
            APP.(['p2',ModChar]).Enable = 'on';
            APP.(['nave',ModChar]).Enable = 'on';
        else
            error;              % finish
        end
    end
    
    J0 = str2double(SavedModel(n).J0);
    J1 = str2double(SavedModel(n).J1);
    J2 = str2double(SavedModel(n).J2);
    if isnan(J0)
        J0 = [];
        J1 = [];
        J2 = [];
    end
    dist = SavedModel(n).dist;
    p1 = str2double(SavedModel(n).p1);
    p2 = str2double(SavedModel(n).p2);
    Nave = str2double(SavedModel(n).nave);
    if isnan(p1)
        p1 = 0;
    end
    if isnan(p2)
        p2 = 0;
    end
    if isnan(Nave)
        Nave = 1;
    end
    APP.SIM.MOD(n).SetModel(J0,J1,J2,dist,p1,p2,Nave);    
end

%---------------------------------------------------
% Sequence
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






