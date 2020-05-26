function [rpt_path_name] = Loadreport(varargin)
% LOADWAVE Summary of this function goes here
% loadreport:����۲ⱨ��,��Ӧ��Ӧ�ĵ����¼��۲Ⲩ��
% �������С��1����Ĭ��Ϊȫ����Ŀϵͳ��������ʽ�۲ⱨ�棬֧�ֶ�������¼�
% ���������1-�й���Ŀϵͳ�����Ĺ۲ⱨ�桢2-else����ʽδ���壬�������䣩
try
    if nargin > 1
        msgbox('���������ʽ���࣡', '��ʾ');
    else
        if nargin == 0
            rpttype = 1;
            [filename,filepath] = uigetfile('.txt','Select an report file');
        end
        if nargin == 1
            rpttype = varargin{1};
           switch rpttype
                case 1
                    type =  '.txt';
                case 2
                    type =  '.nuknow'; 
           end
            [filename,filepath] = uigetfile(type,['Select an report file']);
        end
        if ~isequal(filename,0) && ~isequal(filepath,0)
                msgbox('��ȡ�۲ⱨ���ļ�·���ɹ���','������ʾ')
                rpt_path_name = [filepath,filename];
            else
                warndlg('��ȡ�۲ⱨ��ʧ��','������ʾ')
        end
    end
    save('./temp/rpt_path_name.mat','rpt_path_name');
catch
end
end

