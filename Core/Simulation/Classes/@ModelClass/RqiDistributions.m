%========================================================
% (v1a)
%========================================================

function MOD = RqiDistributions(MOD)

p1 = MOD.p1*2*pi;
p2 = MOD.p2*2*pi;

if strcmp(MOD.dist,'Gaussian')
    if p2 == 0
        if p1 == 0
            MOD.wq = zeros(1,MOD.Nave);
        else
            MOD.wq = p1*ones(1,MOD.Nave);
        end
        MOD.wgt = ones(1,MOD.Nave)/MOD.Nave;
        return
    end
    MOD.wq = p1+linspace(-3*p2,3*p2,MOD.Nave);
    spc = MOD.wq(2) - MOD.wq(1);
    MOD.wgt = spc*pdf('norm',MOD.wq,p1,p2);
    %---
%     test = sum(MOD.wgt)
%     figure(100);
%     plot(MOD.wq,MOD.wgt);
%     test2 = cdf('norm',linspace(0,3,100),0,1);
%     figure(101);
%     plot(linspace(0,3,100),test2);
    %---
    
elseif strcmp(MOD.dist,'Delta')
    MOD.wq = p1;                                % Delta function distribution
    MOD.wgt = 1;
    
elseif strcmp(MOD.dist,'None')
    MOD.wq = 0;                                 % No RSQI
    MOD.wgt = 1;
    
elseif strcmp(MOD.dist,'Uniform')
    MOD.wq = (0:((2*p1)/N):(2*p1));

elseif strcmp(MOD.dist,'Powder')
    if MOD.Nave == 1
        costheta = 0;
    else
        costheta = (0:1/(MOD.Nave-1):1);
    end
    MOD.wq = p1*(3*costheta.^2 - 1);
    %test = MOD.wq
    MOD.wgt = ones(1,MOD.Nave)/MOD.Nave;
end
    
%x = abs(normrnd(mean,sqrt(var),1,N));       % Combo
%wq = ((cos(theta)).^2) .* x;

%theta = rand(1,N)*2*pi;                      
%wq = ((cos(theta)).^2)*(2*mean);            % cosine squared distribution