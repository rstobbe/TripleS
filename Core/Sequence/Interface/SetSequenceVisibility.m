%========================================================
% 
%========================================================

function SetSequenceVisibility(APP,SeqElmChar,Value)

switch Value

    case 'Don''t Use'        
        APP.(['length',SeqElmChar]).Visible = 'off';
        APP.(['shape',SeqElmChar]).Visible = 'off';
        APP.(['idealflip',SeqElmChar]).Visible = 'off';
        APP.(['phase',SeqElmChar]).Visible = 'off';
        APP.(['grads',SeqElmChar]).Visible = 'off';
        APP.(['pphasecyc',SeqElmChar]).Visible = 'off';
        APP.(['step',SeqElmChar]).Visible = 'off';
        
    case 'Delay'     
        APP.(['length',SeqElmChar]).Visible = 'on';
        APP.(['shape',SeqElmChar]).Visible = 'off';
        APP.(['idealflip',SeqElmChar]).Visible = 'off';
        APP.(['phase',SeqElmChar]).Visible = 'off';
        APP.(['grads',SeqElmChar]).Visible = 'off';
        APP.(['pphasecyc',SeqElmChar]).Visible = 'off';
        APP.(['step',SeqElmChar]).Visible = 'on';

    case 'Pulse'    
        APP.(['length',SeqElmChar]).Visible = 'on';
        APP.(['shape',SeqElmChar]).Visible = 'on';
        APP.(['idealflip',SeqElmChar]).Visible = 'on';
        APP.(['phase',SeqElmChar]).Visible = 'on';
        APP.(['grads',SeqElmChar]).Visible = 'off';
        APP.(['pphasecyc',SeqElmChar]).Visible = 'on';
        APP.(['step',SeqElmChar]).Visible = 'on';

    case 'Gradient '    
        APP.(['length',SeqElmChar]).Visible = 'on';
        APP.(['shape',SeqElmChar]).Visible = 'off';
        APP.(['idealflip',SeqElmChar]).Visible = 'off';
        APP.(['phase',SeqElmChar]).Visible = 'off';
        APP.(['grads',SeqElmChar]).Visible = 'on';
        APP.(['pphasecyc',SeqElmChar]).Visible = 'off';
        APP.(['step',SeqElmChar]).Visible = 'on';

    case 'PulseGrad'    
        APP.(['length',SeqElmChar]).Visible = 'on';
        APP.(['shape',SeqElmChar]).Visible = 'on';
        APP.(['idealflip',SeqElmChar]).Visible = 'on';
        APP.(['phase',SeqElmChar]).Visible = 'on';
        APP.(['grads',SeqElmChar]).Visible = 'on';
        APP.(['pphasecyc',SeqElmChar]).Visible = 'on';
        APP.(['step',SeqElmChar]).Visible = 'on';

    case 'Acquire'
        APP.(['length',SeqElmChar]).Visible = 'on';
        APP.(['shape',SeqElmChar]).Visible = 'off';
        APP.(['idealflip',SeqElmChar]).Visible = 'off';
        APP.(['phase',SeqElmChar]).Visible = 'on';
        APP.(['grads',SeqElmChar]).Visible = 'off';
        APP.(['pphasecyc',SeqElmChar]).Visible = 'on';
        APP.(['step',SeqElmChar]).Visible = 'on';    
end




