%========================================================
% 
%========================================================

function LoadModel(APP,Event)

%---------------------------------------------------
% Location
%---------------------------------------------------
ModChar = Event.Source.Tag(3);
[file,path] = uigetfile('*.mat','Load Model',[APP.Paths.ModelPath,'\*.mat']);
Name = strtok(file,'.');
if Name == 0
    return
end
APP.Paths.ModelPath = path;
APP.(['SDModel',ModChar]).Value = Name;

%---------------------------------------------------
% Load
%---------------------------------------------------
load([path,file],'SavedModel');

%---------------------------------------------------
% Structure
%---------------------------------------------------
SavedModel.Name = Name;
APP.(['J0',ModChar]).Value = SavedModel.J0;
APP.(['J1',ModChar]).Value = SavedModel.J1;
APP.(['J2',ModChar]).Value = SavedModel.J2;
APP.(['dist',ModChar]).Value = SavedModel.dist;
APP.(['p1',ModChar]).Value = SavedModel.p1;
APP.(['p2',ModChar]).Value = SavedModel.p2;
APP.(['nave',ModChar]).Value = SavedModel.nave;

%---------------------------------------------------
% update UI visibility
%---------------------------------------------------
APP.(['te_val',ModChar]).Enable = 'on';
APP.(['SDModel',ModChar]).Enable = 'on';
APP.(['J0',ModChar]).Enable = 'on';
APP.(['J1',ModChar]).Enable = 'on';
APP.(['J2',ModChar]).Enable = 'on';
APP.(['dist',ModChar]).Enable = 'on';
if strcmp(SavedModel.dist,'None')
    APP.(['p1',ModChar]).Enable = 'off';
    APP.(['p2',ModChar]).Enable = 'off';
    APP.(['nave',ModChar]).Enable = 'off';
elseif strcmp(SavedModel.dist,'Delta')
    APP.(['p1',ModChar]).Enable = 'on';
    APP.(['p2',ModChar]).Enable = 'off';
    APP.(['nave',ModChar]).Enable = 'off';
elseif strcmp(SavedModel.dist,'Gaussian')
    APP.(['p1',ModChar]).Enable = 'on';
    APP.(['p2',ModChar]).Enable = 'on';
    APP.(['nave',ModChar]).Enable = 'on';
else
    error;              % finish
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








