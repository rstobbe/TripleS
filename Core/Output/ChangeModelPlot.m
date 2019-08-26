%========================================================
% 
%========================================================

function ChangeModelPlot(APP,Event)

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
ModPlotChar = Event.Source.Tag(2);
Value = Event.Source.Value;
if strcmp(Value,'Don''t Use')
    APP.(['observe',ModPlotChar]).Enable = 'off';
    APP.(['linetype',ModPlotChar]).Enable = 'off';
else
    APP.(['observe',ModPlotChar]).Enable = 'on';
    APP.(['linetype',ModPlotChar]).Enable = 'on';
end
