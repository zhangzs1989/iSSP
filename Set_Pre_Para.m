function Set_Pre_Para()
try
prompt0 = {                                                         % �Ի������
    '������Ӧ��1-\it{default}��2-\it{��ȥ������Ӧ}��',1
    '����˥����1-\it{G(R)=R^{-1}}��2-\it{���ο۳�}��',1
    '�ǵ���˥����Q(f)=a*f^b��ϵ��aֵ��',300
    '�ǵ���˥����Q(f)=a*f^b��ϵ��bֵ��',0.5
    '������Ӧ��1-\it{default};2-\it{���볡����Ӧ�ļ�}��',1
};
% defaultans = {'1','2','3','4'};
% inputdlg(prompt0,'Ԥ����',1,defaultans)
dlg0.width = 50;
dlg0.title = 'Ԥ����';
dlg0.auto = 0;
para = Paradlg(prompt0,dlg0);
try 
set_resp = para{1};set_GR = para{2};set_Qf1 = para{3}; 
set_Qf2 = para{4};set_site = para{5};
catch ErrorInfo
    msgbox(ErrorInfo.message)
end
try
[tree, RootName , ~] = Read_xml('./config/config.xml');
tree.preprocessing.gatten = set_GR;
tree.preprocessing.resp = set_resp;
tree.preprocessing.site = set_site;
tree.preprocessing.Qf_a = set_Qf1;
tree.preprocessing.Qf_b = set_Qf2;
Write_xml('./config/config.xml',tree,RootName);
catch ErrorInfo
    msgbox(ErrorInfo.message) 
end
end