%   2020 is a year of history.
%   2020 is an extraordinary year.
%   2020/4/4 Global cumulative number of COVID-19 exceeded 1 million.
%   we love earth,we hope world peace.
%   The wind in March, the rain in April,
%   may the mountains and rivers be innocent and the world be safe
%   an Ordinary little man.ZS.Z, 2020 @ HOME.
clf reset;clear;close all;warning('off');
screen=get(0,'ScreenSize');
W=screen(3);H=screen(4);
main_p = [0.1*W,0.1*H,0.5*W,0.5*H];
statelabel_p = [0.6*W,0.65*H,0.05*W,0.02*H];
stateedit_p = [0.574*W,0.05*H,0.1*W,0.6*H];
hmain = figure('Color',[1,1,1],'Position',main_p,...
    'Name','��С������Դ�������ݼ������V2.0','NumberTitle','off','MenuBar','none');
try
v = ver('MATLAB');
v = str2double(regexp(v.Version, '\d.\d','match','once'));
if (v<7)
  warndlg('Your MATLAB version is too old. You need version 10.0 or newer.');
end
newIcon = javax.swing.ImageIcon('./icon/ccicon.png');
figFrame = get(hmain,'JavaFrame');  %ȡ��Figure��JavaFrame��
figFrame.setFigureIcon(newIcon);    %�޸�ͼ��
hwb = waitbar(0,'���ڳ�ʼ�������Ժ� >>>>','position',[0.15*W,0.4*H/2,0.5*W/2.8,0.5*H/10]);
if ~exist([cd,'\','config']) 
    mkdir([cd,'\','config'])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��config��,������в���
end
if ~exist([cd,'\','config\config.xml'],'file')
    Create_config_default();
end
if ~exist([cd,'\','pathinp']) 
    mkdir([cd,'\','pathinp'])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��pathinp�������������ı�.inp
end
if ~exist([cd,'\','figure']) 
    mkdir([cd,'\','figure'])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��figure�������ɵ�ͼƬ
end 
if ~exist([cd,'\','result']) 
    mkdir([cd,'\','result'])         % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��result�����������ò���
end
if ~exist([cd,'\','temp']) 
    mkdir([cd,'\','temp'])           % �������ڣ��ڵ�ǰĿ¼�в���һ����Ŀ¼��temp���������ʱ����
else
    rmdir([cd,'\','temp'],'s')
    mkdir([cd,'\','temp'])  
end
for step = 1:1000
   waitbar(step/1000) 
end
close(hwb);
catch ErrorInfo
    msgbox(ErrorInfo.message);
end
if ~isempty(which('pso.m'))%�Ƿ���pso������
    addpath('./psopt');%�������Ⱥ������
end
if ~isempty(which('ga.m'))%�Ƿ���pso������
    addpath('./gaot');%�������Ⱥ������
end
try
h_mainmenu0 = uimenu(gcf,'label','�ļ�');
    h_submenu01 = uimenu(h_mainmenu0,'label','������ҳ..','callback','Run_Main()');
    h_submenu02 = uimenu(h_mainmenu0,'label','ˢ��..','callback','h_axes=findobj(gcf,''type'',''axes''); delete(h_axes);fclose(''all'');');
    h_submenu03 = uimenu(h_mainmenu0,'label','�˳�..','callback','ExitMain()');
    
h_mainmenu1 = uimenu(gcf,'label','����');
h_submenu11 = uimenu(h_mainmenu1,'label','���������Զ�����');
    h_submenu111 = uimenu(h_submenu11,'label','���벨��..','callback','Loadwave();');
    h_submenu112 = uimenu(h_submenu11,'label','����۲ⱨ��..','callback','Loadreport();');
    h_submenu113 = uimenu(h_submenu11,'label','���м���..','callback','Single_eq_cal();');
h_submenu12 = uimenu(h_mainmenu1,'label','�����Զ�����','callback','Cal_Batch();');
%     h_submenu13 = uimenu(h_mainmenu1,'label','�𲽼���','callback','set(gcf,''Color'',''y'')');

h_mainmenu6 = uimenu(gcf,'label','��ͼ');
    % �ٶ��׺ͼ��ٶ��׸���ƽ����
    h_submenu61 = uimenu(h_mainmenu6,'label','����Ҷ��');% ��̨վ�׺�ƽ����Դ��
        h_submenu611 = uimenu(h_submenu61,'label','�ٶ���','callback','plt_spectrum(1)');
        h_submenu612 = uimenu(h_submenu61,'label','λ����','callback','plt_spectrum(2)');
        h_submenu613 = uimenu(h_submenu61,'label','���ٶ���','callback','plt_spectrum(3)');
    % ���ݽ��������С���˷���pso����������ͬ���ͼ
%     h_submenu63 = uimenu(h_mainmenu6,'label','���ݽ��','callback','plt_result');
    h_submenu64 = uimenu(h_mainmenu6,'label','�ײ���','callback','plt_ssp()');
    h_submenu65 = uimenu(h_mainmenu6,'label','��Դ����','callback','plt_sspara()');
h_mainmenu2 = uimenu(gcf,'label','��������');
    h_submenu21 = uimenu(h_mainmenu2,'label','�ļ�·������','callback','Creat_inp()');
    h_submenu22 = uimenu(h_mainmenu2,'label','��������ϲ�','callback','Creat_outpara()');
    h_submenu23 = uimenu(h_mainmenu2,'label','�ָ����в���ȱʡֵ','callback','Create_config_default()');
    h_submenu24 = uimenu(h_mainmenu2,'label','�ָ�����ȱʡֵ','callback','set(gcf,''Color'',''w'')');
h_mainmenu3 = uimenu(gcf,'label','����');
    h_submenu31 = uimenu(h_mainmenu3,'label','Ԥ�����������','callback','Set_Pre_Para();');
    h_submenu32 = uimenu(h_mainmenu3,'label','���в�������','callback','Set_Cal_Para()');
    h_submenu33 = uimenu(h_mainmenu3,'label','���ù�����');
            h_submenu331 = uimenu(h_submenu33,'label','����������','callback','set(gcf,''toolbar'',''figure'')');
            h_submenu332 = uimenu(h_submenu33,'label','�رչ�����','callback','set(gcf,''toolbar'',''none'')');
    h_submenu34 = uimenu(h_mainmenu3,'label','������ɫ','callback','set(gcf,''Color'',[rand rand rand])');
h_mainmenu5 = uimenu(gcf,'label','����');
    h_submenu51 = uimenu(h_mainmenu5,'label','���˵��','callback','contact()');
    h_submenu52 = uimenu(h_mainmenu5,'label','�����ĵ�','callback','Helprun()');
%     h_egg2 = axes('Parent',hmain);
%     set(h_egg2,'Position',[0.5 0.999 0.01 0.01]);
%     c = get(gcf,'Color');
%     h_egg2.YAxis.Visible = 'off';h_egg2.XAxis.Visible = 'off';
%     hc_egg2=uicontextmenu();                         %������ݲ˵�hc
%     h_egg2.UIContextMenu = hc_egg2;
%     mhsub1=uimenu(hc_egg2,'Label','Easter egg','CallBack','egg2'); % �ʵ�2
    hc_main = uicontextmenu();
    hmain.UIContextMenu = hc_main;
    mhsub1=uimenu(hc_main,'Label','save to png','CallBack','savefigure(1)'); % ���png
    mhsub1=uimenu(hc_main,'Label','save to fig','CallBack','savefigure(2)'); % ���fig
    mhsub1=uimenu(hc_main,'Label','save to eps','CallBack','savefigure(3)'); % ���eps
catch
end