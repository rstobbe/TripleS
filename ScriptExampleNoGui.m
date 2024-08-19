function ScriptExampleNoGui

%---------------------------------------------------
% General Setup
%---------------------------------------------------
SIM = SimObj;
SeqElements = 12;
SIM.InitializeSequence(SeqElements);
SeqModels = 1;
SIM.InitializeModel(SeqModels);

%---------------------------------------------------
% Base Model
%---------------------------------------------------
SavedModel = load('D:\TripleS\Models\SkinNa\SkinRqi1').SavedModel;
J0 = str2double(SavedModel.J0);
J1 = str2double(SavedModel.J1);
J2 = str2double(SavedModel.J2);
Dist = SavedModel.dist;
P1 = str2double(SavedModel.p1);
P2 = str2double(SavedModel.p2);
Nave = str2double(SavedModel.nave);

SIM.MOD(1).SetModel(J0M0,J1M0,J2M0,Dist,P1,P2,Nave);  
SIM.MOD(1).DisplayModelInit(TRPLS); 
SIM.MOD(1).DisplayModel(TRPLS); 

finish

% 
%     %---------------------------------------------------
%     % Sequences
%     %---------------------------------------------------
%     path = 'D:\CompassScripts\MERCURY\BuildDictionary\Underlying\Selectable Functions\Dictionary\Dictionary_SkinRegRqi221209V4_v1a\';
%     file{1} = '60S';
%     file{2} = '90S';
%     file{3} = '120S';
%     file{4} = '60M';
%     file{5} = '90M';
%     file{6} = '120M';
%     file{7} = '60L';
%     file{8} = '90L';
%     file{9} = '120L';
%     file{10} = 'IR3';
%     file{11} = 'IR40';
%     file{12} = '60SD8';        
%     
%     %---------------------------------------------------
%     % Base Model
%     %---------------------------------------------------
%     SavedModel = load('D:\TripleS\Models\SkinNa\SkinRqi1').SavedModel;
%     J0M0 = str2double(SavedModel.J0);
%     J1M0 = str2double(SavedModel.J1);
%     J2M0 = str2double(SavedModel.J2);
%     Dist = SavedModel.dist;
%     P1 = str2double(SavedModel.p1);
%     P2 = str2double(SavedModel.p2);
%     Nave = str2double(SavedModel.nave);
%     TRPLS.SIM.InitializeModel(3);
%     TRPLS.SIM.MOD(1).SetModel(J0M0,J1M0,J2M0,Dist,P1,P2,Nave);  
%     TRPLS.SIM.MOD(1).DisplayModelInit(TRPLS); 
%     TRPLS.SIM.MOD(1).DisplayModel(TRPLS); 
%     
%     DICT.DictSize = [length(file),length(DICT.Rsqi),length(DICT.RelB1),length(DICT.J0),length(DICT.J1),length(DICT.J2)];
%     DICT.ValsArray = zeros(DICT.DictSize);
% 
%     %---------------------------------------------------
%     % Build Dictionary
%     %---------------------------------------------------
%     for m = 1:length(file)
%         LoadSequenceSpecify(TRPLS,[path,file{m}]);
%         for n = 1:length(DICT.Rsqi)
%             TRPLS.SIM.MOD(1).SetP2(DICT.Rsqi(n));
%             TRPLS.SIM.MOD(1).DisplayModel(TRPLS);
%             for a = 1:length(DICT.J0)
%                 TRPLS.SIM.MOD(1).SetJ0(DICT.J0(a));
%                 for b = 1:length(DICT.J1)
%                     TRPLS.SIM.MOD(1).SetJ1(DICT.J1(b));
%                     for c = 1:length(DICT.J2)
%                         TRPLS.SIM.MOD(1).SetJ2(DICT.J2(c));
%                         TRPLS.SIM.MOD(1).DisplayModel(TRPLS);
%                         for p = 1:length(DICT.RelB1)
%                             TRPLS.SIM.SetRelB1(DICT.RelB1(p));
%                             TRPLS.SIM.DisplayRelB1(TRPLS);
%                             %DrawSequence(TRPLS);                               % too slow
%                             TRPLS.SIM.BuildSequence;
%                             TRPLS.SIM.Simulate;
%                             Vals = TRPLS.SIM.TeMxy;
%                             TRPLS.SIM.DispTeMxy(TRPLS,Vals);
%                             DICT.ValsArray(m,n,p,a,b,c) = Vals(1);
%                             drawnow;
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% 
% end
% end