%========================================================
% 
%========================================================

function DrawSequence(APP)

if isempty(APP.SIM.ARR.tArr)
    cla(APP.axes1);
    cla(APP.axes13);
    return
end

plot(APP.axes1,APP.SIM.ARR.tArr,1000*APP.SIM.ARR.w1Arr/(2*pi),'b','linewidth',2);
APP.axes1.XLim = [0 max(APP.SIM.ARR.time)];
APP.axes1.YLim = [0 1000];
APP.axes1.BackgroundColor = [0.5 0.5 0.5];
APP.axes1.XColor = [1 1 1];
APP.axes1.YColor = [1 1 1];
APP.axes1.XLabel.String = '(ms)';
APP.axes1.YLabel.String = 'Pulse (Hz)';

plot(APP.axes13,APP.SIM.ARR.tArr,zeros(size(APP.SIM.ARR.w1Arr)),'r','linewidth',2);
APP.axes13.XLim = [0 max(APP.SIM.ARR.time)];
APP.axes13.YLim = [0 1000];
APP.axes13.BackgroundColor = [0.5 0.5 0.5];
APP.axes13.XColor = [1 1 1];
APP.axes13.YColor = [1 1 1];
APP.axes13.XLabel.String = '(ms)';
APP.axes13.YLabel.String = 'Gradient (mT/m)';