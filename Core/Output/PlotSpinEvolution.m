%========================================================
% 
%========================================================

function PlotSpinEvolution(APP,Event)

%---------------------------------------------------
% Data
%---------------------------------------------------
plotlines = 1;
labelfont = 10;
axisfont = 8;
legendfont = 7;
graphsize = [4 4 4.5 3.5];
linewidth = 1;

%---------------------------------------------------
% Data
%---------------------------------------------------
ToutMat = APP.SIM.ToutMat;
time = APP.SIM.ARR.time;

%---------------------------------------------------
% Observables to Plot
%---------------------------------------------------
figure(1029340923);
hold on;

for k = 1:6
    if strcmp(APP.(['modelnum',num2str(k)]).Value,'Don''t Use')
        continue
    elseif strcmp(APP.(['modelnum',num2str(k)]).Value,'Model 1')
        mod = 1;
    elseif strcmp(APP.(['modelnum',num2str(k)]).Value,'Model 2')
        mod = 2;
    elseif strcmp(APP.(['modelnum',num2str(k)]).Value,'Model 3')
        mod = 3;
    end
    
    if strcmp(APP.(['observe',num2str(k)]).Value,'T10')
        A = ToutMat(2,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T11s')
        A = 1i*ToutMat(3,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T11a') 
        A = ToutMat(4,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T11')
        A = abs(ToutMat(4,:,mod) - ToutMat(3,:,mod));
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T20') 
        A = ToutMat(5,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T21s') 
        A = 1i*ToutMat(6,:,mod);        
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T21a')
        A = ToutMat(7,:,mod);        
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T21')
        A = abs(ToutMat(7,:,mod) - ToutMat(6,:,mod));    
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T22s') 
        A = ToutMat(8,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T22a') 
        A = 1i*ToutMat(9,:,mod);    
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T22')
        A = abs(ToutMat(9,:,mod) - ToutMat(8,:,mod));    
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T30')
        A = ToutMat(10,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T31s') 
        A = 1i*ToutMat(11,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T31a') 
        A = ToutMat(12,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T31')
        A = abs(ToutMat(12,:,mod) - ToutMat(11,:,mod));    
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T32s') 
        A = ToutMat(13,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T32a') 
        A = 1i*ToutMat(14,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T32')
        A = abs(ToutMat(14,:,mod) - ToutMat(13,:,mod));    
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T33s') 
        A = 1i*ToutMat(15,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T33a') 
        A = ToutMat(16,:,mod);
    elseif strcmp(APP.(['observe',num2str(k)]).Value,'T33')
        A = abs(ToutMat(16,:,mod) - ToutMat(15,:,mod));
    end
    line = APP.(['linetype',num2str(k)]).Value;
    lbl = {[APP.(['modelnum',num2str(k)]).Value,' ',APP.(['observe',num2str(k)]).Value]};
    plot(time,100*real(A),line,'linewidth',linewidth);
    if k == 1
        LBL1 = lbl;
    else
        LBL1 = cat(1,LBL1,lbl);
    end
end
plot([0 max(time)],[0 0],'k:');

SegBounds = APP.SIM.ARR.SegBounds;
for n = 2:length(SegBounds)-1
    plot([SegBounds(n) SegBounds(n)],[-100 100],'k:');
end

ylim([-100 100]);
xlim([0 max(time)]);
set(gca,'fontsize',axisfont);
set(gca,'fontweight','bold');
set(gca,'xticklabelmode','auto');
xlabel('(ms)','fontsize',labelfont);
ylabel('Relative Magnetic Moment','fontsize',labelfont);
set(gcf,'units','inches');
set(gcf,'position',graphsize);
set(gca,'Position',[0.12 0.12 0.8 0.7]);
box on;