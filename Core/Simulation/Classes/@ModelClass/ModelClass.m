%================================================================
%  
%================================================================

classdef ModelClass < handle

    properties (SetAccess = private)                    
        ModNum;
        J0; J1; J2;
        dist; p1; p2; 
        Nave;
        wq; wgt;
    end

%==================================================================
% Init
%==================================================================    
    methods 
        % ModelClass
        function MOD = ModelClass(Length)
            if nargin ~= 0
                MOD(Length) = ModelClass;
                for n = 1:Length
                    MOD(n).ModNum = n;
                end
            end
        end

%==================================================================
% Set
%==================================================================          
        % SetModel
        function SetModel(MOD,J0,J1,J2,dist,p1,p2,Nave)
            MOD.J0 = J0;
            MOD.J1 = J1;
            MOD.J2 = J2;
            MOD.dist = dist;
            MOD.p1 = p1;                
            MOD.p2 = p2;
            MOD.Nave = Nave;
            RqiDistributions(MOD);   
        end
        % SetJ0
        function SetJ0(MOD,J0)  
            MOD.J0 = J0;
        end
        % SetJ1
        function SetJ1(MOD,J1)  
            MOD.J1 = J1;
        end
        % SetJ2
        function SetJ2(MOD,J2)  
            MOD.J2 = J2;
        end
        % SetJ12
        function SetJ12(MOD,JN)  
            MOD.J1 = JN;
            MOD.J2 = JN;
        end
        % SetJ012
        function SetJ012(MOD,JN)  
            MOD.J0 = JN;
            MOD.J1 = JN;
            MOD.J2 = JN;
        end
        % SetP1
        function SetP1(MOD,p1)  
            MOD.p1 = p1;
            RqiDistributions(MOD); 
        end
        % SetP2
        function SetP2(MOD,p2)  
            MOD.p2 = p2;
            RqiDistributions(MOD); 
        end
        % SetDist
        function SetDist(MOD,dist)  
            MOD.dist = dist;
            RqiDistributions(MOD); 
        end

%==================================================================
% Display
%==================================================================           
        % DisplayModelInit
        function DisplayModelInit(MOD,APP)  
            ModChar = num2str(MOD.ModNum);
            if strcmp(MOD.dist,'None')
                APP.(['p1',ModChar]).Enable = 'off';
                APP.(['p2',ModChar]).Enable = 'off';
                APP.(['nave',ModChar]).Enable = 'off';
                APP.(['p1',ModChar]).Value = '';
                APP.(['p2',ModChar]).Value = '';
                APP.(['nave',ModChar]).Value = '';
            elseif strcmp(MOD.dist,'Delta')
                APP.(['p1',ModChar]).Enable = 'on';
                APP.(['p2',ModChar]).Enable = 'off';
                APP.(['nave',ModChar]).Enable = 'off';
                APP.(['p1',ModChar]).Value = '0';
                APP.(['p2',ModChar]).Value = '';
                APP.(['nave',ModChar]).Value = '';
            elseif strcmp(MOD.dist,'Gaussian')
                APP.(['p1',ModChar]).Enable = 'on';
                APP.(['p2',ModChar]).Enable = 'on';
                APP.(['nave',ModChar]).Enable = 'on';
                APP.(['p1',ModChar]).Value = '0';
                APP.(['p2',ModChar]).Value = '0';
                APP.(['nave',ModChar]).Value = '100';
            elseif strcmp(MOD.dist,'Powder')
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
        % DisplayModel 
        function DisplayModel(MOD,APP)  
            ModChar = num2str(MOD.ModNum);
            APP.(['J0',ModChar]).Value = num2str(MOD.J0);
            APP.(['J1',ModChar]).Value = num2str(MOD.J1);
            APP.(['J2',ModChar]).Value = num2str(MOD.J2);
            APP.(['dist',ModChar]).Value = MOD.dist;
            APP.(['p1',ModChar]).Value = num2str(MOD.p1);
            APP.(['p2',ModChar]).Value = num2str(MOD.p2);            
            APP.(['nave',ModChar]).Value = num2str(MOD.Nave);   
        end
        % ActivateModel
        function ActivateModel(MOD,APP)
            ModChar = num2str(MOD.ModNum);
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
        end
    end
end
        