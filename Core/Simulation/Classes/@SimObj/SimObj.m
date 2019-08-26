%================================================================
%  
%================================================================

classdef SimObj < handle

    properties (SetAccess = private)                    
        B1; OffRes; woff;
        Gave; PCave; SS; RfSpoil;
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
            SIM.B1 = 1; SIM.OffRes = 0; SIM.woff = 0;
            SIM.Gave = 1; SIM.PCave = 1; SIM.SS = 1; SIM.RfSpoil = 0;
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
        function SetMagnetRelated(SIM,B1,OffRes)
            SIM.B1 = B1;
            SIM.OffRes = OffRes;
            SIM.woff = OffRes*2*pi/1000;
        end
        % SetB1
        function SetB1(SIM,B1)
            SIM.B1 = B1;
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
            PhaseCyc = SIM.SEQ(ElmNum).PhaseCyc;
            Step = SIM.SEQ(ElmNum).Step;
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
    end
end
        