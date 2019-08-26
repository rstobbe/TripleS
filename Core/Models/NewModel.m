%========================================================
% 
%========================================================

function NewModel(APP,Event)

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
ModChar = Event.Source.Tag(3);
APP.(['te_val',ModChar]).Enable = 'on';
APP.(['SDModel',ModChar]).Enable = 'on';
APP.(['J0',ModChar]).Enable = 'on';
APP.(['J1',ModChar]).Enable = 'on';
APP.(['J2',ModChar]).Enable = 'on';
APP.(['dist',ModChar]).Enable = 'on'; 
APP.(['p1',ModChar]).Enable = 'off';
APP.(['p2',ModChar]).Enable = 'off';
APP.(['nave',ModChar]).Enable = 'off';
APP.(['SDModel',ModChar]).Value = '';
APP.(['J0',ModChar]).Value = '0';
APP.(['J1',ModChar]).Value = '0';
APP.(['J2',ModChar]).Value = '0';
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







