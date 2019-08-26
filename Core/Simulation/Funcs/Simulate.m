%========================================================
% 
%========================================================

function Simulate(APP,Event)

%---------------------------------------------------
% Test
%---------------------------------------------------
ARR = APP.SIM.ARR;
if isempty(ARR)
    return
end

%---------------------------------------------------
% Simulate
%---------------------------------------------------
APP.go.BackgroundColor = [0 1 0];
drawnow;
APP.SIM.Simulate;
% Vals = APP.SIM.TeT11s;
% for n = 1:3
%     APP.(['te_val',num2str(n)]).Value = num2str(Vals(n));
%     if Vals(n) == 0
%         APP.(['te_val',num2str(n)]).Value = '';
%     end
% end
APP.go.BackgroundColor = [0.96 0.96 0.96];