%===================================================
% Calculate last delay to give wanted TR
%===================================================

function [error] = Adjust_Seq_TRep

error = 0;
[C1,C2,C3,C4,C5,C6,C7,C8,C9] = Init_Comments;
Seq = Sequence_Structure;

n = length(Seq);
Tau = 0;
for k = 1:n-1
   Tau = Tau + Seq(k).length;
end

x = findobj('type','uicontrol','tag','TRep');
TRep = str2num(get(x,'string'));

if Seq(n).type ~= 2
    return;
else
    T = TRep - Tau;
    if T < 0.00001
        set(C1,'String','TRep not possible');
        set(C1,'BackgroundColor',[1 0 0]);
        set(C1,'ForegroundColor',[1 1 1]);
        error = 1;
    return;
    end
    len = { 'length01';
            'length02';
            'length03';
            'length04';
            'length05';
            'length06';
            'length07';
            'length08';
            'length09';
            'length10';
            'length11';
            'length12'};
    m = n;
    for j=1:9
        tag = findobj('type','uicontrol','tag',strcat('type0',num2str(j)));
        val = get(tag,'Value');
        if val == 1
            n = n+1;
        else
            m = m-1;
        end
        if m == 0
            break
        end
    end    
    tag = findobj('type','uicontrol','tag',char(len(n)));
    set(tag,'string',num2str(T));
end

Set_Sequence_Interface;

