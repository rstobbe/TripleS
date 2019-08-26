%========================================================
% 
%========================================================

function SetModelInterface(APP,Event)

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
ModId = Event.Source.Tag(1:2);
ModChar = Event.Source.Tag(3);
Value = Event.Source.Value;
if strcmp(ModId,'di')
    if strcmp(Value,'None')
        APP.(['p1',ModChar]).Enable = 'off';
        APP.(['p2',ModChar]).Enable = 'off';
        APP.(['nave',ModChar]).Enable = 'off';
        APP.(['p1',ModChar]).Value = '';
        APP.(['p2',ModChar]).Value = '';
        APP.(['nave',ModChar]).Value = '';
    elseif strcmp(Value,'Delta')
        APP.(['p1',ModChar]).Enable = 'on';
        APP.(['p2',ModChar]).Enable = 'off';
        APP.(['nave',ModChar]).Enable = 'off';
        APP.(['p1',ModChar]).Value = '0';
        APP.(['p2',ModChar]).Value = '';
        APP.(['nave',ModChar]).Value = '';
    elseif strcmp(Value,'Gaussian')
        APP.(['p1',ModChar]).Enable = 'on';
        APP.(['p2',ModChar]).Enable = 'on';
        APP.(['nave',ModChar]).Enable = 'on';
        APP.(['p1',ModChar]).Value = '0';
        APP.(['p2',ModChar]).Value = '0';
        APP.(['nave',ModChar]).Value = '100';
    elseif strcmp(Value,'Powder')
        APP.(['p1',ModChar]).Enable = 'on';
        APP.(['p2',ModChar]).Enable = 'off';
        APP.(['nave',ModChar]).Enable = 'on';
        APP.(['p1',ModChar]).Value = '0';
        APP.(['p2',ModChar]).Value = '';
        APP.(['nave',ModChar]).Value = '100';
    else
        error;              % finish
    end
end

%---------------------------------------------------
% update SimObj
%---------------------------------------------------
Mod = str2double(ModChar);
J0 = str2double(APP.(['J0',ModChar]).Value);
J1 = str2double(APP.(['J1',ModChar]).Value);
J2 = str2double(APP.(['J2',ModChar]).Value);
dist = APP.(['dist',ModChar]).Value;
p1 = str2double(APP.(['p1',ModChar]).Value);
p2 = str2double(APP.(['p2',ModChar]).Value);
Nave = str2double(APP.(['nave',ModChar]).Value);
if isnan(p1)
    p1 = 0;
end
if isnan(p2)
    p2 = 0;
end
if isnan(Nave)
    Nave = 1;
end

APP.SIM.MOD(Mod).SetModel(J0,J1,J2,dist,p1,p2,Nave);





