%========================================================
% 
%========================================================

function SaveModel(APP,Event)

%---------------------------------------------------
% Location
%---------------------------------------------------
ModChar = Event.Source.Tag(3);
Name = APP.(['SDModel',ModChar]).Value;
[file,path] = uiputfile('*.mat','Save Model',[APP.Paths.ModelPath,'\',Name]);
Name = strtok(file,'.');
if Name == 0
    return
end
APP.Paths.ModelPath = path;
APP.(['SDModel',ModChar]).Value = Name;

%---------------------------------------------------
% Structure
%---------------------------------------------------
SavedModel.Name = Name;
SavedModel.J0 = APP.(['J0',ModChar]).Value;
SavedModel.J1 = APP.(['J1',ModChar]).Value;
SavedModel.J2 = APP.(['J2',ModChar]).Value;
SavedModel.dist = APP.(['dist',ModChar]).Value;
SavedModel.p1 = APP.(['p1',ModChar]).Value;
SavedModel.p2 = APP.(['p2',ModChar]).Value;
SavedModel.nave = APP.(['nave',ModChar]).Value;

%---------------------------------------------------
% Save
%---------------------------------------------------
save([path,file],'SavedModel');








