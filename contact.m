function contact()
% ��ϵ��ʽ˵��
%
% contact()
%
% input:
% output:
% e.g.contanct()
try
    hhelp = helpdlg('ɽ��ʡ����Ԥ���о����ı��ƣ���ϵQQ ��858488045','˵��');
catch ErrorInfo
    errordlg(ErrorInfo.message,'error warning')
end
end