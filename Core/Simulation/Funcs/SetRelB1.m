%========================================================
% 
%========================================================

function SetRelB1(APP,Value)

APP.SIM.SetRelB1(str2double(Value));
APP.SIM.BuildSequence;
DrawSequence(APP);