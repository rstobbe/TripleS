%========================================================
% 
%========================================================

function SetOffResonance(APP,Event)

OffRes = str2double(Event.Source.Value);
APP.SIM.SetOffResonance(OffRes);
APP.SIM.BuildSequence;