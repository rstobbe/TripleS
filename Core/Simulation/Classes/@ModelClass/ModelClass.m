%================================================================
%  
%================================================================

classdef ModelClass < handle

    properties (SetAccess = private)                    
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
        % SetP2
        function SetP2(MOD,p2)  
            MOD.p2 = p2;
            RqiDistributions(MOD); 
        end        
    end
end
        