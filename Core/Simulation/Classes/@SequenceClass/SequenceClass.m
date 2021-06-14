%================================================================
%  
%================================================================

classdef SequenceClass < handle

    properties (SetAccess = private)                    
        Type;
        Dur;
        RfShape;
        Flip;
        Phase;
        Grad;
        PhaseCyc;
        Step;
        gwoff; w1; TxA; RxA;
        SolSteps;
    end

%==================================================================
% Init
%==================================================================    
    methods 
        % SequenceClass
        function SEQ = SequenceClass(Length)
            if nargin ~= 0
                SEQ(Length) = SequenceClass;
            end
        end
       
%==================================================================
% Set
%==================================================================           
        % SetElements
        function SetSequence(SEQ,Type,Dur,RfShape,Flip,Phase,Grad,PhaseCyc,Step,SIM)
            SEQ.Type = Type;
            SEQ.Dur = Dur;
            SEQ.RfShape = RfShape;
            SEQ.Flip = Flip;
            SEQ.Phase = Phase;                
            SEQ.Grad = Grad;
            SEQ.PhaseCyc = PhaseCyc;
            SEQ.Step = Step;
            CreateSequence(SEQ,SIM);
            SEQ.SolSteps = length(SEQ.w1);          
        end
    end
end
        