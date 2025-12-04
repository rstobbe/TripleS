%================================================================
%  
%================================================================

classdef SimObj < handle

    properties (SetAccess = private)                    
        RelB1; OffRes; woff;
        Gave; GaveArr; PCave; SS; RfSpoil;
        Models; SeqElms; AcqElm;
        TeStep;
        MOD;
        SEQ;
        ARR;
        ToutMat;
    end

%==================================================================
% Init
%==================================================================    
    methods 
        % BaseClass
        function SIM = SimObj()
            SIM.Initialize;
        end
        % Initialize
        function Initialize(SIM)
            SIM.RelB1 = 1; 
            SIM.OffRes = 0; 
            SIM.woff = 0;
            SIM.Gave = 1; 
            SIM.GaveArr = [-1/2 0 1/2 1]; 
            SIM.PCave = 1; 
            SIM.SS = 1; 
            SIM.RfSpoil = 0;
        end
        % InitializeSequence
        function InitializeSequence(SIM,Length)
            SIM.SEQ = SequenceClass(Length);
        end      
        % InitializeModel
        function InitializeModel(SIM,Length)
            SIM.MOD = ModelClass(Length);
        end    
        
%==================================================================
% Set
%==================================================================           
        % SetMagnetRelated
        function SetMagnetRelated(SIM,RelB1,OffRes)              
            SIM.RelB1 = RelB1;
            SIM.OffRes = OffRes;
            SIM.woff = OffRes*2*pi/1000;
        end
        % SetReps
        function SetReps(SIM,Reps)
            SIM.SS = Reps;
        end
        % SetRelB1
        function SetRelB1(SIM,RelB1)
            SIM.RelB1 = RelB1;
        end
        % DisplayRelB1
        function DisplayRelB1(SIM,APP)  
            APP.relB1.Value = num2str(SIM.RelB1); 
        end
        % DisplaySequence
        function DisplaySequence(SIM,APP)      
            for n = 1:12
                SeqElmChar = num2str(n,'%02.0f');
                if strcmp(SIM.SEQ(n).Type,'Don''t Use')
                    SetSequenceVisibility(APP,SeqElmChar,SIM.SEQ(n).Type);
                end
                APP.(['length',SeqElmChar]).Value = num2str(SIM.SEQ(n).Dur);
                APP.(['shape',SeqElmChar]).Value = SIM.SEQ(n).RfShape;
                APP.(['idealflip',SeqElmChar]).Value = num2str(SIM.SEQ(n).Flip);
                APP.(['phase',SeqElmChar]).Value = num2str(SIM.SEQ(n).Phase);
                APP.(['grads',SeqElmChar]).Value = num2str(SIM.SEQ(n).Grad);
                APP.(['pphasecyc',SeqElmChar]).Value = num2str(SIM.SEQ(n).Acq2AcqPhaseCyc);
                APP.(['step',SeqElmChar]).Value = num2str(SIM.SEQ(n).Step);
            end
        end
        % SetOffResonance
        function SetOffResonance(SIM,OffRes)
            SIM.OffRes = OffRes;
            SIM.woff = OffRes*2*pi/1000;
        end
        % DisplayOffResonance
        function DisplayOffResonance(SIM,APP)  
            APP.offres.Value = num2str(SIM.OffRes); 
        end
        % SetGeneralSequence
        function SetGeneralSequence(SIM,Gave,PCave,RfSpoil,SS)
            SIM.Gave = Gave;
            SIM.PCave = PCave;
            SIM.RfSpoil = RfSpoil;
            SIM.SS = SS;
        end
        % SetSequence
        function SetSequence(SIM,Type,Dur,RfShape,Flip,Phase,Grad,PhaseCyc,Step)
            if length(SIM.SEQ) ~= length(Type)
                error;
            end
            for n = 1:length(SIM.SEQ)
                SIM.SEQ(n).SetSequence(Type(n),Dur(n),RfShape(n),Flip(n),Phase(n),Grad(n),PhaseCyc(n),Step(n),SIM);
                if Type(n) == 6
                    SIM.AcqElm = n;
                end
            end
        end
        % SetSequenceElement
        function SetSequenceElement(SIM,ElmNum,Type,Dur,RfShape,Flip,Phase,Grad,PhaseCyc,Step)
            SIM.SEQ(ElmNum).SetSequence(Type,Dur,RfShape,Flip,Phase,Grad,PhaseCyc,Step,SIM);
            if strcmp(Type,'Acquire') 
                SIM.AcqElm = ElmNum;
            end
        end
        % GetSequenceElement
        function [Type,Dur,RfShape,Flip,Phase,Grad,PhaseCyc,Step] = GetSequenceElement(SIM,ElmNum)
            Type = SIM.SEQ(ElmNum).Type;
            Dur = SIM.SEQ(ElmNum).Dur;
            RfShape = SIM.SEQ(ElmNum).RfShape;
            Flip = SIM.SEQ(ElmNum).Flip;
            Phase = SIM.SEQ(ElmNum).Phase;
            Grad = SIM.SEQ(ElmNum).Grad;
            PhaseCyc = SIM.SEQ(ElmNum).Acq2AcqPhaseCyc;
            Step = SIM.SEQ(ElmNum).Step;
        end
        % SetFlipConstB1
        function SetFlipConstB1(SIM,Flip,APP)
            ElmNum = 1;
            [Type,Dur0,RfShape,Flip0,Phase,Grad,PhaseCyc,Step] = GetSequenceElement(SIM,ElmNum);
            if ~strcmp(Type,'RF Pulse')
                error
            end
            W1 = (Flip0/360)/Dur0;
            Dur = (Flip/360)/W1;
            Step = Dur;
            SIM.SetSequenceElement(ElmNum,Type,Dur,RfShape,Flip,Phase,Grad,PhaseCyc,Step);
            APP.idealflip01.Value = num2str(Flip); 
            APP.length01.Value = num2str(Dur);
            APP.step01.Value = num2str(Step);
        end
        
%==================================================================
% Simulate
%==================================================================          
        % BuildSequence
        function BuildSequence(SIM)    
            SIM.Models = length(SIM.MOD);
            SIM.SeqElms = length(SIM.SEQ);
            BuildSequenceArray(SIM);
        end
        % Simulate
        function Simulate(SIM)    
            SimulateSysObs(SIM);
        end
    
%==================================================================
% Output
%==================================================================   
        % TeMxy
        function [Vals] = TeMxy(SIM)    
            Vals = 100*squeeze(abs(SIM.ToutMat(4,SIM.TeStep,:) - SIM.ToutMat(3,SIM.TeStep,:)));
        end
        % TeT11s
        function [Vals] = TeT11s(SIM)    
            Vals = 100*squeeze(real(1i*SIM.ToutMat(3,SIM.TeStep,:)));
        end
        
%==================================================================
% Display Output
%==================================================================   
        % TeMxy
        function [Vals] = DispTeMxy(SIM,APP,Vals)    
            for n = 1:length(Vals)
                APP.(['te_val',num2str(n)]).Value = num2str(Vals(n));
                if Vals(n) == 0
                    APP.(['te_val',num2str(n)]).Value = '';
                end
            end
            APP.go.BackgroundColor = [0.96 0.96 0.96];
        end        
        
    end
end
        