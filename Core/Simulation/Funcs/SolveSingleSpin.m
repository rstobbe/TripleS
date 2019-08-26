%========================================================
% 
%========================================================

function T = SolveSingleSpin(TotSolSteps,SSnum,StepDur,w1,TxA,woff,wq,J0,J1,J2,T,iPC,iGA)

for iSS = 1:SSnum      
    for n = 1:TotSolSteps
        T(:,n+1) = SpinDynamicsRobTotal3(StepDur(n),w1(iPC,iGA,iSS,n),TxA(iPC,iGA,iSS,n),woff(iPC,iGA,iSS,n),wq,J0,J1,J2,T(:,n));
    end
    if iSS < SSnum
        T(:,1) = T(:,n+1);
    end
end

