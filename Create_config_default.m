function Create_config_default()
% Create_config_xml Summary of this function goes here
% Creat a congig.xml if current directory isnot exist;
% Written by zs zhang
% $Revision: 1.0 $  $Date: 2020/03/31 $
    config=[];
    config.softinfo.application      = '��С������Դ�����Ƚ����ݳ������в�������';
    config.softinfo.development_unit = 'ɽ��ʡ����Ԥ���о�����';
    config.softinfo.version          = 'ver2.0 beta';
    config.softinfo.author.developer = 'zhangzs';
    config.softinfo.author.contact   = '858488045@qq.com';
    %% ������������
    config.data.waveform                = 1;            % waveform format,.evt(supported now)  .sac  .seed
    config.data.reportform              = 1;            % reportfile for one event download from "ȫ����Ŀϵͳ"
    config.data.stanum                  = 4;            % ƽ����Դ������̨վ��Ŀ
    %% Ԥ����
    config.preprocessing.Qf_a           = 363.9;          % Q value:Anelastic attenuation adjesting
    config.preprocessing.Qf_b           = 1.3741;          % Q(f) = a*f^b;
    config.preprocessing.gatten         = 1;            % ����˥����G(R)=R^(-1)(supported now) or �������Իع� 
    config.preprocessing.resp     = 1;            % ������Ӧ��Amplitude frequency = 1;
    config.preprocessing.site           = 1;            % ������Ӧ��site response = 1;               
    %% ���ν�ȡ���任
    config.signal.fftnum   = 1024;  % 2^n��e.g. 512��1024��2048��etc.
    config.signal.wavetype = 2;   % 1-'S' or 2-'P'
    config.signal.delay = 1;
    %%
    config.model = 1; % 1-Brune model;2-High-Cut model
    %% ��Ϸ�ʽ
    config.invert = 1;  % ��������С������� & PSO ����ȺѰ���㷨
    %% ��Դ�������㾭��ֵ
    config.ssp.density = 2.67;   % �����ܶ�g/cm^3��
    config.ssp.velocity = 3.2;   % S���ٶ� km/s������wavetyep = 'P',ע���޴˴�ΪP���ٶ�
    config.ssp.radiation = 0.41; % S���������ӣ�stork A L.,2004��
    %% 
    Write_xml(['./config/','config','.xml'],config);
end

