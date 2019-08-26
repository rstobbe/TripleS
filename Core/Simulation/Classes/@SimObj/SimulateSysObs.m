%========================================================
% (v1a)
%========================================================

function SIM = SimulateSysObs(SIM)

%-----------------------------------------------------
% Solve 
%-----------------------------------------------------
%poolobj = gcp;
%addAttachedFiles(poolobj,{'SolveSingleSpin.m','SpinDynamicsRobTotal3.m'})
fSolveSingleSpin = @(TotSolSteps,SSnum,StepDur,w1,TxA,woff,wq,J0,J1,J2,T,iPC,iGA) SolveSingleSpin(TotSolSteps,SSnum,StepDur,w1,TxA,woff,wq,J0,J1,J2,T,iPC,iGA);

ARR = SIM.ARR;
TotSolSteps = ARR.TotSolSteps;
StepDur = ARR.StepDur;
w1 = ARR.w1;
TxA = ARR.TxA;
woff = ARR.woff;

SSnum = SIM.SS;
PCaves = SIM.PCave;
Gaves = SIM.Gave;
Models = SIM.Models;

SIM.ToutMat = zeros(16,TotSolSteps+1,Models);

Tstart = [1;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
for iMod = 1:Models   
	if isempty(SIM.MOD(iMod).J0)
        continue;
    end
    RqAves = SIM.MOD(iMod).Nave;
    T = zeros(16,TotSolSteps+1,PCaves,Gaves,RqAves);
    T(:,1,:,:,:) = repmat(Tstart,1,1,PCaves,Gaves,RqAves);
    MOD = SIM.MOD(iMod);
    J0 = MOD.J0;
    J1 = MOD.J1;
    J2 = MOD.J2; 
    wqArr = MOD.wq;
    parallel = 0;
    if SIM.MOD(iMod).Nave > 1
        if TotSolSteps*SIM.SS*SIM.Gave*SIM.PCave > 100
            parallel = 1;
        end
        if SIM.MOD(iMod).Nave >= 50
            parallel = 1;
        end
    end
    if parallel == 0
        for iRQ = 1:RqAves
            wq = wqArr(iRQ);
            for iPC = 1:PCaves 
                for iGA = 1:Gaves
                    T(:,:,iPC,iGA,iRQ) = SolveSingleSpin(TotSolSteps,SSnum,StepDur,w1,TxA,woff,wq,J0,J1,J2,T(:,:,iPC,iGA,iRQ),iPC,iGA);
                end
            end
        end
    elseif parallel == 1
        parfor iRQ = 1:RqAves
            wq = wqArr(iRQ);
            for iPC = 1:PCaves 
                for iGA = 1:Gaves                 
                    T(:,:,iPC,iGA,iRQ) = feval(fSolveSingleSpin,TotSolSteps,SSnum,StepDur,w1,TxA,woff,wq,J0,J1,J2,T(:,:,iPC,iGA,iRQ),iPC,iGA);
                end
            end
        end
    end
    Tout = T;
    Tout = mean(Tout,3);
    Tout = squeeze(mean(Tout,4));
    wgtmat = repmat(MOD.wgt,16,1,TotSolSteps+1);
    wgtmat = permute(wgtmat,[1,3,2]);
    Tout = Tout.*wgtmat;
    Tout = sum(Tout,3);
    SIM.ToutMat(:,:,iMod) = Tout;
end



