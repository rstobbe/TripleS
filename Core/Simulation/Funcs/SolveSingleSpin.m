%========================================================
% 
%========================================================

function T = SolveSingleSpin(TotSolSteps,SSnum,StepDur,w1,TxA,RxA,woff,wq,J0,J1,J2,T,iPC,iGA)

MzEndPrev = 1;
for iSS = 1:SSnum      
    for n = 1:TotSolSteps
        T(:,n+1) = SpinDynamicsRobTotal3(StepDur(n),w1(iPC,iGA,iSS,n),TxA(iPC,iGA,iSS,n),woff(iPC,iGA,iSS,n),wq,J0,J1,J2,T(:,n));
    end
    if iSS < SSnum
        T(:,1) = T(:,n+1);
        MzEndNew = real(T(2,n+1));
        if round(MzEndNew*100000) == round(MzEndPrev*100000)
            break
        end
        MzEndPrev = MzEndNew;
    end
end
T = PhaseChange(-RxA(iSS),T);

