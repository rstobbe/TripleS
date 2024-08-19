%========================================================
% 
%========================================================

function SetReps(APP,Value)

APP.SIM.SetReps(str2double(Value));
APP.SIM.BuildSequence;