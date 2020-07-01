function Set_Cal_Para()
try
prompt0 = {                                                         % �Ի������
    '��Դģ�͡�1-\it{Brune(\omega^{-2})}; 2-\it{High-Cut};3-\it{Brune2(w^{-\gamma})}��',1
    '��Ϸ��ݡ�1-\it{��С���˷�}�� 2-\it{��С�в�}; 3-\it{����ȺѰ���㷨};��',1
    '�������ݸ�ʽ��1-\it{evt(only supported now)}; 2-\it{SAC}; 3-\ot{SEED}��',1
    'ƽ��������̨վ��Ŀ��һ��stationnum��4��',4
    '�۲ⱨ���ʽ��1-\it{ȫ����Ŀϵͳ��������ʽ�۲ⱨ��}��',1
    '��ȡ�������͡�1-\it{P��}�� 2-\it{S��}��',2
    '��ʱ��ƫ��ʱ�䡾\it{s}��',1
    '���ٸ���Ҷ�任������e.g. 512, 1024, 2048��',1024
    '�����ܶȡ�\it{g/cm^3}��',2.67
    '�����ٶȡ�\it{km/s����',3.2
    '��������',0.41
};
% defaultans = {'1','2','1','1','2','1024','2.67','3.2','0.41'};
dlg0.width = 80;
dlg0.title = '�����������';
dlg0.auto = 0;
para = Paradlg(prompt0,dlg0);
try 
set_model = para{1};set_fit = para{2};set_waveformat = para{3};set_stanum = para{4};                                                       
set_rpttype = para{5}; set_wavetype = para{6};set_delay = para{7};set_fftnum = para{8};
set_density = para{9};set_velocity = para{10};set_radiation = para{11};
catch ErrorInfo
    msgbox(ErrorInfo.message)
end
try
[tree, RootName , ~] = Read_xml('./config/config.xml');
tree.signal.fftnum = set_fftnum;tree.signal.wavetype = set_wavetype;tree.signal.delay = set_delay;
tree.model = set_model;tree.invert = set_fit;
tree.data.waveform = set_waveformat;tree.data.reportform = set_rpttype;tree.data.stanum = set_stanum;
tree.ssp.density = set_density;tree.ssp.velocity = set_velocity;tree.ssp.radiation = set_radiation;
Write_xml('./config/config.xml',tree,RootName);
catch ErrorInfo
    msgbox(ErrorInfo.message)
end
catch  
end
end