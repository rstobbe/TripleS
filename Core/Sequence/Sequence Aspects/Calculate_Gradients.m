function Calculate_Gradients

get_auto_grad = findobj('type','uicontrol','tag','auto_grad');
set(get_auto_grad,'value',1);

Set_Sequence_Interface;

set(get_auto_grad,'value',0);
