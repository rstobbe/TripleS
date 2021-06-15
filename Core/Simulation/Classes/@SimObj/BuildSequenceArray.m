%========================================================
% (v1a)
%========================================================

function SIM = BuildSequenceArray(SIM)

%-----------------------------------------------------
% Build Array
%-----------------------------------------------------
SolSteps = [];
SegBounds = 0;
for iSeq = 1:SIM.SeqElms
    if isempty(SIM.SEQ(iSeq).Type) || strcmp(SIM.SEQ(iSeq).Type,'Don''t Use')  
        SegBounds(iSeq+1) = SegBounds(iSeq);
        continue
    end
    SolSteps(iSeq) = SIM.SEQ(iSeq).SolSteps;
    SegBounds(iSeq+1) = SegBounds(iSeq) + SIM.SEQ(iSeq).Dur;
end
if isempty(SolSteps)
    SIM.ARR.w1Arr = [];
    SIM.ARR.tArr = [];
    SIM.ARR.time = [];
    SIM.ARR.SegBounds = [];
    return
end
TotSolSteps = sum(SolSteps);
SolStepStart(1) = 1;
SolStepStop(1) = SIM.SEQ(1).SolSteps;
for iSeq = 2:SIM.SeqElms
    if isempty(SIM.SEQ(iSeq).Type) || strcmp(SIM.SEQ(iSeq).Type,'Don''t Use')  
        SolStepStart(iSeq) = SolStepStop(iSeq-1);
        SolStepStop(iSeq) = SolStepStart(iSeq);
        continue
    end
    SolStepStart(iSeq) = SolStepStop(iSeq-1)+1;
    SolStepStop(iSeq) = SolStepStart(iSeq)+SIM.SEQ(iSeq).SolSteps-1;    
end

SIM.TeStep = SolStepStart(SIM.AcqElm);

ARR.StepDur = zeros(1,TotSolSteps);
for iSeq = 1:SIM.SeqElms
    if isempty(SIM.SEQ(iSeq).Type) || strcmp(SIM.SEQ(iSeq).Type,'Don''t Use')  
        continue
    end
    ARR.StepDur(SolStepStart(iSeq):SolStepStop(iSeq)) = SIM.SEQ(iSeq).Step;
end

ARR.w1 = zeros(SIM.PCave,SIM.Gave,SIM.SS,TotSolSteps);
ARR.TxA = zeros(SIM.PCave,SIM.Gave,SIM.SS,TotSolSteps);
ARR.woff = zeros(SIM.PCave,SIM.Gave,SIM.SS,TotSolSteps);
for iPC = 1:SIM.PCave
    % update rfphase here
    for iGave = 1:SIM.Gave
        % update gradient woff here
        for iSS = 1:SIM.SS
            % update rfspoil here
            for iSeq = 1:SIM.SeqElms
                if isempty(SIM.SEQ(iSeq).Type) || strcmp(SIM.SEQ(iSeq).Type,'Don''t Use')  
                    continue
                end
                ARR.w1(iPC,iGave,iSS,SolStepStart(iSeq):SolStepStop(iSeq)) = SIM.SEQ(iSeq).w1 * SIM.RelB1;
                ARR.gwoff(iPC,iGave,iSS,SolStepStart(iSeq):SolStepStop(iSeq)) = SIM.SEQ(iSeq).gwoff;        % just for drawing 
                ARR.woff(iPC,iGave,iSS,SolStepStart(iSeq):SolStepStop(iSeq)) = SIM.GaveArr(iGave) * SIM.SEQ(iSeq).gwoff + SIM.woff;
                if iSS == 1
                    ARR.TxA(iPC,iGave,iSS,SolStepStart(iSeq):SolStepStop(iSeq)) = SIM.SEQ(iSeq).TxA;
                    if strcmp(SIM.SEQ(iSeq).Type,'Acquire')  
                        ARR.RxA(iSS) = SIM.SEQ(iSeq).RxA;
                    end
                else
                    ARR.TxA(iPC,iGave,iSS,SolStepStart(iSeq):SolStepStop(iSeq)) = ARR.TxA(iPC,iGave,iSS-1,SolStepStart(iSeq):SolStepStop(iSeq)) + SIM.SEQ(iSeq).Acq2AcqPhaseCyc;
                    if strcmp(SIM.SEQ(iSeq).Type,'Acquire') 
                        ARR.RxA(iSS) = ARR.RxA(iSS-1) + SIM.SEQ(iSeq).Acq2AcqPhaseCyc;
                    end
                end
            end
        end
    end
end
ARR.TotSolSteps = TotSolSteps;
SIM.ARR = ARR;

%-----------------------------------------------
% Timing
%-----------------------------------------------
w1 = squeeze(ARR.w1(1,1,1,:));
gwoff = squeeze(ARR.gwoff(1,1,1,:));
w1Arr = zeros(1,2*(length(w1)+1));
GArr = zeros(1,2*(length(gwoff)+1));
tArr = zeros(1,2*(length(w1)+1));
time = 0;
for n = 1:length(ARR.StepDur)
    w1Arr(2*n:2*n+1) = w1(n);
    GArr(2*n:2*n+1) = gwoff(n)/pi;
    tArr(2*n+1:2*n+2) = tArr(2*n) + ARR.StepDur(n);
    time(n+1) = time(n) + ARR.StepDur(n);
end
SIM.ARR.w1Arr = w1Arr;
SIM.ARR.GArr = GArr;
SIM.ARR.tArr = tArr;
SIM.ARR.time = time;
SIM.ARR.SegBounds = SegBounds;
