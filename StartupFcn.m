%========================================================
% 
%========================================================

function StartupFcn(APP)

%currentdir = cd;
currentdir = 'D:\Compass\6 TripleS';
addpath(genpath(currentdir));

%--------------------------------------------------------
% Paths
%--------------------------------------------------------
APP.Paths.ModelPath = [currentdir,'\Models'];
APP.Paths.SequencePath = [currentdir,'\Sequences'];

%--------------------------------------------------------
% Simulation Object
%--------------------------------------------------------
APP.SIM = SimObj;
GuiSeqElements = 12;
APP.SIM.InitializeSequence(GuiSeqElements);
GuiSeqModels = 3;
APP.SIM.InitializeModel(GuiSeqModels);

%--------------------------------------------------------
% Create Sequence Element Identifiers
%--------------------------------------------------------
for n = 1:12
    num = num2str(n,'%02.0f');
    APP.(['type',num]).Tag = ['t',num];
    APP.(['length',num]).Tag = ['l',num];
    APP.(['shape',num]).Tag = ['s',num];
    APP.(['idealflip',num]).Tag = ['i',num];
    APP.(['phase',num]).Tag = ['p',num];
    APP.(['grads',num]).Tag = ['g',num];
    APP.(['pphasecyc',num]).Tag = ['c',num];
    APP.(['step',num]).Tag = ['s',num];
end

%--------------------------------------------------------
% Create Model Identifiers
%--------------------------------------------------------
for n = 1:3
    num = num2str(n);
    APP.(['J0',num]).Tag = ['j0',num];
    APP.(['J1',num]).Tag = ['j1',num];
    APP.(['J2',num]).Tag = ['j2',num];
    APP.(['dist',num]).Tag = ['di',num];
    APP.(['p1',num]).Tag = ['p1',num];
    APP.(['p2',num]).Tag = ['p2',num];
    APP.(['nave',num]).Tag = ['na',num];
end

%--------------------------------------------------------
% Create ModelButton Identifiers
%--------------------------------------------------------
for n = 1:3
    num = num2str(n);
    APP.(['SDModel',num]).Tag = ['sdm',num];
    APP.(['Load_Model',num]).Tag = ['lm',num];
    APP.(['New_Model',num]).Tag = ['nm',num];
    APP.(['Unload_Model',num]).Tag = ['um',num];
    APP.(['Save_Model',num]).Tag = ['sm',num];
end

%--------------------------------------------------------
% Create Default Model
%--------------------------------------------------------
J0 = str2double(APP.J01.Value);
J1 = str2double(APP.J11.Value);
J2 = str2double(APP.J21.Value);
dist = APP.dist1.Value;
p1 = str2double(APP.p11.Value);
p2 = str2double(APP.p21.Value);
Nave = str2double(APP.nave1.Value);
if isnan(p1)
    p1 = 0;
end
if isnan(p2)
    p2 = 0;
end
if isnan(Nave)
    Nave = 1;
end
APP.SIM.MOD(1).SetModel(J0,J1,J2,dist,p1,p2,Nave);

%--------------------------------------------------------
% Create PlotModel Identifiers
%--------------------------------------------------------
for n = 1:6
    num = num2str(n);
    APP.(['modelnum',num]).Tag = ['m',num];
end

%--------------------------------------------------------
% Use Global to 'Talk' between Programs
%--------------------------------------------------------
global GblAPP   
GblAPP = APP;
