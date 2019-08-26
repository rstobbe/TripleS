%========================================================
% 
%========================================================

function UnloadModel(APP,Event)

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
ModChar = Event.Source.Tag(3);
APP.(['te_val',ModChar]).Enable = 'off';
APP.(['J0',ModChar]).Enable = 'off';
APP.(['J1',ModChar]).Enable = 'off';
APP.(['J2',ModChar]).Enable = 'off';
APP.(['dist',ModChar]).Enable = 'off'; 
APP.(['p1',ModChar]).Enable = 'off';
APP.(['p2',ModChar]).Enable = 'off';
APP.(['nave',ModChar]).Enable = 'off';
APP.(['SDModel',ModChar]).Value = '';
APP.(['J0',ModChar]).Value = '';
APP.(['J1',ModChar]).Value = '';
APP.(['J2',ModChar]).Value = '';
APP.(['dist',ModChar]).Value = 'None'; 
APP.(['p1',ModChar]).Value = '';
APP.(['p2',ModChar]).Value = '';
APP.(['nave',ModChar]).Value = '';

%---------------------------------------------------
% update SimObj
%---------------------------------------------------
Mod = str2double(ModChar);
J0 = [];
J1 = [];
J2 = [];
dist = '';
p1 = [];
p2 = [];
Nave = [];
APP.SIM.MOD(Mod).SetModel(J0,J1,J2,dist,p1,p2,Nave);





