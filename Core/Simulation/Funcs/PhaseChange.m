%========================================================
% 
%========================================================

function [Tout] = PhaseChange(A,Tin)

A = (A/180)*pi;

Tout = zeros(size(Tin));
Tout(1,:) = Tin(1,:);
Tout(2,:) = Tin(2,:);
Tout(3,:) = Tin(3,:)*cos(A) + 1i*Tin(4,:)*sin(A);
Tout(4,:) = 1i*Tin(3,:)*sin(A) + Tin(4,:)*cos(A);
Tout(5,:) = Tin(5,:);
Tout(6,:) = Tin(6,:)*cos(A) + 1i*Tin(7,:)*sin(A);
Tout(7,:) = 1i*Tin(6,:)*sin(A) + Tin(7,:)*cos(A);
Tout(8,:) = Tin(8,:)*cos(2*A) + 1i*Tin(9,:)*sin(2*A);
Tout(9,:) = 1i*Tin(8,:)*sin(2*A) + Tin(9,:)*cos(2*A);
Tout(10,:) = Tin(10,:);
Tout(11,:) = Tin(11,:)*cos(A) + 1i*Tin(12,:)*sin(A);
Tout(12,:) = 1i*Tin(11,:)*sin(A) + Tin(12,:)*cos(A);
Tout(13,:) = Tin(13,:)*cos(2*A) + 1i*Tin(14,:)*sin(2*A);
Tout(14,:) = 1i*Tin(13,:)*sin(2*A) + Tin(14,:)*cos(2*A);
Tout(15,:) = Tin(15,:)*cos(3*A) + 1i*Tin(16,:)*sin(3*A);
Tout(16,:) = 1i*Tin(15,:)*sin(3*A) + Tin(16,:)*cos(3*A);